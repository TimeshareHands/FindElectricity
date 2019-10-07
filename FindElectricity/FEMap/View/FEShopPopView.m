//
//  FEShopPop.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/7.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEShopPopView.h"

@implementation FEShopPopView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnAct:(UIButton *)sender {
    if (_didClick) {
        _didClick(sender.tag);
    }
}
@end
