//
//  UIBarButtonItem+MTAdditions.m
//  MenYaTool
//
//  Created by DongQiangLi on 2017/7/21.
//  Copyright © 2017年 门牙商业视频. All rights reserved.
//

#import "UIBarButtonItem+MTAdditions.h"
#import "UIButton+FEHitRect.h"
@implementation UIBarButtonItem(MTAdditions)
+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightIcon] forState:UIControlStateHighlighted];
    button.frame = (CGRect){CGPointZero,button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon highlightIcon:(NSString *)highlightIcon imageScale:(CGFloat)imageScale target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [button setBackgroundImage:[UIImage imageNamed:highlightIcon] forState:UIControlStateHighlighted];
    CGSize btnSize = CGSizeMake(button.currentBackgroundImage.size.width * imageScale, button.currentBackgroundImage.size.height * imageScale);
//    button.frame = (CGRect){CGPointZero,btnSize};
    button.frame = CGRectMake(0, 0, btnSize.width+140, btnSize.height+40);
//    button.backgroundColor = [UIColor redColor];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
    button.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
//    button.imageEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
    button.hitEdgeInsets = UIEdgeInsetsMake(0, -36, 0, 0);
    button.hitScale = 2;
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    button.frame = (CGRect){CGPointZero,button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)tilte target:(id)target action:(SEL)action color:(UIColor *)color
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = (CGRect){CGPointZero,CGSizeMake(40, 36)};
    [button setTitle:tilte forState:UIControlStateNormal];
    [button setTitleColor:color forState:UIControlStateNormal];
    button.userInteractionEnabled = YES;
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

+ (UIBarButtonItem *)itemWithTitle:(NSString *)tilte
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = (CGRect){CGPointZero,CGSizeMake(50, 36)};
    [button setTitle:tilte forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    button.userInteractionEnabled = NO;
    button.titleLabel.font = [UIFont systemFontOfSize:15];
    return [[UIBarButtonItem alloc]initWithCustomView:button];
}

@end
