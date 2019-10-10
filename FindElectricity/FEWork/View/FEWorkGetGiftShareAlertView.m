//
//  FEWorkGetGiftAlertView.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkGetGiftShareAlertView.h"
@interface FEWorkGetGiftShareAlertView()
@property(nonatomic, strong)UIImageView *topImgLogo;
@property(nonatomic, strong)UILabel *topLbl;
@property(nonatomic, strong)UILabel *centerLbl;
@property(nonatomic, strong)UIButton *leftBtn;
@property(nonatomic, strong)UIButton *rightBtn;
@property(nonatomic, strong)UILabel *leftBottomLbl;
@property(nonatomic, strong)UILabel *rightBottomLbl;
@property(nonatomic, strong)UIButton *cancelBtn;
@end

@implementation FEWorkGetGiftShareAlertView
- (id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}

#pragma mark 添加视图
- (void)addView{
    [self addSubview:self.topImgLogo];
    [self addSubview:self.topLbl];
    [self addSubview:self.centerLbl];
    [self addSubview:self.leftBtn];
    [self addSubview:self.rightBtn];
    [self addSubview:self.leftBottomLbl];
    [self addSubview:self.rightBottomLbl];
    [self makeUpConstriant];
}

#pragma mark 约束适配
- (void)makeUpConstriant{
    [self.topImgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(-60);
    }];
    [self.topLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(44);
        make.right.mas_equalTo(-44);
    }];
    [self.centerLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.topLbl.mas_bottom);
    }];
    [self.leftBottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-41);
        make.left.mas_equalTo(26);
    }];
    [self.rightBottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-41);
        make.right.mas_equalTo(-26);
    }];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.leftBottomLbl.mas_top).offset(-5);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(30);
        make.centerX.mas_equalTo(self.leftBottomLbl.mas_centerX);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.mas_equalTo(self.rightBottomLbl.mas_top).offset(-5);
          make.height.mas_equalTo(30);
          make.width.mas_equalTo(30);
          make.centerX.mas_equalTo(self.rightBottomLbl.mas_centerX);
    }];
   
}

#pragma mark getter
- (UIImageView *)topImgLogo{
    if (!_topImgLogo) {
        _topImgLogo =[[UIImageView alloc]init];
    }
    return _topImgLogo;
}
- (UILabel *)topLbl{
    if (!_topLbl) {
        _topLbl =[[UILabel alloc]init];
        [_topLbl setFont:Demon_18_Font];
        [_topLbl setText:@"当天抽奖次数已用完"];
    }
    return _topLbl;
}
- (UILabel *)centerLbl{
    if (!_centerLbl) {
        _centerLbl =[[UILabel alloc]init];
        [_centerLbl setText:@"拉好友一起来抽奖\n获得更多抽奖机会"];
        [_centerLbl setFont:Demon_14_Font];
        [_centerLbl setNumberOfLines:0];
    }
    return _centerLbl;
}
- (UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _leftBtn;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _rightBtn;
}
- (UILabel *)leftBottomLbl{
    if (!_leftBottomLbl) {
        _leftBottomLbl =[[UILabel alloc]init];
        [_leftBottomLbl setText:@"分享微信好友"];
        [_leftBottomLbl setFont:Demon_14_Font];
        [_leftBottomLbl setTextColor:UIColorFromHex(0xB4B4B4)];
    }
    return _leftBottomLbl;
}
- (UILabel *)rightBottomLbl{
    if (!_rightBottomLbl) {
        _rightBottomLbl =[[UILabel alloc]init];
        [_rightBottomLbl setText:@"分享朋友圈"];
        [_rightBottomLbl setFont:Demon_14_Font];
        [_rightBottomLbl setTextColor:UIColorFromHex(0xB4B4B4)];
    }
    return _rightBottomLbl;
}
- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    }
    return _cancelBtn;
}
@end
