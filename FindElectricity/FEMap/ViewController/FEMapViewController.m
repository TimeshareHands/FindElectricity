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
#import "FECorrectionViewController.h"
#import "FEWorkTurnTableVC.h"
#import "FindTabBarController.h"
#import "FECycleMap.h"
#import "FEMapsModel.h"
#import "FEMapInfoModel.h"
#import "FEMapManager.h"
@interface FEMapViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate>
@property (nonatomic, strong) FECycleMap *mapView;
@property (nonatomic, strong) UIButton *chouJBtn;
@property (nonatomic, strong) UIButton *shaiXuanBtn;
@property (strong, nonatomic) FELauchShow *lauchShow;
@property (strong, nonatomic) FEMapCategView *categView;
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
@property (strong, nonatomic) MANaviRoute *naviRoute;  //用于显示当前路线方案.

@property (copy, nonatomic) NSString *type;  //类型
@property (strong, nonatomic) NSMutableArray *mapDatas;  //类型
@property (strong, nonatomic) FEMapInfoModel *currentMapInfo;  //类型
@property (strong, nonatomic) MAAnnotationView *CurrAnnotationView;  //类型
@end

@implementation FEMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initData];
    [self addView];
}

- (void)initData {
    _mapDatas = [NSMutableArray array];
    _type = @"1,2|1,3|2,3|1,2,3|1|2|3";
}

- (void)addView {
    //导航栏
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.weatherView];
    UIView *rightItem = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, 30)];
    [rightItem addSubview:self.naviRightItem];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightItem];
    [self.view addSubview:self.mapView];
    [self.mapView addSubview:self.chouJBtn];
    [self.mapView addSubview:self.shaiXuanBtn];
    [self.mapView addSubview:self.shopPopView];
    [self makeUpconstraint];
}

#pragma mark -约束适配
-(void)makeUpconstraint{
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    [self.chouJBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(110);
        make.width.mas_equalTo(50);
        make.top.equalTo(self.mapView).offset(25);
        make.right.equalTo(self.mapView).offset(-10);
    }];
    [self.shaiXuanBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.width.mas_equalTo(36);
        make.bottom.equalTo(self.mapView).offset(-61);
        make.right.equalTo(self.chouJBtn);
    }];
    
    [self.shopPopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(175);
        make.bottom.right.left.equalTo(self.mapView).offset(0);
        
    }];
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
        _mapView = [[FECycleMap alloc] init];
        WEAKSELF;
        _mapView.locationUpdateBlock = ^(CLLocation * _Nonnull location, AMapLocationReGeocode * _Nonnull reGeocode, CGFloat locationAngle, NSError * _Nonnull error) {
                MYLog(@"map-location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@;agnle:%f;error:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress,locationAngle,error);
            
            dispatch_async(dispatch_get_main_queue(), ^{
                if (reGeocode.city) {
                    [[NSUserDefaults standardUserDefaults] setObject:reGeocode.city forKey:kCurrentCity];
                }
                //获取到定位信息，更新annotation
                if (weakSelf.pointAnnotaiton == nil)
                {
                    weakSelf.pointAnnotaiton = [[FEPointAnnotation alloc] init];
                    weakSelf.pointAnnotaiton.type = FEPointAnnotLoc;
                    [weakSelf.pointAnnotaiton setCoordinate:location.coordinate];
            
                    [weakSelf addAnnotationToMapView:weakSelf.pointAnnotaiton];
                    [weakSelf.mapView setCenterCoordinate:location.coordinate];
                    [weakSelf getMapDataOfoordinate:location.coordinate type:weakSelf.type];
                }
                [weakSelf.pointAnnotaiton setCoordinate:location.coordinate];
                //获取天气
                [[FEMapManager manager] weatherSearchCity:reGeocode.city finishBlock:^(id  _Nonnull response, FEAMapSearchType type, NSError * _Nonnull error) {
                    if (type == FEAMapSearchTypeWeather) {
                        AMapWeatherSearchResponse *resp = (AMapWeatherSearchResponse *)response;
                        if (resp.lives.count) {
                            AMapLocalWeatherLive *live = (AMapLocalWeatherLive *)[resp.lives lastObject];
                            [weakSelf.weatherView setLive:live];
                        }
                    }
                }];
            });
        };
        _mapView.delegate = self;
        _mapView.allowsAnnotationViewSorting = NO;
        [_mapView startHeadingLocation];
        [self.mapView setZoomLevel:15.1 animated:NO];
//        _mapView.showsUserLocation = YES;
//        _mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    return _mapView;
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
    FEWorkTurnTableVC *vc = [[FEWorkTurnTableVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
        [[self lauchShow] getShowData];
    }
    
    [self getIndexData];
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
                [weakSelf goChouJiang];
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
            [weakSelf cleanUpAction];
            [weakSelf getMapDataOfoordinate:weakSelf.mapView.centerCoordinate type:status];
        };
    }
    return _categView;
}

- (FEShopPopView *)shopPopView {
    if (!_shopPopView) {
        _shopPopView = [FEShopPopView createView];
//        _shopPopView.frame = CGRectMake(0, SCREEN_HEIGHT-175-SafeAreaBottomHeight-SafeAreaTopHeight, SCREEN_WIDTH, 175);
        _shopPopView.hidden = YES;
        WEAKSELF;
        _shopPopView.didClick = ^(NSInteger tag,NSString *mapId) {
            if (tag == 0) {
                FEShopDetailViewController *shopVC = [[FEShopDetailViewController alloc] init];
                shopVC.mapId = mapId;
                [weakSelf.navigationController pushViewController:shopVC animated:YES];
            }else if (tag == 2){
                FECorrectionViewController *vc = [[FECorrectionViewController alloc] init];
                vc.mapId = mapId;
                [weakSelf.navigationController pushViewController:vc animated:YES];
            }
        };
    }
    return _shopPopView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

# pragma mark -AMapSearchAPI
- (void)ridingRouteSearchFromCoord:(CLLocationCoordinate2D)fromCoord toCoord:(CLLocationCoordinate2D)toCoord {
    if(!_search){
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    AMapRidingRouteSearchRequest *navi = [[AMapRidingRouteSearchRequest alloc] init];

    /* 出发点. {28.201112, 112.97111}*/
    navi.origin = [AMapGeoPoint locationWithLatitude:fromCoord.latitude
                                           longitude:fromCoord.longitude];
    self.startCoordinate = fromCoord;
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
    
    //显示距离时间
    AMapPath *path = self.route.paths[0];
    [_CurrAnnotationView.annotation setTitle:[NSString stringWithFormat:@"距离%d米，骑行%d分钟",path.distance,path.duration/60]];
    
    [self.naviRoute addToMapView:self.mapView];  //显示到地图上
    
    UIEdgeInsets edgePaddingRect = UIEdgeInsetsMake(10, 10, 40, 10);
    
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


#pragma mark - mapview delegate
- (void)mapInitComplete:(MAMapView *)mapView {
//    CLLocationCoordinate2D coordinates[9] = {
//        {28.201112, 112.97111},
//        {28.201233, 112.971115},
//        {28.201222, 112.971222},
//        {28.201333, 112.971333},
//        {28.201444, 112.971444},
//        {28.201555, 112.971555},
//        {28.201666, 112.971666},
//        {28.201777, 112.971777},
//        {28.201888, 112.971888},
//        {28.201899, 112.971999},
//    };
//
//    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:9];
//    for (int i = 0; i < 9; ++i)
//    {
//        FEPointAnnotation *a = [[FEPointAnnotation alloc] init];
//        a.coordinate = coordinates[i];
//        a.title      = [NSString stringWithFormat:@"距离%d千米，骑行%d分钟", i,i*5];
//        a.type = i%3+1;
//
//        [arr addObject:a];
//    }
//
//    [self.mapView addAnnotations:arr];
//    [self.mapView showAnnotations:arr animated:NO];
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
            case FEPointAnnotAll:
                annotationView.image = [UIImage imageNamed:@"map_zongh.png"];
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

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MYLog(@"--lati:%f;longt:%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
//    [self getMapDataOfoordinate:mapView.centerCoordinate type:_type];
}

- (void)mapView:(MAMapView *)mapView mapDidMoveByUser:(BOOL)wasUserAction {
    [self getMapDataOfoordinate:mapView.centerCoordinate type:_type];
}

- (void)mapView:(MAMapView *)mapView didSelectAnnotationView:(MAAnnotationView *)annoView
{
    NSLog(@"onClick-%@", annoView.annotation.title);
    dispatch_async(dispatch_get_main_queue(), ^{
        [self ridingRouteSearchFromCoord:self.pointAnnotaiton.coordinate toCoord:annoView.annotation.coordinate];
        [self getMapAnnoViewMsg:annoView];
    });
//    [self.navigationController.navigationBar setHidden:YES];
//    [[self rootTabBarController].tabBar setHidden:YES];
}

- (void)mapView:(MAMapView *)mapView didDeselectAnnotationView:(MAAnnotationView *)view{
    NSLog(@"remove-%@", view.annotation.title);
    self.shopPopView.hidden = YES;
    [self.naviRoute removeFromMapView];
}

- (FindTabBarController *)rootTabBarController{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return app.tabBarController;
}

# pragma 点击了annota
- (void)annotationClick:(UITapGestureRecognizer *)gesture {
    NSLog(@"=== annotation clicked");

    MAAnnotationView *annoView = (MAAnnotationView*) gesture.view;
    FEPointAnnotation *annotation = (FEPointAnnotation *)annoView.annotation;
    //对店家的做导航
    if (annotation.type>0&&annotation.type<4) {
        if(annoView.annotation == self.mapView.selectedAnnotations.firstObject) {
            if(annoView.selected == NO) {
                [annoView setSelected:YES animated:YES];
            }
            return;
        } else {
            [self.mapView selectAnnotation:annoView.annotation animated:YES];
        }
    }
}

- (void)getMapAnnoViewMsg:(MAAnnotationView *)annoView {
    _CurrAnnotationView = annoView;
    FEPointAnnotation *annotation = (FEPointAnnotation *)annoView.annotation;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:annotation.mapId forKey:@"mapId"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(MapInfoHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *data = (NSDictionary *)responseObject;
            if ([data[@"code"] intValue] == KSuccessCode) {
                MTSVPDismiss;
                FEMapInfoModel *model = [FEMapInfoModel mj_objectWithKeyValues:data[@"data"]];
                [weakSelf setCurrentMapInfo:model];
            }else {
                MTSVPShowInfoText(data[@"msg"]);
            }
            
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setCurrentMapInfo:(FEMapInfoModel *)model {
    _currentMapInfo = model;
    self.shopPopView.model = model;
    self.shopPopView.hidden = NO;
}

#pragma mark 获取位置数据
- (void)getMapDataOfoordinate:(CLLocationCoordinate2D)coordinate type:(NSString *)type {
    _type = type;
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:@(coordinate.longitude) forKey:@"longitude"];
    [parameter setValue:@(coordinate.latitude) forKey:@"latitude"];
    [parameter setValue:@(2000) forKey:@"raidus"];
    [parameter setValue:type forKey:@"type"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(MapListHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf getDataSuccess:responseObject];
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 请求返回数据
- (void)getDataSuccess:(id)response
{
    //    [SVProgressHUD dismiss];
    NSDictionary *data = (NSDictionary *)response;
    MYLog(@"%@",data);
    if ([data[@"code"] intValue] == KSuccessCode) {
        MTSVPDismiss;
        NSArray *array = data[@"data"][@"mapList"];
//        MTSVPShowInfoText(data[@"data"][@"announcement"]);
        if (array.count == 0)
        {
//            MTSVPShowInfoText(@"附近暂无数据");
        }
        [self addAnnotationsToMap:[FEMapsModel mj_objectArrayWithKeyValuesArray:array]];
    }else {
        MTSVPShowInfoText(data[@"msg"]);
    }
}

- (void)addAnnotationsToMap:(NSMutableArray *)datas {
//    [self.mapView removeAnnotations:_mapDatas];
    for (int i = 0; i < datas.count; ++i)
    {
        FEMapsModel *model = datas[i];
        FEPointAnnotation *a = [[FEPointAnnotation alloc] init];
        a.coordinate = (CLLocationCoordinate2D) {model.latitude,model.longitude};
        a.type = [self serviceToType:model.serviceId];
        a.mapId = model.mapId;
        [_mapDatas addObject:a];
        [self addAnnotationToMapView:a];
    }
    
//    if(arr.count){
//        [self.mapView addAnnotations:arr];
//        [self.mapView showAnnotations:arr animated:NO];
//    }
}

- (FEPointAnnotType)serviceToType:(NSString *)serverId {
//    MYLog(@"--seId:%@",serverId);
    if (serverId.length>1||[serverId containsString:@","]||[serverId containsString:@"，"]) {
        return FEPointAnnotAll;
    }
    return [serverId integerValue];
}

- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    
//    [self.mapView selectAnnotation:annotation animated:YES];
//    [self.mapView setZoomLevel:15.1 animated:NO];
//    [self.mapView setCenterCoordinate:annotation.coordinate animated:NO];
}

- (void)getIndexData {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(IndexInfoHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *data = (NSDictionary *)responseObject;
            if ([data[@"code"] intValue] == KSuccessCode) {
                MTSVPDismiss;
                [weakSelf.chouJBtn setHidden:![data[@"data"][@"is_show_redWallet"] boolValue]];
                NSInteger num = [data[@"data"][@"notRead"] integerValue];
                [weakSelf.naviRightItem notReadNum:num];
            }else {
                MTSVPShowInfoText(data[@"msg"]);
            }
            
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}



- (void)dealloc
{
    [self cleanUpAction];
    
    self.completionBlock = nil;
}

- (void)cleanUpAction {
    [self.naviRoute removeFromMapView];
    [self.mapView removeAnnotations:self.mapView.annotations];
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
