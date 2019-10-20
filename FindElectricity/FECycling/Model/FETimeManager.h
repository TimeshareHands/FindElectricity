//
//  FETimeManager.h
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/14.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FETimeManager : NSObject

@property (copy,nonatomic) void(^timeRunBlock)(NSTimeInterval sec);
/**
 单例
 */
+ (FETimeManager *)shareManager;

/**
计时开始
*/
- (void)startTiming;

/**
计时结束
*/
- (void)endTiming;

/**
计时继续
*/
- (void)goonTiming;

/**
计时停止
*/
- (void)stopTiming;
@end

NS_ASSUME_NONNULL_END
