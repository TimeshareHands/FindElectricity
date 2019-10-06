//
//  FELauchShow.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/5.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FELauchShow.h"

@implementation FELauchShow

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
    if (_didClick) {
        _didClick(self,sender.tag);
    }
}
@end
