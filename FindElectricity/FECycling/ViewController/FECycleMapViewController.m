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
@interface FECycleMapViewController ()<MAMapViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) FECycleMap *mapView;
@property (assign, nonatomic) CLLocationCoordinate2D currentCoord;
@property (weak, nonatomic) IBOutlet UILabel *currentElec;
@property (weak, nonatomic) IBOutlet UILabel *speed;
@property (weak, nonatomic) IBOutlet UILabel *currentKM;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (nonatomic, strong) FEPointAnnotation *pointAnnotaiton;
@end

@implementation FECycleMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
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

- (void)updateUIDataWithTime:(NSString *)time km:(NSString *)km elec:(NSString *)elec speed:(NSString *)spend {
    self.currentTime.text = time;
    self.currentKM.text = km;
    self.speed.text = spend;
    self.currentElec.text = elec;
}

- (FECycleMap *)mapView {
    if (!_mapView) {
        _mapView = [[FECycleMap alloc] init];
        _mapView.delegate = self;
//        _mapView.isShowLocBtn = NO;
        WEAKSELF;
        _mapView.locationUpdateBlock = ^(CLLocation * _Nonnull location, AMapLocationReGeocode * _Nonnull reGeocode, CGFloat locationAngle, NSError * _Nonnull error) {
                MYLog(@"map-location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@;agnle:%f;error:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress,locationAngle,error);
            
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
                [weakSelf setCurrentCoord:location.coordinate];
            });
        };
        _mapView.allowsAnnotationViewSorting = NO;
        [_mapView setIsShowMapCenter:NO];
        [self.mapView startHeadingLocation];
        _mapView.showsUserLocation = YES;
//        _mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    return _mapView;
}

- (void)setCurrentCoord:(CLLocationCoordinate2D)currentCoord {
    _currentCoord = currentCoord;
//    [self.pointAnnotaiton setCoordinate:currentCoord];
    [self.mapView setCenterCoordinate:currentCoord];
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
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    
    return nil;
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
