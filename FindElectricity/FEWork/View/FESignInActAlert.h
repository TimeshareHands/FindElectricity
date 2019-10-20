//
//  FESignInActAlert.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/20.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FESignInActAlert : UIView
@property (copy, nonatomic) void(^didClick)(FESignInActAlert *,NSInteger);
-(void)setEvalue:(NSString *)evalue;
- (void)show;
- (void)hidden;
@end

NS_ASSUME_NONNULL_END
