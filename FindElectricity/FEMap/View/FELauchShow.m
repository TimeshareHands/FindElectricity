//
//  FELauchShow.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/5.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FELauchShow.h"
@interface FELauchShow()
@property (weak, nonatomic) IBOutlet UILabel *tip;

@end
@implementation FELauchShow

- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
}

- (void)hidden {
    [self removeFromSuperview];
}

- (void)getShowData {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(WelFare)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            NSDictionary *data = (NSDictionary *)responseObject;
            MYLog(@"%@",data);
            if ([data[@"code"] intValue] == KSuccessCode) {
                MTSVPDismiss;
                weakSelf.tip.text = data[@"msg"];
                if ([[FEUserOperation manager] didLogin]) {
                     [weakSelf show];
                }
            }else if ([data[@"code"] intValue] != 4010) {
                MTSVPShowInfoText(data[@"msg"]);
                [SVProgressHUD dismissWithDelay:3];
            }
            
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
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
