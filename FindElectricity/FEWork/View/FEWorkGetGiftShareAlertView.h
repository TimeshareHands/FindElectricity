//
//  FEWorkGetGiftAlertView.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FEWorkGetGiftShareAlertView : UIView
@property (copy, nonatomic) void(^didClick)(FEWorkGetGiftShareAlertView *,NSInteger);
- (void)show;
- (void)hidden;
@end

NS_ASSUME_NONNULL_END
