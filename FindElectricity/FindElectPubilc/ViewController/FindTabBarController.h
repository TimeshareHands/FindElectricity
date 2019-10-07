//
//  CSTabBarController.h
//  CSDirectBank
//
//  Created by on 15/8/14.
//  Copyright (c) 2015年 . All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemonTabbarItem.h"
@interface FindTabBarController : UITabBarController

UIKIT_EXTERN NSString *const kSwitchTabNotification;

- (instancetype)init;
- (void)switchTab:(NSIndexPath *)indexPath;
@end
