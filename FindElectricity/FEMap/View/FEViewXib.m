//
//  FEViewXib.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/5.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEViewXib.h"

@implementation FEViewXib
+ (instancetype)createView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass([self class]) owner:self options:nil] firstObject];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
