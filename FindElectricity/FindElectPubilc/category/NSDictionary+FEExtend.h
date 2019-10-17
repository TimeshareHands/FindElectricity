//
//  NSDictionary+FEExtend.h
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/16.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//


#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (FEExtend)

/**
 字典转字符
 */
- (NSString*)convertToJsonString;
@end

NS_ASSUME_NONNULL_END
