//
//  FEWorkGetGiftDetailStatusCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkGetGiftDetailStatusCell.h"

@interface FEWorkGetGiftDetailStatusCell()
@property(nonatomic, strong) UILabel *leftLabel1;
@property(nonatomic, strong) UILabel *leftLabel2;
@property(nonatomic, strong) UILabel *leftLabel3;
@property(nonatomic, strong) UILabel *leftLabel4;
@property(nonatomic, strong) UILabel *leftLabel5;
@property(nonatomic, strong) UILabel *rightLabel;
@property(nonatomic, strong) UIButton *rightTopBtn;
@property(nonatomic, strong) UIView *whiteView;
@end

@implementation FEWorkGetGiftDetailStatusCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

#pragma mark 添加视图
-(void)addView{
    [self addSubview:self.whiteView];
    [self.whiteView addSubview:self.leftLabel1];
    [self.whiteView addSubview:self.leftLabel2];
    [self.whiteView addSubview:self.leftLabel3];
    [self.whiteView addSubview:self.leftLabel4];
    [self.whiteView addSubview:self.leftLabel5];
    [self.whiteView addSubview:self.rightLabel];
    [self.whiteView addSubview:self.rightTopBtn];
    [self makeUpconstriant];
}
#pragma mark -约束适配
-(void)makeUpconstriant{
      [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
          make.left.mas_equalTo(self.contentView).offset(10);
          make.right.mas_equalTo(self.contentView).offset(-10);
          make.top.mas_equalTo(self);
          make.bottom.mas_equalTo(self);
      }];
      [self.leftLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(10);
           make.top.mas_equalTo(20);
       }];
       [self.leftLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(10);
           make.top.mas_equalTo(self.leftLabel1.mas_bottom).offset(15);
       }];
       [self.leftLabel3 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(10);
           make.top.mas_equalTo(self.leftLabel2.mas_bottom).offset(15);
       }];
       [self.leftLabel4 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.leftLabel3.mas_right).offset(10);
           make.top.mas_equalTo(self.leftLabel2.mas_bottom).offset(15);
       }];
       [self.leftLabel5 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(10);
           make.top.mas_equalTo(self.leftLabel4.mas_bottom).offset(15);
       }];
       [self.rightTopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.mas_equalTo(-10);
           make.top.mas_equalTo(14);
           make.width.mas_equalTo(90);
           make.height.mas_equalTo(28);
       }];
       [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.mas_equalTo(-10);
           make.centerY.mas_equalTo(self.leftLabel5);
       }];
}

#pragma mark -getter
-(UIView *)whiteView{
    if (!_whiteView) {
        _whiteView =[[UIView alloc]init];
        [_whiteView setBackgroundColor:[UIColor whiteColor]];
        [_whiteView.layer setCornerRadius:5];
    }
    return _whiteView;
}
-(UILabel *)leftLabel1{
    if (!_leftLabel1) {
        _leftLabel1 =[[UILabel alloc]init];
        [_leftLabel1 setText:@"收货地址"];
        [_leftLabel1 setFont:Demon_15_Font];
    }
    return _leftLabel1;
}
-(UILabel *)leftLabel2{
    if (!_leftLabel2) {
        _leftLabel2 =[[UILabel alloc]init];
        [_leftLabel2 setText:@"湖南省长沙市岳麓区钰龙天下"];
        [_leftLabel2 setFont:Demon_15_Font];
    }
    return _leftLabel2;
}
-(UILabel *)leftLabel3{
    if (!_leftLabel3) {
        _leftLabel3 =[[UILabel alloc]init];
        [_leftLabel3 setText:@"吴先生"];
        [_leftLabel3 setFont:Demon_15_Font];
    }
    return _leftLabel3;
}
-(UILabel *)leftLabel4{
    if (!_leftLabel4) {
        _leftLabel4 =[[UILabel alloc]init];
        [_leftLabel4 setText:@"18778888321"];
        [_leftLabel4 setFont:Demon_15_Font];
    }
    return _leftLabel4;
}
-(UILabel *)leftLabel5{
    if (!_leftLabel5) {
        _leftLabel5 =[[UILabel alloc]init];
        [_leftLabel5 setText:@"快递单号：807076195899642696"];
        [_leftLabel5 setFont:Demon_13_Font];
        [_leftLabel5 setTextColor:UIColorFromHex(0xC9C9C9)];
    }
    return _leftLabel5;
}
-(UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel =[[UILabel alloc]init];
        [_rightLabel setText:@"中通快递"];
        [_rightLabel setTextColor:UIColorFromHex(0xC9C9C9)];
        [_rightLabel setFont:Demon_13_Font];
    }
    return _rightLabel;
}
-(UIButton *)rightTopBtn{
    if (!_rightTopBtn) {
        _rightTopBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightTopBtn setTitle:@"修改发货地址" forState:UIControlStateNormal];
        [_rightTopBtn.layer setBorderWidth:1];
        [_rightTopBtn.layer setBorderColor:UIColorFromHex(0x5ED31D).CGColor];
        [_rightTopBtn setTitleColor:UIColorFromHex(0x5ED31D) forState:UIControlStateNormal];
        [_rightTopBtn.titleLabel setFont:Demon_12_Font];
    }
    return _rightTopBtn;
}
@end
