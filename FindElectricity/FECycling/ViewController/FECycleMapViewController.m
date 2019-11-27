//
//  FECycleMapViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/9.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FECycleMapViewController.h"
#import "FECycleMap.h"
#import "FEPointAnnotation.h"
#import "FEMapManager.h"
@interface FECycleMapViewController ()<MAMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) FECycleMap *mapView;
@property (assign, nonatomic) CLLocation *currentLocat;

@property (weak, nonatomic) IBOutlet UILabel *currentElec;
@property (weak, nonatomic) IBOutlet UILabel *speed;
@property (weak, nonatomic) IBOutlet UILabel *currentKM;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (nonatomic, strong) FEPointAnnotation *pointAnnotaiton;
@property (nonatomic, strong) dispatch_semaphore_t lock;
@end

@implementation FECycleMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _lock = dispatch_semaphore_create(1);
//    CLLocation *start = [[CLLocation alloc] initWithLatitude:_startCoord.latitude longitude:_startCoord.longitude];
////    _points = [NSMutableArray arrayWithObject:start];
//    if (CLLocationCoordinate2DIsValid(_startCoord)) {
//        _points = [NSMutableArray arrayWithObject:start];
//    }else {
//        _points = [NSMutableArray array];
//    }
    
    [self addView];
    [self drawLineWithPoints:_points];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)addView{
    [self.view addSubview:self.mapView];
    [self.mapView addSubview:_topView];
    
    self.pointAnnotaiton = [[FEPointAnnotation alloc] init];
    self.pointAnnotaiton.type = FEPointAnnotRideStart;
    [self.pointAnnotaiton setCoordinate:_startCoord];

    [self.mapView addAnnotation:self.pointAnnotaiton];
    [self.mapView setCenterCoordinate:_startCoord];
    
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"cyc_close"] forState:UIControlStateNormal];
    WEAKSELF;
    [closeBtn bk_addEventHandler:^(id sender) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:closeBtn];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mapView).offset(-27);
        make.centerX.mas_equalTo(self.mapView);
        make.height.width.mas_equalTo(50);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mapView).offset(25);
        make.right.mas_equalTo(self.mapView).offset(-10);
        make.left.mas_equalTo(self.mapView).offset(10);
        make.height.mas_equalTo(90);
    }];
}

int count = 0;
- (void)updateUIDataWithTime:(NSString *)time km:(NSString *)km elec:(NSString *)elec speed:(NSString *)spend {
    self.currentTime.text = time;
    self.currentKM.text = km;
    self.speed.text = spend;
    self.currentElec.text = elec;
    
    //把当前位置记录下来 5s更新
//    count++;
//    if (_currentLocat&&CLLocationCoordinate2DIsValid(_currentLocat.coordinate)&&count>=5) {
//        count = 0;
//        DQLOCK(self.lock);
//        [self.points addObject:[_currentLocat copy]];
//        DQUNLOCK(self.lock);
//        [self drawLine];
//
//    }
}


- (FECycleMap *)mapView {
    if (!_mapView) {
        _mapView = [[FECycleMap alloc] init];
        _mapView.delegate = self;
//        _mapView.isShowLocBtn = NO;
        WEAKSELF;
        _mapView.locationUpdateBlock = ^(CLLocation * _Nonnull location, AMapLocationReGeocode * _Nonnull reGeocode, CGFloat locationAngle, NSError * _Nonnull error) {
//                MYLog(@"map-location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@;agnle:%f;error:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress,locationAngle,error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //获取到定位信息，更新annotation
//                if (weakSelf.pointAnnotaiton == nil)
//                {
//                    weakSelf.pointAnnotaiton = [[FEPointAnnotation alloc] init];
//                    weakSelf.pointAnnotaiton.type = FEPointAnnotLoc;
//                    [weakSelf.pointAnnotaiton setCoordinate:location.coordinate];
//
//                    [weakSelf.mapView addAnnotation:weakSelf.pointAnnotaiton];
//                }
                if (location) {
                    [weakSelf setCurrentLocat:location];
                }
            });
        };
        _mapView.allowsAnnotationViewSorting = NO;
        [_mapView setIsShowMapCenter:NO];
        
        [_mapView startHeadingLocation];
        _mapView.distanceFilter = 15;
        _mapView.showsCompass = NO;
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    return _mapView;
}

- (void)setCurrentLocat:(CLLocation *)currentLocat {
    if (currentLocat&&CLLocationCoordinate2DIsValid(currentLocat.coordinate)) {
        _currentLocat = currentLocat;
        //    [self.pointAnnotaiton setCoordinate:currentCoord];
//            [self.mapView setCenterCoordinate:_currentLocat.coordinate];
    }
}

//AmapDelegete
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[FEPointAnnotation class]]) {
        
        NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if(!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
        }
        FEPointAnnotType type = ((FEPointAnnotation *)annotation).type;
        switch (type) {
            case FEPointAnnotRideStart:
                annotationView.image = [UIImage imageNamed:@"cyc_bianz.png"];
                break;
            default:
                break;
        }
//        annotationView.image = [UIImage imageNamed:@"cyc_bianz.png"];
//        annotationView.canShowCallout = YES;
        return annotationView;
    }
    
    return nil;
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];
        
        polylineRenderer.lineWidth    = 6.f;
        polylineRenderer.strokeColor  = [UIColor colorWithRed:73.0f/255.0f green:189.0f/255.0f blue:255.0f/255.0f alpha:1.0f];
        polylineRenderer.lineJoinType = kMALineJoinRound;
        polylineRenderer.lineCapType  = kMALineCapRound;
        
        return polylineRenderer;
    }
    return nil;
}

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation {
    CLLocation *lastLoc = [_points lastObject];
    CLLocation *loc = [[CLLocation alloc] initWithLatitude:userLocation.location.coordinate.latitude longitude:userLocation.location.coordinate.longitude];
    CLLocationDistance distance = [[FEMapManager manager] getDistanceSycnFromCoord:lastLoc.coordinate toCoord:loc.coordinate];

    if (distance>=20&&distance<100000) {
        DQLOCK(_lock);
        [_points addObject:loc];
        DQUNLOCK(_lock);
        [self drawLineWithPoints:@[lastLoc,loc]];
    }
}

//划线
- (void)drawLineWithPoints:(NSArray *)points {
    if (points.count<2) {
        return;
    }
    CLLocationCoordinate2D commonPolylineCoords[points.count];
//    commonPolylineCoords[0].latitude = 28.284373;
//    commonPolylineCoords[0].longitude = 112.929788;
//
//    commonPolylineCoords[1].latitude = 28.283363;
//    commonPolylineCoords[1].longitude = 112.929788;
//
//    commonPolylineCoords[2].latitude = 28.283333;
//    commonPolylineCoords[2].longitude = 112.929788;
//
//    commonPolylineCoords[3].latitude = 28.286343;
//    commonPolylineCoords[3].longitude = 112.939788;
    for (int i=0; i<points.count; i++) {
        CLLocation *loc = points[i];
        commonPolylineCoords[i].latitude = loc.coordinate.latitude;
        commonPolylineCoords[i].longitude = loc.coordinate.longitude;
    }
    
    //清楚之前的轨迹
//    [_mapView removeOverlays:_mapView.overlays];
    
    //构造折线对象
    MAPolyline *commonPolyline = [MAPolyline polylineWithCoordinates:commonPolylineCoords count:points.count];

    //在地图上添加折线对象
    [_mapView addOverlay: commonPolyline];
    CLLocation *currentLoc = [points lastObject];
    [_mapView setCenterCoordinate:currentLoc.coordinate];
}

- (void)dealloc {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
