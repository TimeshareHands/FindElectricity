//
//  FECycleDetailViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/9.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FECycleDetailViewController.h"
#import "FECycleMapViewController.h"
#import "FEStopProcessBtn.h"
#import "FETimeManager.h"
#import "FEFunction.h"
#import "NSDictionary+FEExtend.h"
#import "NSString+Extend.h"
#import <AMapLocationKit/AMapLocationKit.h>
@protocol FECycleDetailVCDelegete <NSObject>
- (void)updateUIDataWithTime:(NSString *)time km:(NSString *)km elec:(NSString *)elec speed:(NSString *)spend;
@end
@interface FECycleDetailViewController ()<AMapLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet FEStopProcessBtn *endBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UIButton *goonBtn;

@property (weak, nonatomic) IBOutlet UILabel *currentElec;
@property (weak, nonatomic) IBOutlet UILabel *speed;
@property (weak, nonatomic) IBOutlet UILabel *currentKM;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;

@property (assign, nonatomic) CGFloat kmNum;
@property (assign, nonatomic) NSTimeInterval sec;
@property (weak,nonatomic) id<FECycleDetailVCDelegete> delegete;

@property (nonatomic, strong) AMapLocationManager *locationManager;
@end

@implementation FECycleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"骑行倒计时"];
    [self addView];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:kFECycleTime];
    [userDefault removeObjectForKey:kFECycleKM];
    _sec = 1;
    FETimeManager *timeManager = [FETimeManager shareManager];
    [timeManager startTiming];
    WEAKSELF;
    timeManager.timeRunBlock = ^(NSTimeInterval sec) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.sec = sec;
            [weakSelf updateData];
        });
    };
    [self configLocationManager];
}

- (void)configLocationManager
{

    self.locationManager = [[AMapLocationManager alloc] init];

    [self.locationManager setDelegate:self];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
//    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置允许连续定位逆地理
    [self.locationManager setLocatingWithReGeocode:YES];
    
    //设置开启虚拟定位风险监测，可以根据需要开启
    [self.locationManager setDetectRiskOfFakeLocation:NO];
    
    [self.locationManager startUpdatingLocation];
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
//    MYLog(@"location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress);
    
    [self setCurrentCoord:location.coordinate];
}

- (void)setCurrentCoord:(CLLocationCoordinate2D)currentCoord {
    _currentCoord = currentCoord;
    [self getDistance:currentCoord];
}

//更新数据
- (void)updateData{
    self.currentTime.text = timeFormt(_sec);
    self.currentKM.text = [NSString stringWithFormat:@"%.2f",_kmNum/1000.0];
    self.speed.text = [NSString stringWithFormat:@"%.2f",_kmNum/1000.0/_sec];
    NSInteger changNum = [[NSUserDefaults standardUserDefaults] integerForKey:kFEKMToElecNum];
    self.currentElec.text = [NSString stringWithFormat:@"%.0f",_kmNum/changNum];
    if (_delegete&&[_delegete respondsToSelector:@selector(updateUIDataWithTime:km:elec:speed:)]) {
        [_delegete updateUIDataWithTime:self.currentTime.text km:self.currentKM.text elec:self.currentElec.text speed:self.speed.text];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)getDistance:(CLLocationCoordinate2D) destCoord{
    WEAKSELF;
    [[FEMapManager manager] getDistanceFromCoord:_startCoord toCoord:destCoord finishBlock:^(id  _Nonnull response, FEAMapSearchType type, NSError * _Nonnull error) {
        NSArray *arr = ((AMapDistanceSearchResponse *)response).results;
        MYLog(@"%@--count:%d",arr,arr.count);
        if (arr.count) {
            AMapDistanceResult *distance = [arr firstObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                if(distance.distance>50){
                    weakSelf.kmNum = distance.distance;
                    [weakSelf updateData];
                }
            });
        }
    }];
}

- (void)addView {
    WEAKSELF;
    _endBtn.endBlock = ^(FEStopProcessBtn * _Nonnull btn) {
        //结束
        [weakSelf endCycling];
    };
}

- (void)endCycling {
    [[FETimeManager shareManager] endTiming];
    [self submitCyclingDataRequest];
}

- (IBAction)tapAction:(UIButton *)sender {
    if (sender.tag == 0) {
        //展开地图
        FECycleMapViewController *vc = [[FECycleMapViewController alloc] init];
        self.delegete = vc;
        vc.startCoord = _startCoord;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1) {
        //stop
        sender.hidden = YES;
        _goonBtn.hidden = NO;
        _endBtn.hidden = NO;
        [[FETimeManager shareManager] stopTiming];
        
    }else if(sender.tag == 2) {
        //goon
        _stopBtn.hidden = NO;
        _goonBtn.hidden = YES;
        _endBtn.hidden = YES;
        [[FETimeManager shareManager] goonTiming];
    }
}

- (void)submitCyclingDataRequest {
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    
    [parameter setValue:[self getRawSignStringL] forKey:@"raw"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(CirclingSubHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *data = (NSDictionary *)responseObject;
            if ([data[@"code"] intValue] == KSuccessCode) {
                    [[NSUserDefaults standardUserDefaults] setInteger:(NSInteger)weakSelf.kmNum forKey:kFECycleKM];
                    [[NSUserDefaults standardUserDefaults] setInteger:(NSInteger)weakSelf.sec forKey:kFECycleTime];
                    [weakSelf.navigationController popViewControllerAnimated:YES];
                }else {
                    MTSVPShowInfoText(data[@"msg"]);
                }
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
//    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)getRawSignStringL{
    NSDictionary *rowDic = @{@"mileage":[NSString stringWithFormat:@"%.2f",_kmNum/1000],@"usetime":[NSString stringWithFormat:@"%d",(int)_sec]};
    NSString *json = [rowDic convertToJsonString];
    json = [json stringWithBase64];
    json = [NSString stringWithFormat:@"%@%@",[NSString randomStrWithLength:6],json];
    return [json stringWithBase64];
}

- (void)dealloc{
    [[FETimeManager shareManager] endTiming];
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
