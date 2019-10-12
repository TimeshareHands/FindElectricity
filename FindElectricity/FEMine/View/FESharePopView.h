//
//  FESharePopView.h
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/11.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEViewXib.h"

NS_ASSUME_NONNULL_BEGIN

@interface FESharePopView : FEViewXib
@property (copy, nonatomic) void(^didClick)(FESharePopView *,NSInteger);
- (void)show;
- (void)hidden;
@end

NS_ASSUME_NONNULL_END
