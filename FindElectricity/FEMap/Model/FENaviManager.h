//
//  FENaviManager.h
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/22.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapNaviKit/AMapNaviKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface FENaviManager : NSObject
/**
单例模式
*/
+ (FENaviManager *)manager;
/**!
  传入终点
 */
- (void)routePlanWithEndPoint:(CLLocationCoordinate2D)desPoint name:(NSString *)name;
@end

NS_ASSUME_NONNULL_END
