//
//  FEMapViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/9/26.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMapViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "FELauchShow.h"
#import "FEMapWeather.h"
#import "FEMapNavigiItem.h"
#import "FEMessageViewController.h"
#import "AppDelegate.h"
#import "FEPointAnnotation.h"
#import "FEShopPopView.h"
#import "FEShopDetailViewController.h"
#import "FindTabBarController.h"
@interface FEMapViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate>
@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UIImageView *centerImg;
@property (nonatomic, strong) UIButton *chouJBtn;
@property (nonatomic, strong) UIButton *positionBtn;
@property (nonatomic, strong) UIButton *shaiXuanBtn;
@property (weak, nonatomic) FELauchShow *lauchShow;
@property (strong, nonatomic) FEMapWeather *weatherView;
@property (strong, nonatomic) FEMapNavigiItem *naviRightItem;
@property (nonatomic, weak) FEShopPopView *shopPopView;
@property (assign, nonatomic) BOOL didShow;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;
@property (nonatomic, strong) FEPointAnnotation *pointAnnotaiton;
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
    UIView *rightItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
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
        make.width.mas_equalTo(51);
        make.top.equalTo(self.mapView).offset(20);
        make.right.equalTo(self.mapView).offset(-20);
    }];
    [self.positionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(48);
        make.bottom.equalTo(self.mapView).offset(-20);
        make.right.equalTo(self.mapView).offset(-20);
    }];
    [self.shaiXuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(48);
        make.bottom.equalTo(self.positionBtn.mas_top).offset(-10);
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
        _naviRightItem = [[FEMapNavigiItem alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
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
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
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
        [_positionBtn bk_addEventHandler:^(UIButton *sender) {
            //地位
            
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

- (FEShopPopView *)shopPopView {
    if (!_shopPopView) {
        _shopPopView = [FEShopPopView createView];
        _shopPopView.frame = CGRectMake(10, SCREEN_HEIGHT-175-10-SafeAreaBottomHeight-SafeAreaTopHeight, SCREEN_WIDTH-20, 175);
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
        if (type==FEPointAnnotFix) {
            annotationView.image = [UIImage imageNamed:@"map_fix.png"];
        }else if (type == FEPointAnnotSlowlyChong){
            annotationView.image = [UIImage imageNamed:@"map_manch.png"];
        }else if (type == FEPointAnnotQuickChong){
            annotationView.image = [UIImage imageNamed:@"map_quickch.png"];
        }else{
            annotationView.image            = [UIImage imageNamed:@"icon_location.png"];
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
