//
//  FEWorkGetGiftAlertView.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FEWorkGetGiftAlertView : UIView

@property (copy, nonatomic) void(^didClick)(FEWorkGetGiftAlertView *,NSInteger);
- (void)show;
- (void)hidden;
@end

NS_ASSUME_NONNULL_END
