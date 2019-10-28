//
//  FETWorkMainTableViewCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/2.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FETWorkMainTableViewCell.h"

@interface FETWorkMainTableViewCell ()
@property (nonatomic, strong)UIImageView *leftImg;
@property (nonatomic, strong)UILabel *topLabel;
@property (nonatomic, strong)UILabel *topCenterLabel;
@property (nonatomic, strong)UILabel *bottomLabel;
@property (nonatomic, strong)UILabel *centerLabel;
@property (nonatomic, strong)UIButton *confirmBtn;
@end

@implementation FETWorkMainTableViewCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

#pragma mark --添加视图
-(void)addView{
    [self addSubview:self.leftImg];
    [self addSubview:self.topLabel];
    [self addSubview:self.centerLabel];
    [self addSubview:self.topCenterLabel];
    [self addSubview:self.bottomLabel];
    [self addSubview:self.confirmBtn];
    [self makeUpconstraint];
}
#pragma mark --约束适配
-(void)makeUpconstraint{
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.centerY.mas_equalTo(self);
    }];
    [self.topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImg.mas_right).offset(10);
        make.bottom.mas_equalTo(self.centerLabel.mas_top).offset(-2);
    }];
    [self.topCenterLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topLabel.mas_right).offset(5);
        make.top.mas_equalTo(self.topLabel.mas_top).offset(3);
    }];
    [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self.topLabel);
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.topLabel);
        make.top.mas_equalTo(self.centerLabel.mas_bottom);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(-20);
        make.width.mas_equalTo(68);
        make.height.mas_equalTo(28);
    }];
}
-(void)setLeftImg:(NSString *)imageLogo topText:(NSString *)topText topCenterText:(NSString *)tpcenterText centerText:(NSString *)centerText bottomText:(NSString *)bottomText buttonColor:(UIColor *)color buttonTitle:(NSString *)buttonTitle{
    [self.leftImg setImage:[UIImage imageNamed:imageLogo]];
    [self.topLabel setText:topText];
    [self.topCenterLabel setText:tpcenterText];
    [self.centerLabel setText:centerText];
    [self.bottomLabel setText:bottomText];
    [self.confirmBtn setBackgroundColor:color];
    [self.confirmBtn setTitle:buttonTitle forState:UIControlStateNormal];
}
#pragma mark --getter
-(UIImageView *)leftImg{
    if (!_leftImg) {
        _leftImg =[[UIImageView alloc]init];
        [_leftImg setImage:[UIImage imageNamed:@"wkm_addMember"]];
    }
    return _leftImg;
}
-(UILabel *)topLabel{
    if (!_topLabel) {
        _topLabel =[[UILabel alloc]init];
        [_topLabel setText:@"邀请好友"];
        [_topLabel setFont:Demon_15_Font];
    }
    return _topLabel;
}
-(UILabel *)topCenterLabel{
    if (!_topCenterLabel) {
        _topCenterLabel =[[UILabel alloc]init];
        [_topCenterLabel setFont:Demon_12_Font];
        [_topCenterLabel setText:@"+10次抽奖"];
    }
    return _topCenterLabel;
}
-(UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel =[[UILabel alloc]init];
        [_bottomLabel setFont:Demon_12_Font];
        [_bottomLabel setText:@"获得抽奖机会"];
    }
    return _bottomLabel;
}
-(UILabel *)centerLabel{
    if (!_centerLabel) {
        _centerLabel =[[UILabel alloc]init];
        [_centerLabel setText:@"邀请好友下载注册找电"];
        [_centerLabel setFont:Demon_12_Font];
    }
    return _centerLabel;
}
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"去邀请" forState:UIControlStateNormal];
        [_confirmBtn.titleLabel setFont:Demon_13_Font];
        [_confirmBtn.layer setCornerRadius:14];
        WEAKSELF;
        [_confirmBtn bk_addEventHandler:^(id sender) {
            weakSelf.didClick();
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
@end
