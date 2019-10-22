//
//  FEShopDetailViewController.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/7.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEShopDetailViewController.h"
#import "FEMapInfoModel.h"
#import "FECorrectionViewController.h"
#import "FENaviManager.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import "FEMapNaviViewController.h"
@interface FEShopDetailViewController ()<AMapNaviRideManagerDelegate,RideNaviViewControllerDelegate>
@property (strong, nonatomic) FEMapInfoModel *shopInfo;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *telephone;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;
@property (weak, nonatomic) IBOutlet UIImageView *logo;
@property (weak, nonatomic) IBOutlet UIImageView *shopImg;
@property (strong, nonatomic) AMapNaviRideManager *rideManager;
@end

@implementation FEShopDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getMapMsg];
}

- (void)getMapMsg {
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:_mapId forKey:@"mapId"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(MapInfoHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *data = (NSDictionary *)responseObject;
            if ([data[@"code"] intValue] == KSuccessCode) {
                MTSVPDismiss;
                FEMapInfoModel *model = [FEMapInfoModel mj_objectWithKeyValues:data[@"data"]];
                [weakSelf setShopInfo:model];
            }else {
                MTSVPShowInfoText(data[@"msg"]);
            }
            
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setShopInfo:(FEMapInfoModel *)shopInfo {
    _shopInfo = shopInfo;
    [_shopImg sd_setImageWithURL:[NSURL URLWithString:_shopInfo.brandImage] placeholderImage:[UIImage imageNamed:kFEDefaultImg]];
    [_logo sd_setImageWithURL:[NSURL URLWithString:_shopInfo.brandImage] placeholderImage:[UIImage imageNamed:kFEDefaultImg]];
    _name.text = _shopInfo.merchantsName;
    _timeLab.text = [NSString stringWithFormat:@"营业时间：%@-%@",_shopInfo.openTime,_shopInfo.closeTime];
    _address.text = [NSString stringWithFormat:@"地址：%@",_shopInfo.area];
    _telephone.text = [NSString stringWithFormat:@"电话号码：%@",_shopInfo.merchantsMobile];
    _collectBtn.selected = ![_shopInfo.is_collection intValue];
    [self setNavgaTitle:_shopInfo.merchantsName];
}

- (IBAction)btnAct:(UIButton *)sender {
    if (sender.tag == 1) {
        //收藏
        [self collectRequest];
    }else if (sender.tag == 4){
        //打电话
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",_shopInfo.merchantsMobile]]];

    }else if (sender.tag == 2){
        FECorrectionViewController *vc = [[FECorrectionViewController alloc] init];
        vc.mapId = _shopInfo.mapId;
        [self.navigationController pushViewController:vc animated:YES];
    }else {
        //路线
        
    }
}

- (void)collectRequest {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:_shopInfo.mapId forKey:@"mapId"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(MapCollectionHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectBtn setSelected:!weakSelf.collectBtn.selected];
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


- (IBAction)naviTo:(id)sender {
//    [[FENaviManager manager] routePlanWithEndPoint:(CLLocationCoordinate2D){_shopInfo.latitude,_shopInfo.longitude} name:_shopInfo.merchantsName];
    [self routePlanAction];
}

//路径规划
- (void)routePlanAction
{
    if (_shopInfo == nil)
    {
        NSLog(@"暂无信息");
        return;
    }
    
    AMapNaviPoint *endPoint = [AMapNaviPoint locationWithLatitude:_shopInfo.latitude
                                                          longitude:_shopInfo.longitude];
    
    [self.rideManager calculateRideRouteWithEndPoint:endPoint];
}

- (AMapNaviRideManager *)rideManager {
    if (!_rideManager) {
        _rideManager = [[AMapNaviRideManager alloc] init];
        _rideManager.delegate = self;
    }
    return _rideManager;
}


//naviRideManager Delegete
- (void)rideManagerOnCalculateRouteSuccess:(AMapNaviRideManager *)rideManager {
    FEMapNaviViewController *rideVC = [[FEMapNaviViewController alloc] init];
    [rideVC setDelegate:self];
    
    //将driveView添加为导航数据的Representative，使其可以接收到导航诱导数据
    [self.rideManager addDataRepresentative:rideVC.rideView];
    
    [self.navigationController pushViewController:rideVC animated:NO];
    [self.rideManager startGPSNavi];
}

- (void)rideNaviViewCloseButtonClicked {
    //导航关闭
    [self.rideManager stopNavi];
    _rideManager = nil;
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
