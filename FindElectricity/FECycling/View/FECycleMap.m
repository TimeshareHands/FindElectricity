//
//  FECycleMap.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/9.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FECycleMap.h"
#import <AMapLocationKit/AMapLocationKit.h>

@interface FECycleMap()<AMapLocationManagerDelegate>
//@property (nonatomic, strong) MAMapView *mapView;
@property (nonatomic, strong) UIImageView *centerImg;
@property (nonatomic, strong) UIButton *positionBtn;
@property (nonatomic, strong) AMapLocationManager *locationManager;
@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;
@property (nonatomic, assign) BOOL headingCalibration;
@property (nonatomic, strong) CLLocation *feUserLocation;
@property (nonatomic, strong) AMapLocationReGeocode *reGeocode;
@property (nonatomic, assign) CGFloat annotationViewAngle;

@end

@implementation FECycleMap

- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.showsUserLocation = YES;
        [self addView];
        [self configLocationManager];
    }
    return self;
}

- (void)configLocationManager
{
    _headingCalibration = NO;

    self.locationManager = [[AMapLocationManager alloc] init];

    [self.locationManager setDelegate:self];
    
    //设置不允许系统暂停定位
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    //设置允许在后台定位
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    
    //设置允许连续定位逆地理
    [self.locationManager setLocatingWithReGeocode:YES];
    
    //设置开启虚拟定位风险监测，可以根据需要开启
    [self.locationManager setDetectRiskOfFakeLocation:NO];
}

- (void)addView{
    [self addSubview:self.positionBtn];
    [self addSubview:self.centerImg];
    [self.centerImg mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.mas_equalTo(31);
           make.width.mas_equalTo(20);
           make.centerX.centerY.equalTo(self);
       }];
       [self.positionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.height.width.mas_equalTo(36);
           make.bottom.equalTo(self).offset(-10);
           make.right.equalTo(self).offset(-10);
       }];
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
    MYLog(@"location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress);
    
    //获取到定位信息
    if (reGeocode)
    {
        self.reGeocode = reGeocode;
    }
    else
    {
        self.feUserLocation = location;

    }
    
}

- (BOOL)amapLocationManagerShouldDisplayHeadingCalibration:(AMapLocationManager *)manager
{
    return _headingCalibration;
}

- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading
{
    CGFloat angle = newHeading.trueHeading*M_PI/180.0f + M_PI - _annotationViewAngle;
    NSLog(@"################### heading : %f - %f", newHeading.trueHeading, newHeading.magneticHeading);
    _annotationViewAngle = newHeading.trueHeading*M_PI/180.0f + M_PI;
    //        _annotationView.transform =  CGAffineTransformRotate(_annotationView.transform ,angle);
}

//进行单次带逆地理定位请求
- (void)reGeocodeAction
{
    [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
}

//进行单次定位请求
- (void)locAction
{
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
        
        
        //有无逆地理信息，annotationView的标题显示的字段不一样
        if (regeocode)
        {
            weakSelf.reGeocode = regeocode;
//            [annotation setTitle:[NSString stringWithFormat:@"%@", regeocode.formattedAddress]];
//            [annotation setSubtitle:[NSString stringWithFormat:@"%@-%@-%.2fm", regeocode.citycode, regeocode.adcode, location.horizontalAccuracy]];
        }
        else
        {
            weakSelf.feUserLocation = location;
//            [annotation setTitle:[NSString stringWithFormat:@"lat:%f;lon:%f;", location.coordinate.latitude, location.coordinate.longitude]];
//            [annotation setSubtitle:[NSString stringWithFormat:@"accuracy:%.2fm", location.horizontalAccuracy]];
        }
        
    };
}

//开始进行连续定位
- (void)startUpdatingLocation
{
    [self.locationManager startUpdatingLocation];
}

//停止定位
- (void)stopUpdatingLocation
{
    [self.locationManager stopUpdatingLocation];
    [self.locationManager setDelegate:nil];
}

//角度定位
- (void)startHeadingLocation
{
    _headingCalibration = YES;
    [self startUpdatingLocation];
    
    if ([AMapLocationManager headingAvailable] == YES)
    {
        [self.locationManager startUpdatingHeading];
    }
}

- (UIButton *)positionBtn {
    if (!_positionBtn) {
        _positionBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_positionBtn setImage:[UIImage imageNamed:@"map_location"] forState:UIControlStateNormal];
        WEAKSELF;
        [_positionBtn bk_addEventHandler:^(UIButton *sender) {
            //当前定位
            [weakSelf setCenterCoordinate:weakSelf.feUserLocation.coordinate animated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _positionBtn;
}

- (UIImageView *)centerImg {
    if (!_centerImg) {
        _centerImg = [[UIImageView alloc] init];
        _centerImg.image = [UIImage imageNamed:@"map_position.png"];
    }
    return _centerImg;
}

- (void)dealloc
{
    [self stopUpdatingLocation];
    
    self.completionBlock = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
