//
//  FESharePopView.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/11.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FESharePopView.h"

@implementation FESharePopView
- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
}

- (void)hidden {
    [self removeFromSuperview];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)tapAction:(UIButton *)sender {
    if (sender.tag > 0) {
        if (_didClick) {
            _didClick(self,sender.tag);
        }
    }
    [self hidden];
}


@end
