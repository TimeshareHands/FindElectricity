//
//  FEFunction.h
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/14.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#ifndef FEFunction_h
#define FEFunction_h

#import <objc/runtime.h>

static inline BOOL sky_addMethod(Class theClass, SEL selector, Method method) {
    return class_addMethod(theClass, selector,  method_getImplementation(method),  method_getTypeEncoding(method));
}

static inline IMP sky_replaceMethod(Class theClass, SEL selector, Method method) {
    return class_replaceMethod(theClass, selector,  method_getImplementation(method),  method_getTypeEncoding(method));
}


static inline void sky_swizzleSelector(Class theClass, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(theClass, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(theClass, swizzledSelector);
    if (sky_addMethod(theClass,originalSelector,swizzledMethod)) {
        sky_replaceMethod(theClass,swizzledSelector,originalMethod);
    }else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static inline NSString * timeFormt(NSInteger sec){
    return [NSString stringWithFormat:@"%02d:%02d",sec/60,sec%60];
}

#endif /* FEFunction_h */
