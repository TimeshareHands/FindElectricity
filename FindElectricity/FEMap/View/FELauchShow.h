//
//  FELauchShow.h
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/5.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEViewXib.h"
NS_ASSUME_NONNULL_BEGIN

@interface FELauchShow : FEViewXib
- (IBAction)tapAction:(UIButton *)sender;
@property (copy, nonatomic) void(^didClick)(FELauchShow *,NSInteger);
- (void)show;
- (void)hidden;
- (void)getShowData;
@end

NS_ASSUME_NONNULL_END
