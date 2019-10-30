//
//  FEMapManager.h
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapSearchKit/AMapSearchKit.h>
NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,FEAMapSearchType) {
    FEAMapSearchTypeReGeocode = 0,
    FEAMapSearchTypeDistance = 1,
    FEAMapSearchTypeWeather = 2,
    FEAMapSearchTypePOI = 3,
};
typedef  void (^AMapSearchFinishBlock)(id response,FEAMapSearchType type,NSError *error);
@interface FEMapManager : NSObject
/**
单例模式
*/
+ (FEMapManager *)manager;

/**
获取逆地理位置信息
*/
- (void)regSearchFromCoord:(CLLocationCoordinate2D)point finishBlock:(AMapSearchFinishBlock)block;
/**
获取2点直线距离
*/
- (void)getDistanceFromCoord:(CLLocationCoordinate2D)from toCoord:(CLLocationCoordinate2D)toCoord finishBlock:(AMapSearchFinishBlock)block;
/**
获取天气信息
*/
- (void)weatherSearchCity:(NSString *)city finishBlock:(AMapSearchFinishBlock)block;
/**
获取POI信息
 */
- (void)poiSearchKeywords:(NSString *)keywords location:(AMapGeoPoint *)location finishBlock:(AMapSearchFinishBlock)block;

@end

NS_ASSUME_NONNULL_END
