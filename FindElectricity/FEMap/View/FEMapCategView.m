//
//  FEMapCategView.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/8.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMapCategView.h"
@interface FEMapCategView()
@property (weak, nonatomic) IBOutlet UIImageView *select1;
@property (weak, nonatomic) IBOutlet UIImageView *select2;
@property (weak, nonatomic) IBOutlet UIImageView *select3;

@end
@implementation FEMapCategView
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
    if (sender.tag==4){
        [self hidden];
        if (_comfirm) {
            NSString *status = [NSString stringWithFormat:@"%d-%d-%d",_select1.isHidden,_select2.isHidden,_select3.isHidden];
            _comfirm(self,status);
        }
    }else if (sender.tag == 1){
        _select3.hidden = !_select3.hidden;
    }else if (sender.tag == 2){
        _select1.hidden = !_select1.hidden;
    }else if (sender.tag == 3){
        _select2.hidden = !_select2.hidden;
    }else {
        [self hidden];
    }
}

@end
