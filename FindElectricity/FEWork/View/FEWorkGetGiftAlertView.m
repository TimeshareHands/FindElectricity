//
//  FEWorkGetGiftAlertView.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkGetGiftAlertView.h"
@interface FEWorkGetGiftAlertView()
@property(nonatomic, strong)UIView *shadowView;
@property(nonatomic, strong)UIImageView *topImgLogo;
@property(nonatomic, strong)UILabel *topLbl;
@property(nonatomic, strong)UIImageView *centerImageView;
@property(nonatomic, strong)UIButton *leftBtn;
@property(nonatomic, strong)UIButton *rightBtn;
@property(nonatomic, strong)UIButton *cancelBtn;
@end

@implementation FEWorkGetGiftAlertView

- (id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}

#pragma mark 添加视图
- (void)addView{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.topImgLogo];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.topLbl];
    [self addSubview:self.centerImageView];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self makeUpConstriant];
}

#pragma mark 约束适配
- (void)makeUpConstriant{
    [self.topImgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(-60);
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.mas_equalTo(-13);
           make.top.mas_equalTo(16);
           make.width.mas_equalTo(14);
           make.height.mas_equalTo(14);
       }];
    [self.topLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(44);
        make.right.mas_equalTo(-44);
        make.top.mas_equalTo(self.topImgLogo.mas_bottom).offset(30);
    }];
    [self.centerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.topLbl.mas_bottom).offset(30);
    }];
 
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-20);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(90);
        make.left.mas_equalTo(25);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.mas_equalTo(-20);
          make.height.mas_equalTo(30);
          make.width.mas_equalTo(90);
          make.right.mas_equalTo(-25);
    }];
   
}

#pragma mark getter
- (UIImageView *)topImgLogo{
    if (!_topImgLogo) {
        _topImgLogo =[[UIImageView alloc]init];
        [_topImgLogo setImage:[UIImage imageNamed:@"wkc_choujiangAlert"]];
    }
    return _topImgLogo;
}
- (UILabel *)topLbl{
    if (!_topLbl) {
        _topLbl =[[UILabel alloc]init];
        [_topLbl setFont:Demon_18_Font];
        [_topLbl setText:@"抽中卫生纸礼品卡1张"];
        [_topLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _topLbl;
}
- (UIImageView *)centerImageView{
    if (!_centerImageView) {
        _centerImageView =[[UIImageView alloc]init];
        [_centerImageView setImage:[UIImage imageNamed:@"wkc_ChoujiangGet"]];
    }
    return _centerImageView;
}
- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"知道了" forState:UIControlStateNormal];
        [_leftBtn.titleLabel setFont:Demon_15_Font];
         [_leftBtn setBackgroundColor:UIColorFromHex(0xE26A41)];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"继续抽奖" forState:UIControlStateNormal];
        [_rightBtn.titleLabel setFont:Demon_15_Font];
        [_rightBtn setBackgroundColor:UIColorFromHex(0xE26A41)];
    }
    return _rightBtn;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setImage:[UIImage imageNamed:@"wkc_Close"] forState:UIControlStateNormal];
        [_cancelBtn bk_addEventHandler:^(id sender) {
            [self hidden];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
-(UIView *)shadowView{
    if (!_shadowView) {
        _shadowView =[[UIView alloc]init];
    }
    return _shadowView;
}

- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
    [keyWindow addSubview:self.shadowView];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(keyWindow);
         make.right.mas_equalTo(keyWindow);
         make.top.mas_equalTo(keyWindow);
         make.bottom.mas_equalTo(keyWindow);
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(54);
        make.right.mas_equalTo(-54);
        make.center.mas_equalTo(keyWindow);
        make.height.mas_equalTo(330);
    }];
}

- (void)hidden {
    [self removeFromSuperview];
}
@end
