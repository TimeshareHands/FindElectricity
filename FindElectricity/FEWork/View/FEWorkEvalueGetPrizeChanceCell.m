//
//  FEWorkEvalueGetPrizeChanceCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/3.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkEvalueGetPrizeChanceCell.h"

@interface FEWorkEvalueGetPrizeChanceCell()
@property(nonatomic, strong)UILabel *leftTopLbl;
@property(nonatomic, strong)UILabel *rightTopLbl;
@property(nonatomic, strong)UIImageView *tapView1;
@property(nonatomic, strong)UILabel *tapTopLbl1;
@property(nonatomic, strong)UILabel *tapBottomLbl1;
@property(nonatomic, strong)UIImageView *tapView2;
@property(nonatomic, strong)UILabel *tapTopLbl2;
@property(nonatomic, strong)UILabel *tapBottomLbl2;
@property(nonatomic, strong)UIImageView *tapView3;
@property(nonatomic, strong)UILabel *tapTopLbl3;
@property(nonatomic, strong)UILabel *tapBottomLbl3;
@property(nonatomic, strong)UIImageView *tapView4;
@property(nonatomic, strong)UILabel *tapTopLbl4;
@property(nonatomic, strong)UILabel *tapBottomLbl4;
@property(nonatomic, strong)UIButton *confirmBtn;
@property(nonatomic, strong)UILabel *bottomLbl;
@end

@implementation FEWorkEvalueGetPrizeChanceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

#pragma mark 添加视图
- (void)addView{
    [self addSubview:self.leftTopLbl];
    [self addSubview:self.rightTopLbl];
    [self addSubview:self.tapView1];
    [self addSubview:self.tapView2];
    [self addSubview:self.tapView3];
    [self addSubview:self.tapView4];
    [self.tapView1 addSubview:self.tapTopLbl1];
    [self.tapView1 addSubview:self.tapBottomLbl1];
    [self.tapView2 addSubview:self.tapTopLbl2];
    [self.tapView2 addSubview:self.tapBottomLbl2];
    [self.tapView3 addSubview:self.tapTopLbl3];
    [self.tapView3 addSubview:self.tapBottomLbl3];
    [self.tapView4 addSubview:self.tapTopLbl4];
    [self.tapView4 addSubview:self.tapBottomLbl4];
    [self addSubview:self.confirmBtn];
    [self addSubview:self.bottomLbl];
    [self makeUpConstraint];
}

#pragma mark 约束适配
- (void)makeUpConstraint{
    [self.leftTopLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(20);
    }];
    [self.rightTopLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(20);
    }];
    [self.tapView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.leftTopLbl.mas_bottom).offset(20);
        make.height.mas_equalTo(70);
        make.right.mas_equalTo(self.mas_centerX).offset(-11);
    }];
    [self.tapView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_centerX).offset(11);
        make.top.mas_equalTo(self.tapView1);
        make.right.mas_equalTo(self).offset(-20);
        make.height.mas_equalTo(70);
    }];
    [self.tapView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.tapView1.mas_bottom).offset(20);
        make.height.mas_equalTo(70);
        make.right.mas_equalTo(self.mas_centerX).offset(-11);
    }];
    [self.tapView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.mas_centerX).offset(11);
        make.top.mas_equalTo(self.tapView3);
        make.right.mas_equalTo(self).offset(-20);
        make.height.mas_equalTo(70);
    }];
    [self.tapTopLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.tapView1);
        make.top.mas_equalTo(16);
    }];
    [self.tapBottomLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tapTopLbl1.mas_bottom).offset(9);
        make.centerX.mas_equalTo(self.tapView1);
    }];
    [self.tapTopLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.mas_equalTo(self.tapView2);
           make.top.mas_equalTo(16);
    }];
   [self.tapBottomLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.tapTopLbl2.mas_bottom).offset(9);
       make.centerX.mas_equalTo(self.tapView2);
   }];
    [self.tapTopLbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.mas_equalTo(self.tapView3);
           make.top.mas_equalTo(16);
       }];
   [self.tapBottomLbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.tapTopLbl3.mas_bottom).offset(9);
       make.centerX.mas_equalTo(self.tapView3);
   }];
    [self.tapTopLbl4 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.mas_equalTo(self.tapView4);
           make.top.mas_equalTo(16);
       }];
   [self.tapBottomLbl4 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(self.tapTopLbl4.mas_bottom).offset(9);
       make.centerX.mas_equalTo(self.tapView4);
   }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(42);
        make.top.mas_equalTo(self.tapView3.mas_bottom).offset(17);
    }];
    [self.bottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.confirmBtn.mas_bottom).offset(17);
    }];
}

#pragma mark getter
- (UILabel *)leftTopLbl{
    if (!_leftTopLbl) {
        _leftTopLbl =[[UILabel alloc]init];
        [_leftTopLbl setText:@"兑换抽奖机会"];
        [_leftTopLbl setFont:Demon_15_Font];
    }
    return _leftTopLbl;
}

- (UILabel *)rightTopLbl{
    if (!_rightTopLbl) {
        _rightTopLbl =[[UILabel alloc]init];
        [_rightTopLbl setText:@"每500电量值可兑换一次抽奖机会"];
        [_rightTopLbl setFont:Demon_12_Font];
    }
    return _rightTopLbl;
}
- (UIImageView *)tapView1{
    if (!_tapView1) {
        _tapView1 =[[UIImageView alloc]init];
        [_tapView1 setImage:[UIImage imageNamed:@"wkm_unselected"]];
    }
    return _tapView1;
}
- (UILabel *)tapTopLbl1{
    if (!_tapTopLbl1) {
        _tapTopLbl1 =[[UILabel alloc]init];
        [_tapTopLbl1 setText:@"1次"];
        [_tapTopLbl1 setFont:Demon_16_Font];
    }
    return _tapTopLbl1;
}
- (UILabel *)tapBottomLbl1{
    if (!_tapBottomLbl1) {
        _tapBottomLbl1 =[[UILabel alloc]init];
        [_tapBottomLbl1 setText:@"消耗500电量值"];
        [_tapBottomLbl1 setFont:Demon_13_Font];
    }
    return _tapBottomLbl1;
}
- (UIImageView *)tapView2{
    if (!_tapView2) {
        _tapView2 =[[UIImageView alloc]init];
         [_tapView2 setImage:[UIImage imageNamed:@"wkm_rect"]];
    }
    return _tapView2;
}
- (UILabel *)tapTopLbl2{
    if (!_tapTopLbl2) {
        _tapTopLbl2 =[[UILabel alloc]init];
        [_tapTopLbl2 setText:@"5次"];
         [_tapTopLbl2 setFont:Demon_16_Font];
    }
    return _tapTopLbl2;
}
- (UILabel *)tapBottomLbl2{
    if (!_tapBottomLbl2) {
        _tapBottomLbl2 =[[UILabel alloc]init];
        [_tapBottomLbl2 setFont:Demon_13_Font];
        [_tapBottomLbl2 setText:@"消耗2500电量值"];
    }
    return _tapBottomLbl2;
}
- (UIImageView *)tapView3{
    if (!_tapView3) {
        _tapView3 =[[UIImageView alloc]init];
        [_tapView3 setImage:[UIImage imageNamed:@"wkm_rect"]];
    }
    return _tapView3;
}
- (UILabel *)tapTopLbl3{
    if (!_tapTopLbl3) {
        _tapTopLbl3 =[[UILabel alloc]init];
        [_tapTopLbl3 setText:@"10次"];
        [_tapTopLbl3 setFont:Demon_16_Font];
    }
    return _tapTopLbl3;
}
- (UILabel *)tapBottomLbl3{
    if (!_tapBottomLbl3) {
        _tapBottomLbl3 =[[UILabel alloc]init];
        [_tapBottomLbl3 setText:@"消耗4500电量值"];
        [_tapBottomLbl3 setFont:Demon_13_Font];
    }
    return _tapBottomLbl3;
}
- (UIImageView *)tapView4{
    if (!_tapView4) {
        _tapView4 =[[UIImageView alloc]init];
         [_tapView4 setImage:[UIImage imageNamed:@"wkm_rect"]];
    }
    return _tapView4;
}
- (UILabel *)tapTopLbl4{
    if (!_tapTopLbl4) {
        _tapTopLbl4 =[[UILabel alloc]init];
        [_tapTopLbl4 setFont:Demon_16_Font];
        [_tapTopLbl4 setText:@"100次"];
    }
    return _tapTopLbl4;
}
- (UILabel *)tapBottomLbl4{
    if (!_tapBottomLbl4) {
        _tapBottomLbl4 =[[UILabel alloc]init];
        [_tapBottomLbl4 setText:@"消耗40000电量值"];
        [_tapBottomLbl4 setFont:Demon_13_Font];
    }
    return _tapBottomLbl4;
}
- (UILabel *)bottomLbl{
    if (!_bottomLbl) {
        _bottomLbl =[[UILabel alloc]init];
        [_bottomLbl setFont:Demon_13_Font];
        [_bottomLbl setText:@"*本活动最终解释权归本公司所有"];
        [_bottomLbl setTextColor:UIColorFromHex(0x67D35F)];
    }
    return _bottomLbl;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"兑换" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:UIColorFromHex(0x4EC324)];
        [_confirmBtn.layer setCornerRadius:21];
        [_confirmBtn.titleLabel setFont:Demon_16_Font];
    }
    return _confirmBtn;
}
@end
