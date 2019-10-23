//
//  FEWorkEValueDetailHeadView.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/3.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkEValueDetailHeadView.h"

@interface FEWorkEValueDetailHeadView()

@property(nonatomic, strong)UIImageView *bgImg;
@property(nonatomic, strong)UILabel *topLeftLbl;
@property(nonatomic, strong)UILabel *leftBottomLbl;
@property(nonatomic, strong)UILabel *bottomLbl;
@property(nonatomic, strong)UIButton *onceBtn;

@end

@implementation FEWorkEValueDetailHeadView

-(id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}

#pragma  mark 添加视图
-(void)addView{
    [self addSubview:self.bgImg];
    [self.bgImg addSubview:self.topLeftLbl];
    [self.bgImg addSubview:self.leftBottomLbl];
    [self.bgImg addSubview:self.bottomLbl];
    [self.bgImg addSubview:self.onceBtn];
    [self makeUpConstraint];
}

#pragma  mark 约束适配
-(void)makeUpConstraint{
    [self.bgImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(120);
        make.top.mas_equalTo(10);
    }];
    [self.topLeftLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(15);
    }];
    [self.leftBottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLeftLbl.mas_bottom).offset(7);
        make.left.mas_equalTo(10);
    }];
    [self.bottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.bgImg.mas_bottom).offset(-14);
        make.left.mas_equalTo(10);
    }];
    [self.onceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.leftBottomLbl);
        make.right.mas_equalTo(self.bgImg.mas_right).offset(-10);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(30);
    }];
}
-(void)setlotterNum:(NSString *)lotterNum  myEvalue:(NSString *)myEvalue{
     [_leftBottomLbl setText:myEvalue];
      [_bottomLbl setText:[NSString stringWithFormat:@"可换取%@次抽奖机会",lotterNum]];
}
#pragma  mark getter
-(UIImageView *)bgImg{
    if (!_bgImg) {
        _bgImg =[[UIImageView alloc]init];
        [_bgImg setImage:[UIImage imageNamed:@"wkm_electricityValue"]];
    }
    return _bgImg;
}

-(UILabel *)topLeftLbl{
    if (!_topLeftLbl) {
        _topLeftLbl =[[UILabel alloc]init];
        [_topLeftLbl setFont:Demon_13_Font];
        [_topLeftLbl setText:@"我的电量值"];
    }
    return _topLeftLbl;
}
-(UILabel *)leftBottomLbl{
    if (!_leftBottomLbl) {
        _leftBottomLbl =[[UILabel alloc]init];
        [_leftBottomLbl setFont:Demon_28_MediumFont];
       
    }
    return _leftBottomLbl;
}
-(UILabel *)bottomLbl{
    if (!_bottomLbl) {
        _bottomLbl =[[UILabel alloc]init];
        [_bottomLbl setFont:Demon_13_Font];
      
    }
    return _bottomLbl;
}
-(UIButton *)onceBtn{
    if (!_onceBtn) {
        _onceBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_onceBtn setTitle:@"立即兑换" forState:UIControlStateNormal];
        [_onceBtn.titleLabel setFont:Demon_14_Font];
        [_onceBtn.layer setCornerRadius:5];
        [_onceBtn setBackgroundColor:[UIColor whiteColor]];
        [_onceBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        WEAKSELF;
        [_onceBtn bk_addEventHandler:^(id sender) {
            if ([weakSelf.localDelegate respondsToSelector:@selector(goDuiFUAction)]) {
                [weakSelf.localDelegate goDuiFUAction];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _onceBtn;
}
@end
