//
//  FETWorkGetPrizeIntroduceCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FETWorkGetPrizeIntroduceCell.h"

@interface FETWorkGetPrizeIntroduceCell()
@property(nonatomic ,strong)UIView *bgView;
@property(nonatomic ,strong)UILabel *topLabel;
@property(nonatomic ,strong)UILabel *leftLabel1;
@property(nonatomic ,strong)UILabel *leftLabel2;
@property(nonatomic ,strong)UIButton *leftBtn;
@property(nonatomic ,strong)UILabel *rightLabel1;
@property(nonatomic ,strong)UILabel *rightLabel2;
@property(nonatomic ,strong)UIButton *rightBtn;
@end

@implementation FETWorkGetPrizeIntroduceCell

-(id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}

#pragma mark -添加视图
-(void)addView{
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.topLabel];
    [self.bgView addSubview:self.leftLabel1];
    [self.bgView addSubview:self.leftLabel2];
    [self.bgView addSubview:self.leftBtn];
    [self.bgView addSubview:self.rightLabel1];
    [self.bgView addSubview:self.rightLabel2];
    [self.bgView addSubview:self.rightBtn];
    [self makeUpconstraint];
}
#pragma mark -约束适配
-(void)makeUpconstraint{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
         make.bottom.mas_equalTo(-5);
        make.top.mas_equalTo(self);
    }];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(20);
        make.width.mas_equalTo(300);
    }];
    [self.leftLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLabel.mas_bottom).offset(20);
        make.left.mas_equalTo(60);
    }];
    [self.leftLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftLabel1.mas_bottom).offset(10);
        make.centerX.mas_equalTo(self.leftLabel1);
    }];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.leftLabel2.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.centerX.mas_equalTo(self.leftLabel2);
    }];
    [self.rightLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.topLabel.mas_bottom).offset(20);
       make.right.mas_equalTo(self.bgView).offset(-60);
    }];
    [self.rightLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.rightLabel1.mas_bottom).offset(10);
       make.centerX.mas_equalTo(self.rightLabel1);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.rightLabel2.mas_bottom).offset(10);
       make.width.mas_equalTo(100);
       make.height.mas_equalTo(30);
       make.centerX.mas_equalTo(self.rightLabel2);
    }];
}
#pragma mark -添加视图
-(UIView *)bgView{
    if (!_bgView) {
        _bgView =[[UIView alloc]init];
        [_bgView setBackgroundColor:[UIColor whiteColor]];
    }
    return _bgView;
}
-(UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel =[[UILabel alloc]init];
        [_topLabel setText:@"点击抽奖抽取电量值，攒够礼品卡可领\n取礼品，电量值可以兑换礼品卡或者抽奖机会"];
        [_topLabel setFont:Demon_15_Font];
        [_topLabel setTextColor:UIColorFromHex(0x8542E5)];
        [_topLabel setNumberOfLines:0];
    }
    return _topLabel;
}
-(UILabel *)leftLabel1{
    if (!_leftLabel1) {
        _leftLabel1 =[[UILabel alloc]init];
        [_leftLabel1 setText:@"剩余抽奖次数"];
        [_leftLabel1 setFont:Demon_15_Font];
        [_leftLabel1 setTextAlignment:NSTextAlignmentCenter];
        [_leftLabel1 setTextColor:UIColorFromHex(0x8542E5)];
    }
    return _leftLabel1;
}
-(UILabel *)leftLabel2{
    if (!_leftLabel2) {
        _leftLabel2 =[[UILabel alloc]init];
        [_leftLabel2 setText:@"0次"];
        [_leftLabel2 setFont:Demon_15_Font];
         [_leftLabel2 setTextAlignment:NSTextAlignmentCenter];
        [_leftLabel2 setTextColor:UIColorFromHex(0x8542E5)];
    }
    return _leftLabel2;
}
-(UILabel *)rightLabel1{
    if (!_rightLabel1) {
        _rightLabel1 =[[UILabel alloc]init];
        [_rightLabel1 setTextColor:UIColorFromHex(0x8542E5)];
        [_rightLabel1 setText:@"我的电量值"];
        [_rightLabel1 setTextAlignment:NSTextAlignmentCenter];
        [_rightLabel1 setFont:Demon_15_Font];
    }
    return _rightLabel1;
}
-(UILabel *)rightLabel2{
    if (!_rightLabel2) {
        _rightLabel2 =[[UILabel alloc]init];
        [_rightLabel2 setTextColor:UIColorFromHex(0x8542E5)];
        [_rightLabel2 setText:@"1510"];
        [_rightLabel2 setTextAlignment:NSTextAlignmentCenter];
        [_rightLabel2 setFont:Demon_15_Font];
    }
    return _rightLabel2;
}
-(UIButton *)leftBtn{
    if (!_leftBtn) {
        _leftBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_leftBtn setTitle:@"更多抽奖机会" forState:UIControlStateNormal];
        [_leftBtn.titleLabel setFont:Demon_15_Font];
        [_leftBtn setBackgroundColor:UIColorFromHex(0xD34E46)];
        [_leftBtn.layer setCornerRadius:5];
        [_leftBtn bk_addEventHandler:^(id sender) {
            if ([self.localDelegate respondsToSelector:@selector(getChoujiangchange)]) {
                [self.localDelegate getChoujiangchange];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftBtn;
}
-(UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn  setTitle:@"电量值兑换" forState:UIControlStateNormal];
        [_rightBtn.titleLabel setFont:Demon_15_Font];
        [_rightBtn setBackgroundColor:UIColorFromHex(0xD34E46)];
        [_rightBtn.layer setCornerRadius:5];
        [_rightBtn bk_addEventHandler:^(id sender) {
            if ([self.localDelegate respondsToSelector:@selector(duihuanEvalue)]) {
                [self.localDelegate duihuanEvalue];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightBtn;
}
-(void)setChoujiangCount:(NSString *)choujiangCount myEvalue:(NSString *)myEvalue{
    [self.leftLabel2 setText:[NSString stringWithFormat:@"%@次",choujiangCount]];
    [self.rightLabel2 setText:[NSString stringWithFormat:@"%@",myEvalue]];
}
@end
