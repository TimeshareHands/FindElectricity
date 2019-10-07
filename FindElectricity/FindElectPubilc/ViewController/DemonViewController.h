//
//  DemonViewController.h
//  CSDirectBank
//
//  Created by 彭小坚 on 15/8/14.
//  Copyright (c) 2015年 彭小坚. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemonViewController : UIViewController
- (void)back;
- (void)setNavgaTitle:(NSString *)title;
- (void)leftBtnWithIcon:(NSString *)icon target:(id)target action:(SEL)action;
- (void)rightBtnWithIcon:(NSString *)icon target:(id)target action:(SEL)action;
- (void)rightBtnWithTitle:(NSString *)title target:(id)target action:(SEL)action color:(UIColor *)color;
//导航栏字体颜色
- (void)setNavgaTitleColor:(UIColor *)color;
//item字体颜色
- (void)setNavgaBarItemColor:(UIColor *)color;
//导航栏背景颜色
- (void)setNavgaBarTintColor:(UIColor *)color;
@end
