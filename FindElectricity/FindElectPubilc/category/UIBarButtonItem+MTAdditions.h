//
//  UIBarButtonItem+MTAdditions.h
//  MenYaTool
//
//  Created by DongQiangLi on 2017/7/21.
//  Copyright © 2017年 门牙商业视频. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface UIBarButtonItem(MTAdditions)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon imageScale:(CGFloat)imageScale target:(id)target action:(SEL)action;

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action;
+ (UIBarButtonItem *)itemWithTitle:(NSString *)tilte target:(id)target action:(SEL)action color:(UIColor *)color;
+ (UIBarButtonItem *)itemWithTitle:(NSString *)tilte;
@end
