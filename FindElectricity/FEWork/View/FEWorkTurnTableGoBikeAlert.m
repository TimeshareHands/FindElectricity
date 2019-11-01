//
//  FEWorkTurnTableGoBikeAlert.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/11/1.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkTurnTableGoBikeAlert.h"
@interface FEWorkTurnTableGoBikeAlert ()
@property(nonatomic, strong)UIView *shadowView;
@property(nonatomic, strong)UIImageView *topImgLogo;
@property(nonatomic, strong)UILabel *topLbl;
@property(nonatomic, strong)UILabel *centerLbl;
@property(nonatomic, strong)UIButton *confirmBtn;
@property(nonatomic, strong)UIButton *cancelBtn;
@property(nonatomic, strong)UIImageView *centerImg;
@end
@implementation FEWorkTurnTableGoBikeAlert

- (id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}

#pragma mark 添加视图
- (void)addView{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.cancelBtn];
    [self addSubview:self.topImgLogo];
    [self addSubview:self.topLbl];
    [self addSubview:self.centerLbl];
    [self addSubview:self.centerImg];
    [self addSubview:self.confirmBtn];
    [self makeUpConstriant];
}

#pragma mark 约束适配
- (void)makeUpConstriant{
   
    [self.topImgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(WIDTH_LY(-60));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-13);
        make.top.mas_equalTo(WIDTH_LY(16));
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(14);
    }];
    [self.topLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(44);
        make.right.mas_equalTo(-44);
        make.top.mas_equalTo(self.topImgLogo.mas_bottom).offset(WIDTH_LY(30));
    }];
    [self.centerLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.topLbl.mas_bottom).offset(WIDTH_LY(20));
    }];
    [self.centerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.centerLbl.mas_bottom).offset(WIDTH_LY(30));
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.centerImg.mas_bottom).offset(WIDTH_LY(20));
        make.height.mas_equalTo(WIDTH_LY(40));
        make.width.mas_equalTo(160);
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
        [_topLbl setText:@"当天抽奖次数已用完"];
        [_topLbl setTextColor:UIColorFromHex(0xf6602a)];
        [_topLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _topLbl;
}
- (UILabel *)centerLbl{
    if (!_centerLbl) {
        _centerLbl =[[UILabel alloc]init];
        [_centerLbl setText:@"去骑行，获得电量值\n兑换抽奖机会"];
        [_centerLbl setFont:Demon_14_Font];
        [_centerLbl setNumberOfLines:0];
        
    }
    return _centerLbl;
}
-(UIImageView *)centerImg{
    if (!_centerImg) {
        _centerImg =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wkm_bike"]];
        [_centerImg setUserInteractionEnabled:YES];
        WEAKSELF;
        [_centerImg bk_whenTapped:^{
           if ([weakSelf.localDelegate respondsToSelector:@selector(goBike)]) {
                [weakSelf hidden];
                [weakSelf.localDelegate goBike];
            }
        }];
    }
    return _centerImg;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"点击去骑行" forState:UIControlStateNormal];
        [_confirmBtn setTitleColor:UIColorFromHex(0xAE4D47) forState:UIControlStateNormal];
        WEAKSELF;
        [_confirmBtn bk_addEventHandler:^(id sender) {
            if ([weakSelf.localDelegate respondsToSelector:@selector(goBike)]) {
                [weakSelf hidden];
                [weakSelf.localDelegate goBike];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
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
        _shadowView.backgroundColor =[UIColor blackColor];
        [_shadowView setAlpha:0.1];
    }
    return _shadowView;
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
        make.left.mas_equalTo(54);
        make.right.mas_equalTo(-54);
        make.center.mas_equalTo(keyWindow);
        make.height.mas_equalTo(330);
    }];
}

- (void)hidden {
    [self.shadowView removeFromSuperview];
    [self removeFromSuperview];
}

@end
