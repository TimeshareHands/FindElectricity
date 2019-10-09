//
//  FEMapViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/9/26.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "CommonUtility.h"
#import "MANaviRoute.h"
#import "FELauchShow.h"
#import "FEMapCategView.h"
#import "FEMapWeather.h"
#import "FEMapNavigiItem.h"
#import "FEMessageViewController.h"
#import "AppDelegate.h"
#import "FEPointAnnotation.h"
#import "FEShopPopView.h"
#import "FEShopDetailViewController.h"
#import "FindTabBarController.h"
@interface FEMapViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UIImageView *centerImg;
@property (nonatomic, strong) UIButton *chouJBtn;
@property (nonatomic, strong) UIButton *positionBtn;
@property (nonatomic, strong) UIButton *shaiXuanBtn;
@property (weak, nonatomic) FELauchShow *lauchShow;
@property (weak, nonatomic) FEMapCategView *categView;
@property (strong, nonatomic) FEMapWeather *weatherView;
@property (strong, nonatomic) FEMapNavigiItem *naviRightItem;
@property (nonatomic, weak) FEShopPopView *shopPopView;
@property (assign, nonatomic) BOOL didShow;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;
@property (nonatomic, strong) FEPointAnnotation *pointAnnotaiton;
@property (assign, nonatomic) CLLocationCoordinate2D startCoordinate; //起始点经纬度
@property (assign, nonatomic) CLLocationCoordinate2D destinationCoordinate;
@property (nonatomic, strong) AMapSearchAPI *search;
@property (strong, nonatomic) AMapRoute *route;  //路径规划信息
@property (strong, nonatomic) MANaviRoute * naviRoute;  //用于显示当前路线方案.
@end

@implementation FEMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self addView];
    
    [self initCompleteBlock];
    [self configLocationManager];
}

- (void)addView {
    //导航栏
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.weatherView];
    UIView *rightItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [rightItem addSubview:self.naviRightItem];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    [self.view addSubview:self.mapView];
    [self.mapView addSubview:self.centerImg];
    [self.mapView addSubview:self.chouJBtn];
    [self.mapView addSubview:self.positionBtn];
    [self.mapView addSubview:self.shaiXuanBtn];
    [self.mapView addSubview:self.shopPopView];
    [self makeUpconstraint];
}

#pragma mark -约束适配
-(void)makeUpconstraint{
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    [self.centerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(31);
        make.width.mas_equalTo(20);
        make.centerX.centerY.equalTo(self.mapView);
    }];
    [self.chouJBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(60);
        make.width.mas_equalTo(50);
        make.top.equalTo(self.mapView).offset(25);
        make.right.equalTo(self.mapView).offset(-10);
    }];
    [self.positionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(36);
        make.bottom.equalTo(self.mapView).offset(-10);
        make.right.equalTo(self.chouJBtn);
    }];
    [self.shaiXuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(36);
        make.bottom.equalTo(self.positionBtn.mas_top).offset(-17);
        make.right.equalTo(self.positionBtn);
    }];
    
//    [self.shopPopView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(175);
//        make.bottom.equalTo(self.mapView).offset(-10);
//        make.right.equalTo(self.mapView).offset(20);
//        make.left.equalTo(self.mapView).offset(-20);
//    }];
}

- (FEMapWeather *)weatherView {
    if (!_weatherView) {
        _weatherView = [[FEMapWeather alloc] initWithFrame:CGRectMake(0, 0,50, 30)];
        _weatherView.backgroundColor = [UIColor redColor];
    }
    return _weatherView;
}

- (FEMapNavigiItem *)naviRightItem {
    if (!_naviRightItem) {
        _naviRightItem = [[FEMapNavigiItem alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
        WEAKSELF;
        _naviRightItem.didTap = ^void(NSInteger tag) {
            if (tag==0) {
                //任务
                AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:2];
                [app.tabBarController switchTab:indexPath];
            }else{
                //消息中心
                FEMessageViewController *messageVC = [[FEMessageViewController alloc] init];
                [weakSelf.navigationController pushViewController:messageVC animated:YES];
            }
        };
    }
    return _naviRightItem;
}

- (MAMapView *)mapView {
    if (!_mapView) {
        _mapView = [[MAMapView alloc] init];
        _mapView.delegate = self;
        _mapView.allowsAnnotationViewSorting = NO;
//        _mapView.showsUserLocation = YES;
//        _mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    return _mapView;
}

- (UIImageView *)centerImg {
    if (!_centerImg) {
        _centerImg = [[UIImageView alloc] init];
        _centerImg.image = [UIImage imageNamed:@"map_position.png"];
    }
    return _centerImg;
}

- (UIButton *)chouJBtn {
    if (!_chouJBtn) {
        _chouJBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chouJBtn setImage:[UIImage imageNamed:@"map_redbag"] forState:UIControlStateNormal];
        [_chouJBtn bk_addEventHandler:^(UIButton *sender) {
            //抽奖
            [self goChouJiang];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _chouJBtn;
}

#pragma 抽奖
- (void)goChouJiang {
    
}

- (UIButton *)positionBtn {
    if (!_positionBtn) {
        _positionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_positionBtn setImage:[UIImage imageNamed:@"map_location"] forState:UIControlStateNormal];
        WEAKSELF;
        [_positionBtn bk_addEventHandler:^(UIButton *sender) {
            //地位
            [weakSelf.mapView setCenterCoordinate:weakSelf.pointAnnotaiton.coordinate animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _positionBtn;
}

- (UIButton *)shaiXuanBtn {
    if (!_shaiXuanBtn) {
        _shaiXuanBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_shaiXuanBtn setImage:[UIImage imageNamed:@"map_categ"] forState:UIControlStateNormal];
        [_shaiXuanBtn bk_addEventHandler:^(UIButton *sender) {
            //筛选
            [self.categView show];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _shaiXuanBtn;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (!_didShow) {
        _didShow = YES;
        [[self lauchShow] show];
    }
}

- (FELauchShow *)lauchShow {
    if (!_lauchShow) {
        _lauchShow = [FELauchShow createView];
        _lauchShow.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        WEAKSELF;
        _lauchShow.didClick = ^(FELauchShow * _Nonnull lau, NSInteger tag) {
            [weakSelf.lauchShow hidden];
            if (tag==1) {
                //去抽奖
                [self goChouJiang];
            }
        };
    }
    return _lauchShow;
}

- (FEMapCategView *)categView {
    if (!_categView) {
        _categView = [FEMapCategView createView];
        _categView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        WEAKSELF;
        _categView.comfirm = ^(FEMapCategView * _Nonnull view, NSString *status) {
            MYLog(@"%@",status);
        };
    }
    return _categView;
}

- (FEShopPopView *)shopPopView {
    if (!_shopPopView) {
        _shopPopView = [FEShopPopView createView];
        _shopPopView.frame = CGRectMake(0, SCREEN_HEIGHT-175-SafeAreaBottomHeight-SafeAreaTopHeight, SCREEN_WIDTH, 175);
        _shopPopView.hidden = YES;
        WEAKSELF;
        _shopPopView.didClick = ^(NSInteger tag) {
            if (tag == 0) {
                FEShopDetailViewController *shopVC = [[FEShopDetailViewController alloc] init];
                [weakSelf.navigationController pushViewController:shopVC animated:YES];
            }
        };
    }
    return _shopPopView;
}

- (void)configLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];

    [self.locationManager setDelegate:self];

    [self.locationManager setPausesLocationUpdatesAutomatically:NO];

    //设置期望定位精度
    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyHundredMeters];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
//    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置定位超时时间
    [self.locationManager setLocationTimeout:6];
    
    //设置逆地理超时时间
    [self.locationManager setReGeocodeTimeout:3];
    
    //设置开启虚拟定位风险监测，可以根据需要开启
    [self.locationManager setDetectRiskOfFakeLocation:NO];
    
    [self.locationManager startUpdatingLocation];
}

- (void)cleanUpAction
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
    
    [self.locationManager setDelegate:nil];

    [self.mapView removeAnnotations:self.mapView.annotations];
}

- (void)reGeocodeAction
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    //进行单次带逆地理定位请求
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}

- (void)locAction
{
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    //进行单次定位请求
    [self.locationManager requestLocationWithReGeocode:NO completionBlock:self.completionBlock];
}

#pragma mark - Initialization

- (void)initCompleteBlock
{
    WEAKSELF;
    self.completionBlock = ^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error)
    {
        if (error != nil && error.code == AMapLocationErrorLocateFailed)
        {
            //定位错误：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"定位错误:{%ld - %@};", (long)error.code, error.userInfo);
            return;
        }
        else if (error != nil
                 && (error.code == AMapLocationErrorReGeocodeFailed
                     || error.code == AMapLocationErrorTimeOut
                     || error.code == AMapLocationErrorCannotFindHost
                     || error.code == AMapLocationErrorBadURL
                     || error.code == AMapLocationErrorNotConnectedToInternet
                     || error.code == AMapLocationErrorCannotConnectToHost))
        {
            //逆地理错误：在带逆地理的单次定位中，逆地理过程可能发生错误，此时location有返回值，regeocode无返回值，进行annotation的添加
            NSLog(@"逆地理错误:{%ld - %@};", (long)error.code, error.userInfo);
        }
        else if (error != nil && error.code == AMapLocationErrorRiskOfFakeLocation)
        {
            //存在虚拟定位的风险：此时location和regeocode没有返回值，不进行annotation的添加
            NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.userInfo);
            
            //存在虚拟定位的风险的定位结果
            __unused CLLocation *riskyLocateResult = [error.userInfo objectForKey:@"AMapLocationRiskyLocateResult"];
            //存在外接的辅助定位设备
            __unused NSDictionary *externalAccressory = [error.userInfo objectForKey:@"AMapLocationAccessoryInfo"];
            
            return;
        }
        else
        {
            //没有错误：location有返回值，regeocode是否有返回值取决于是否进行逆地理操作，进行annotation的添加
        }
        
        //根据定位信息，添加annotation
        FEPointAnnotation *annotation = [[FEPointAnnotation alloc] init];
        [annotation setCoordinate:location.coordinate];
        
        //有无逆地理信息，annotationView的标题显示的字段不一样
        if (regeocode)
        {
            [annotation setTitle:[NSString stringWithFormat:@"%@", regeocode.formattedAddress]];
            [annotation setSubtitle:[NSString stringWithFormat:@"%@-%@-%.2fm", regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]];
        }
        else
        {
            [annotation setTitle:[NSString stringWithFormat:@"lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude]];
            [annotation setSubtitle:[NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy]];
        }
        
        FEMapViewController *strongSelf = weakSelf;
        [strongSelf addAnnotationToMapView:annotation];
    };
}

- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    
//    [self.mapView selectAnnotation:annotation animated:YES];
    [self.mapView setZoomLevel:20.1 animated:NO];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma 点击了annota
- (void)annotationClick:(UITapGestureRecognizer *)gesture {
    NSLog(@"=== annotation clicked");

    MAAnnotationView *annoView = (MAAnnotationView*) gesture.view;
    if(annoView.annotation == self.mapView.selectedAnnotations.firstObject) {
        if(annoView.selected == NO) {
            [annoView setSelected:YES animated:YES];
        }
        return;
    } else {
        [self.mapView selectAnnotation:annoView.annotation animated:YES];
    }
}

# pragma mark -AMapSearchAPI
- (void)ridingRouteSearchFromCoord:(CLLocationCoordinate2D)fromCoord toCoord:(CLLocationCoordinate2D)toCoord {
    if(!_search){
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    AMapRidingRouteSearchRequest *navi = [[AMapRidingRouteSearchRequest alloc] init];

    /* 出发点. {28.201112, 112.97111}*/
    navi.origin = [AMapGeoPoint locationWithLatitude:28.201112
                                           longitude:112.97111];
    self.startCoordinate = (CLLocationCoordinate2D){28.201112, 112.97111};
    /* 目的地. */
    navi.destination = [AMapGeoPoint locationWithLatitude:toCoord.latitude
                                                longitude:toCoord.longitude];
    self.destinationCoordinate = toCoord;
    [self.search AMapRidingRouteSearch:navi];
}

/* 路径规划搜索回调. */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if (response.route == nil)
    {
        return;
    }
    self.route = response.route;
    [self presentCurrentRouteCourse];
}

//在地图上显示当前选择的路径
- (void)presentCurrentRouteCourse {
    
    if (self.route.paths.count <= 0) {
        return;
    }
    
    [self.naviRoute removeFromMapView];  //清空地图上已有的路线
    
    
    FEPointAnnotType type = FEPointAnnotRiding; //骑行类型
    
    AMapGeoPoint *startPoint = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude longitude:self.startCoordinate.longitude]; //起点

    AMapGeoPoint *endPoint = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude longitude:self.destinationCoordinate.longitude];  //终点
    
    //根据已经规划的路径，起点，终点，规划类型，是否显示实时路况，生成显示方案
    self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[0] withNaviType:type showTraffic:NO startPoint:startPoint endPoint:endPoint];
    
    [self.naviRoute addToMapView:self.mapView];  //显示到地图上
    
    UIEdgeInsets edgePaddingRect = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //缩放地图使其适应polylines的展示
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines]
                        edgePadding:edgePaddingRect
                           animated:NO];
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id <MAOverlay>)overlay
{
    //虚线，如需要步行的
    if ([overlay isKindOfClass:[LineDashPolyline class]]) {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth = 6;
        polylineRenderer.lineDash = YES;
        polylineRenderer.strokeColor = [UIColor redColor];

        return polylineRenderer;
    }
    
    //showTraffic为NO时，不需要带实时路况，路径为单一颜色
    if ([overlay isKindOfClass:[MANaviPolyline class]]) {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        
        polylineRenderer.lineWidth = 6;
        
        if (naviPolyline.type == FEPointAnnotWalking) {
            polylineRenderer.strokeColor = self.naviRoute.walkingColor;
        } else if (naviPolyline.type == FEPointAnnotRailway) {
            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        } else {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        
        return polylineRenderer;
    }
    return nil;
}

#pragma mark - AMapLocationManager Delegate

- (void)amapLocationManager:(AMapLocationManager *)manager doRequireLocationAuth:(CLLocationManager *)locationManager
{
    [locationManager requestAlwaysAuthorization];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
    
    if (error.code == AMapLocationErrorRiskOfFakeLocation) {
        NSLog(@"存在虚拟定位的风险:{%ld - %@};", (long)error.code, error.userInfo);
        
        //存在虚拟定位的风险的定位结果
        __unused CLLocation *riskyLocateResult = [error.userInfo objectForKey:@"AMapLocationRiskyLocateResult"];
        //存在外接的辅助定位设备
        __unused NSDictionary *externalAccressory = [error.userInfo objectForKey:@"AMapLocationAccessoryInfo"];
    }
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress);
    
    //获取到定位信息，更新annotation
    if (self.pointAnnotaiton == nil)
    {
        self.pointAnnotaiton = [[FEPointAnnotation alloc] init];
        self.pointAnnotaiton.type = FEPointAnnotLoc;
        [self.pointAnnotaiton setCoordinate:location.coordinate];
        
        [self addAnnotationToMapView:self.pointAnnotaiton];
    }
    
    [self.pointAnnotaiton setCoordinate:location.coordinate];
    
    [self.mapView setCenterCoordinate:location.coordinate];
}

#pragma mark - mapview delegate
- (void)mapInitComplete:(MAMapView *)mapView {
    CLLocationCoordinate2D coordinates[9] = {
        {28.201112, 112.97111},
        {28.201233, 112.971115},
        {28.201222, 112.971222},
        {28.201333, 112.971333},
        {28.201444, 112.971444},
        {28.201555, 112.971555},
        {28.201666, 112.971666},
        {28.201777, 112.971777},
        {28.201888, 112.971888},
        {28.201899, 112.971999},
    };
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:9];
    for (int i = 0; i < 9; ++i)
    {
        FEPointAnnotation *a = [[FEPointAnnotation alloc] init];
        a.coordinate = coordinates[i];
        a.title      = [NSString stringWithFormat:@"距离%d千米，骑行%d分钟", i,i*5];
        a.type = i%3+1;
        [arr addObject:a];
    }

    [self.mapView addAnnotations:arr];
    [self.mapView showAnnotations:arr animated:NO];
}

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[FEPointAnnotation class]]) {
        
        NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        
        MAAnnotationView *annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if(!annotationView) {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndetifier];
            [annotationView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(annotationClick:)]];
        }
        FEPointAnnotType type = ((FEPointAnnotation *)annotation).type;
        switch (type) {
            case FEPointAnnotFix:
                annotationView.image = [UIImage imageNamed:@"map_fix.png"];
                break;
                
            case FEPointAnnotSlowlyChong:
                annotationView.image = [UIImage imageNamed:@"map_manch.png"];
                break;
                
            case FEPointAnnotQuickChong:
                annotationView.image = [UIImage imageNamed:@"map_quickch.png"];
                break;
                
            case FEPointAnnotRiding:
                annotationView.image = [UIImage imageNamed:@"map_ride"];
                break;
            case FEPointAnnotLoc:
                annotationView.image = [UIImage imageNamed:@"icon_location"];
                break;
            default:
                break;
        }
        annotationView.canShowCallout = YES;
        return annotationView;
    }
    
    return nil;
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)annoView
{
    NSLog(@"onClick-%@", annoView.annotation.title);
    self.shopPopView.hidden = NO;
    [self ridingRouteSearchFromCoord:self.pointAnnotaiton.coordinate toCoord:annoView.annotation.coordinate];
//    [self.navigationController.navigationBar setHidden:YES];
//    [[self rootTabBarController].tabBar setHidden:YES];
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    NSLog(@"remove-%@", view.annotation.title);
    self.shopPopView.hidden = YES;
}

- (FindTabBarController *)rootTabBarController{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return app.tabBarController;
}

- (void)dealloc
{
    [self cleanUpAction];
    
    self.completionBlock = nil;
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
