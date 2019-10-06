//
//  FEUserOperation.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/5.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEUserOperation.h"

static FEUserOperation *manager = nil;
static dispatch_once_t onceToken;
@implementation FEUserOperation
//单例
+ (FEUserOperation *)manager {
    
    dispatch_once(&onceToken, ^{
        manager = [[FEUserOperation alloc] init];
    });
    return manager;
}
@end
