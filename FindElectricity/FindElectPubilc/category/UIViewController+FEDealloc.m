//
//  UIViewController+FEDealloc.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/8.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "UIViewController+FEDealloc.h"


@implementation UIViewController (FEDealloc)
+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method method1 = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
        Method method2 = class_getInstanceMethod([self class], @selector(my_dealloc));
        method_exchangeImplementations(method1, method2);
    });
}

- (void)my_dealloc
{
    MYLog(@"%@被销毁了", self);
    [self my_dealloc];
}
@end
