//
//  FEMapCategView.h
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/8.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEViewXib.h"
NS_ASSUME_NONNULL_BEGIN

@interface FEMapCategView : FEViewXib

@property (copy, nonatomic) void(^comfirm)(FEMapCategView *,NSString *);
- (void)show;
- (void)hidden;
@end

NS_ASSUME_NONNULL_END
