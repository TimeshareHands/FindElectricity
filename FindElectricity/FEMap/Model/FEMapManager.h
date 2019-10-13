//
//  FEMapManager.h
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FEMapManager : NSObject
/**
单例模式
*/
+ (FEMapManager *)manager;

/**
获取位置信息
*/
@end

NS_ASSUME_NONNULL_END
