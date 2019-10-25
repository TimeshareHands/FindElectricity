//
//  FEWorkGetGiftAlertView.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FEWorkGetGiftAlertViewDelegate <NSObject>

-(void)continueChouJiang;

@end
NS_ASSUME_NONNULL_BEGIN

@interface FEWorkGetGiftAlertView : UIView
@property (nonatomic, weak)id <FEWorkGetGiftAlertViewDelegate>localDelegate;
@property (copy, nonatomic) void(^didClick)(FEWorkGetGiftAlertView *,NSInteger);
-(void)setImage:(UIImage *)centerImage andTopText:(NSString *)topText;
- (void)show;
- (void)hidden;
@end

NS_ASSUME_NONNULL_END
