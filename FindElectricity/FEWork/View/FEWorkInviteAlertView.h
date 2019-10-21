//
//  FEWorkInviteAlertView.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FEWorkInviteAlertViewDelegate <NSObject>

-(void)goGiftAction;

@end
NS_ASSUME_NONNULL_BEGIN

@interface FEWorkInviteAlertView : UIView
@property(nonatomic, weak)id<FEWorkInviteAlertViewDelegate>localDelegate;
- (void)show;
- (void)hidden;

@end

NS_ASSUME_NONNULL_END
