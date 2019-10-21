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
@property(nonatomic, strong)UIView *shadowView;
@property(nonatomic, strong)UIButton *goGiftBtn;
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
    [self addSubview:self.bgImgView];
    [self addSubview:self.cancelBtn];
    [self.bgImgView addSubview:self.goGiftBtn];
    [self makeUpConstriant];
}
#pragma mark 约束适配
-(void)makeUpConstriant{
    [self.bgImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self).offset(-15);
        make.bottom.mas_equalTo(-WIDTH_LY(45));
    }];
    [self.goGiftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.bgImgView);
        make.right.mas_equalTo(self.bgImgView);
        make.height.mas_equalTo(100);
        make.bottom.mas_equalTo(self.bgImgView);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.bgImgView.mas_bottom).offset(HEIGHT_LY(10));
        make.width.mas_equalTo(WIDTH_LY(26));
        make.height.mas_equalTo(WIDTH_LY(26));
        make.centerX.mas_equalTo(self);
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
        [_cancelBtn setImage:[UIImage imageNamed:@"wkc_Close1"] forState:UIControlStateNormal];
        WEAKSELF;
        [_cancelBtn bk_addEventHandler:^(id sender) {
            [weakSelf hidden];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
-(UIView *)shadowView{
    if (!_shadowView) {
        _shadowView =[[UIView alloc]init];
        _shadowView.backgroundColor =UIColorFromHex(0x8E8E8E);
        [_shadowView setAlpha:0.6];
    }
    return _shadowView;
}
-(UIButton *)goGiftBtn{
    if (!_goGiftBtn) {
        _goGiftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        WEAKSELF;
        [_goGiftBtn bk_addEventHandler:^(id sender) {
            if ([weakSelf.localDelegate respondsToSelector:@selector(goGiftAction)]) {
                [weakSelf.localDelegate goGiftAction];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _goGiftBtn;
}
- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self.shadowView];
    [keyWindow addSubview:self];
    
      [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(keyWindow);
           make.right.mas_equalTo(keyWindow);
           make.top.mas_equalTo(keyWindow);
           make.bottom.mas_equalTo(keyWindow);
      }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
           make.width.mas_equalTo(280);
           make.height.mas_equalTo(498);
           make.center.mas_equalTo(keyWindow);
           
    }];
}

- (void)hidden {
    [self.shadowView removeFromSuperview];
    [self removeFromSuperview];
}
@end
