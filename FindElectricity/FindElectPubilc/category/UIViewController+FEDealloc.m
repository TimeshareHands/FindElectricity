//
//  UIViewController+FEDealloc.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/8.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "UIViewController+FEDealloc.h"
#import <FBRetainCycleDetector.h>
#import "FEFunction.h"

@implementation UIViewController (FEDealloc)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sky_swizzleSelector([self class], @selector(viewWillDisappear:), @selector(sky_viewWillDisappear:));
        sky_swizzleSelector([self class], NSSelectorFromString(@"dealloc"), @selector(sky_dealloc));
    });
}

- (void)sky_dealloc {
    MYLog(@"%@被销毁了", self);
    [self sky_dealloc];
}

- (void)sky_viewWillDisappear:(BOOL)animated {
    FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
    [detector addCandidate:self];
    NSSet *retainCycles = [detector findRetainCycles];
    if(retainCycles.count){
        MYLog(@"--引用循环-%@:%@--",self, retainCycles);
    }
    [self sky_viewWillDisappear:animated];
}
@end
