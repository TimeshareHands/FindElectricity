//
//  FEWorkReceiveAddressAlert.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/23.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkReceiveAddressAlert.h"
@interface FEWorkReceiveAddressAlert()
@property(nonatomic, strong)UIView *shadowView;
@property(nonatomic, strong)UIImageView *topImgLogo;
@property(nonatomic, strong)UILabel *topLbl;
@property(nonatomic, strong)UILabel *centerLabel;
@property(nonatomic, strong)UILabel *bottomLabel;
@property(nonatomic, strong)UIButton *rightBtn;
@property(nonatomic, strong)UIButton *cancelBtn;
@property(nonatomic, strong)UIImageView *arrowLeft;
@property(nonatomic, copy)NSString *goodsId;
@end
@implementation FEWorkReceiveAddressAlert

- (id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}
- (void)setId:(NSString *)goodsId{
    self.goodsId =goodsId;
}
#pragma mark 添加视图
- (void)addView{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.topImgLogo];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.topLbl];
    [self addSubview:self.centerLabel];
    [self addSubview:self.bottomLabel];
    [self addSubview:self.rightBtn];
    [self addSubview:self.arrowLeft];
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
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.topLbl.mas_bottom).offset(30);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.centerLabel.mas_bottom).offset(10);
    }];
    [self.arrowLeft mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(15);
        make.height.mas_equalTo(15);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.centerLabel.mas_centerY);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.mas_equalTo(-20);
          make.height.mas_equalTo(30);
          make.width.mas_equalTo(90);
          make.centerX.mas_equalTo(self);
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
        [_topLbl setText:@"收货地址"];
        [_topLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _topLbl;
}
- (UILabel *)centerLabel{
    if (!_centerLabel) {
        _centerLabel =[[UILabel alloc]init];
        NSString *address =[NSString stringWithFormat:@"%@",[FEUserOperation manager].userModel.address];
        [_centerLabel setText:address];
        [_centerLabel setUserInteractionEnabled:YES];
        WEAKSELF;
        [_centerLabel bk_whenTapped:^{
            if ([weakSelf.localDelegate respondsToSelector:@selector(gotoAddress)]) {
                [weakSelf.localDelegate gotoAddress];
            }
        }];
    }
    return _centerLabel;
}
- (UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel =[[UILabel alloc]init];
        NSString *name =[NSString stringWithFormat:@"%@",[FEUserOperation manager].userModel.contacts];
        NSString *mobile =[NSString stringWithFormat:@"%@",[FEUserOperation manager].userModel.mobile];
        [_bottomLabel setText:[NSString stringWithFormat:@"%@ %@",name,mobile]];
    }
    return _bottomLabel;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_rightBtn.titleLabel setFont:Demon_15_Font];
        [_rightBtn setBackgroundColor:UIColorFromHex(0xE26A41)];
        WEAKSELF;
        [_rightBtn bk_addEventHandler:^(id sender) {
            if ([weakSelf.localDelegate respondsToSelector:@selector(confirmlinqu:)]) {
                [weakSelf hidden];
                [weakSelf.localDelegate confirmlinqu:self.goodsId];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setImage:[UIImage imageNamed:@"wkc_Close"] forState:UIControlStateNormal];
        WEAKSELF
        [_cancelBtn bk_addEventHandler:^(id sender) {
            [weakSelf hidden];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}
-(UIView *)shadowView{
    if (!_shadowView) {
        _shadowView =[[UIView alloc]init];
        _shadowView.backgroundColor =[UIColor blackColor];
        [_shadowView setAlpha:0.1];
    }
    return _shadowView;
}
-(UIImageView *)arrowLeft{
    if (!_arrowLeft) {
        _arrowLeft =[[UIImageView alloc]init];
        [_arrowLeft setImage:[UIImage imageNamed:@"mine_arrown"]];
    }
    return _arrowLeft;
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
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.center.mas_equalTo(keyWindow);
        make.height.mas_equalTo(330);
    }];
}

- (void)hidden {
    [self.shadowView removeFromSuperview];
    [self removeFromSuperview];
}


@end
