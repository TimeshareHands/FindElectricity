//
//  FEWorkInviteAlertView.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkInviteAlertView.h"
@interface FEWorkInviteAlertView()
@property(nonatomic, strong)UIImageView *bgImgView;
@property(nonatomic, strong)UIButton *confirmBtn;
@property(nonatomic, strong)UIButton *cancelBtn;
@end

@implementation FEWorkInviteAlertView

-(id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}

#pragma mark 添加视图
-(void)addView{
    [self makeUpConstriant];
}
#pragma mark 约束适配
-(void)makeUpConstriant{
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
}

#pragma mark getter
-(UIImageView *)bgImgView{
    if (!_bgImgView) {
        _bgImgView =[[UIImageView alloc]init];
        [_bgImgView setImage:[UIImage imageNamed:@"wkc_banner1"]];
    }
    return _bgImgView;
}
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _confirmBtn;
}
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _cancelBtn;
}
@end
