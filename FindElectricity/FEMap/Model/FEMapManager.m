//
//  FEMapManager.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMapManager.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface FEMapManager()

@end

static FEMapManager *manager = nil;
@implementation FEMapManager
+ (FEMapManager *)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FEMapManager alloc] init];
    });
    return manager;
}


@end
