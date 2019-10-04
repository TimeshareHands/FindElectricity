//
//  FEWorkGiftCardCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/4.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkGiftCardCell.h"
@interface FEWorkGiftCardCell()
@property(nonatomic, strong)UIImageView *leftImg;
@property(nonatomic, strong)UILabel *topLbl;
@property(nonatomic, strong)UILabel *bottomLbl;
@property(nonatomic, strong)UIButton *rightBtn;

@end

@implementation FEWorkGiftCardCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

#pragma mark 添加视图
- (void)addView{
    [self addSubview:self.leftImg];
    [self addSubview:self.topLbl];
    [self addSubview:self.bottomLbl];
    [self addSubview:self.rightBtn];
    [self makeUpConstraint];
}

#pragma mark 约束适配
- (void)makeUpConstraint{
    [self.leftImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(34);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(48);
        make.height.mas_equalTo(52);
    }];
    [self.topLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImg.mas_right).offset(18);
        make.top.mas_equalTo(21);
    }];
    [self.bottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLbl.mas_bottom).offset(10);
        make.left.mas_equalTo(self.topLbl);
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-20);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(70);
        make.height.mas_equalTo(30);
    }];
}

#pragma mark getter
- (UIImageView *)leftImg{
    if (!_leftImg) {
        _leftImg =[[UIImageView alloc]init];
        [_leftImg setImage:[UIImage imageNamed:@"wkm_tolietPaperCard"]];
    }
    return _leftImg;
}
- (UILabel *)topLbl{
    if (!_topLbl) {
        _topLbl =[[UILabel alloc]init];
        [_topLbl setText:@"卫生纸卡1张"];
        [_topLbl setFont:Demon_15_Font];
    }
    return _topLbl;
}
- (UILabel *)bottomLbl{
    if (!_bottomLbl) {
        _bottomLbl =[[UILabel alloc]init];
        [_bottomLbl setText:@"5000电量值"];
        [_bottomLbl setFont:Demon_15_Font];
        [_bottomLbl setTextColor:UIColorFromHex(0x4ec324)];
    }
    return _bottomLbl;
}
- (UIButton *)rightBtn{
    if (!_rightBtn) {
        _rightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_rightBtn setTitle:@"兑换" forState:UIControlStateNormal];
        [_rightBtn.titleLabel setFont:Demon_14_Font];
        [_rightBtn setBackgroundColor:UIColorFromHex(0x4ec324)];
        [_rightBtn.layer setCornerRadius:15];
    }
    return _rightBtn;
}
@end
