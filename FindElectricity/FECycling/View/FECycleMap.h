//
//  FECycleMap.h
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/9.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef void (^FEMapLocatUpdateBlock)(CLLocation *location, AMapLocationReGeocode *regeocode, CGFloat locationAngle,NSError *error);
@interface FECycleMap : MAMapView
@property (copy, nonatomic) FEMapLocatUpdateBlock locationUpdateBlock;
@property (assign, nonatomic) BOOL isShowMapCenter;
@property (assign, nonatomic) BOOL isShowLocBtn;

//进行单次带逆地理定位请求
- (void) reGeocodeAction;
//进行单次定位请求
- (void) locAction;
//开始进行连续定位
- (void)startUpdatingLocation;
//停止定位
- (void)stopUpdatingLocation;
//角度定位
- (void)startHeadingLocation;
//后台定位
- (void)setAllowsBackgroundLocationUpdates:(BOOL)allow;
@end

NS_ASSUME_NONNULL_END
