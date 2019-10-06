//
//  FEMapNaviViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/9/26.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMapNaviViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
@interface FEMapNaviViewController ()<AMapNaviCompositeManagerDelegate>

@property (nonatomic, strong) AMapNaviCompositeManager *compositeManager;

@end

@implementation FEMapNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIButton *routeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    routeBtn.frame = CGRectMake(100, 100, 200, 45);
    [routeBtn setTitle:@"传入终点" forState:UIControlStateNormal];
    [routeBtn setTitleColor:[UIColor colorWithRed:53/255.0 green:117/255.0 blue:255/255.0 alpha:1] forState:UIControlStateNormal];
    routeBtn.layer.borderWidth = 1;
    routeBtn.layer.borderColor = [UIColor colorWithRed:53/255.0 green:117/255.0 blue:255/255.0 alpha:1].CGColor;
    routeBtn.layer.cornerRadius = 5;
    [routeBtn addTarget:self action:@selector(routePlanWithEndPoint) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:routeBtn];
}

// init
- (AMapNaviCompositeManager *)compositeManager {
    if (!_compositeManager) {
        _compositeManager = [[AMapNaviCompositeManager alloc] init];  // 初始化
        _compositeManager.delegate = self;  // 如果需要使用AMapNaviCompositeManagerDelegate的相关回调（如自定义语音、获取实时位置等），需要设置delegate
    }
    return _compositeManager;
}

// 传入终点
- (void)routePlanWithEndPoint {
    AMapNaviCompositeUserConfig *config = [[AMapNaviCompositeUserConfig alloc] init];
    [config setRoutePlanPOIType:AMapNaviRoutePlanPOITypeEnd location:[AMapNaviPoint locationWithLatitude:39.918058 longitude:116.397026] name:@"故宫" POIId:nil];  //传入终点
    [self.compositeManager presentRoutePlanViewControllerWithOptions:config];
}

#pragma mark - AMapNaviCompositeManagerDelegate

// 发生错误时,会调用代理的此方法
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager error:(NSError *)error {
    NSLog(@"error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

// 算路成功后的回调函数,路径规划页面的算路、导航页面的重算等成功后均会调用此方法
- (void)compositeManagerOnCalculateRouteSuccess:(AMapNaviCompositeManager *)compositeManager {
    NSLog(@"onCalculateRouteSuccess,%ld",(long)compositeManager.naviRouteID);
}

// 算路失败后的回调函数,路径规划页面的算路、导航页面的重算等失败后均会调用此方法
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager onCalculateRouteFailure:(NSError *)error {
    NSLog(@"onCalculateRouteFailure error:{%ld - %@}", (long)error.code, error.localizedDescription);
}

// 开始导航的回调函数
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager didStartNavi:(AMapNaviMode)naviMode {
    NSLog(@"didStartNavi,%ld",(long)naviMode);
}

// 当前位置更新回调
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager updateNaviLocation:(AMapNaviLocation *)naviLocation {
    NSLog(@"updateNaviLocation,%@",naviLocation);
}

// 导航到达目的地后的回调函数
- (void)compositeManager:(AMapNaviCompositeManager *)compositeManager didArrivedDestination:(AMapNaviMode)naviMode {
    NSLog(@"didArrivedDestination,%ld",(long)naviMode);
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
