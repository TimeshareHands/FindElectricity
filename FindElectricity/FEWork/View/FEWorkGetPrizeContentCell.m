//
//  FEWorkGetPrizeContentCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkGetPrizeContentCell.h"
@interface FEWorkGetPrizeContentCell()
@property(nonatomic, strong)UIView *whiteView;
@property(nonatomic, strong)UIView *leftView;
@property(nonatomic, strong)UIImageView *rightImageView;
@property(nonatomic, strong)UILabel *bottomLeftLabel;
@property(nonatomic, strong)UIButton *bottomRightBtn;
@end

@implementation FEWorkGetPrizeContentCell
-(id)init{
    if (self =[super init]) {
        [self addView];
        [self drawPrizeView];
    }
    return self;
}

#pragma mark -添加视图
-(void)addView{
    [self addSubview:self.whiteView];
    [self.whiteView addSubview:self.leftView];
    [self.whiteView addSubview:self.rightImageView];
    [self.whiteView addSubview:self.bottomRightBtn];
    [self.whiteView addSubview:self.bottomLeftLabel];
    [self makeUpConstraint];
}

#pragma mark -约束适配
-(void)makeUpConstraint{
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(-5);
    }];
    [self.leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(200);
        make.top.mas_equalTo(20);
        make.height.mas_equalTo(200);
    }];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(130);
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.leftView);
        make.height.mas_equalTo(160);
    }];
    [self.bottomLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.leftView.mas_bottom).offset(20);
    }];
    [self.bottomRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rightImageView);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(25);
        make.centerY.mas_equalTo(self.bottomLeftLabel);
    }];
    
}
#pragma mark -getter
-(UIView *)whiteView{
    if (!_whiteView) {
        _whiteView =[[UIView alloc]init];
        [_whiteView setBackgroundColor:[UIColor whiteColor]];
    }
    return _whiteView;
}
-(UIView *)leftView{
    if (!_leftView) {
        _leftView =[[UIView alloc]init];
    }
    return _leftView;
}
-(UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wkm_DetergentCard"]];
    }
    return _rightImageView;
}
-(UIButton *)bottomRightBtn{
    if (!_bottomRightBtn) {
        _bottomRightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomRightBtn setTitle:@"领取" forState:UIControlStateNormal];
        [_bottomRightBtn setBackgroundColor:UIColorFromHex(0xD34E46)];
        [_bottomRightBtn.titleLabel setFont:Demon_15_Font];
        [_bottomRightBtn.layer setCornerRadius:12.5];
    }
    return _bottomRightBtn;
}
-(UILabel *)bottomLeftLabel{
    if (!_bottomLeftLabel) {
        _bottomLeftLabel =[[UILabel alloc]init];
        [_bottomLeftLabel setText:@"再抽6张卫生纸卡，就可领取卫生纸1提"];
        [_bottomLeftLabel setFont:Demon_13_Font];
    }
    return _bottomLeftLabel;
}
-(void)drawPrizeView{
    for(int i =0;i<4;i++){
        for(int j =0;j<4;j++){
        UIImageView *imageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wkc_ChoujiangGet"]];
            [imageView setFrame:CGRectMake(i*50, j*55, 40, 45)];
        [self.leftView addSubview:imageView];
      }
  }
}
@end
