//
//  FEWorkGetPrizeShareWxCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/12.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkGetPrizeShareWxCell.h"
@interface FEWorkGetPrizeShareWxCell()
@property(nonatomic, strong)UIView *bgView;
@property(nonatomic, strong)UILabel *lb1;
@property(nonatomic, strong)UILabel *lb2;
@property(nonatomic, strong)UILabel *lb3;
@property(nonatomic, strong)UIImageView *qrImage;
@property(nonatomic, strong)UIButton *confirmBtn;
@end
@implementation FEWorkGetPrizeShareWxCell
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

#pragma mark -添加视图
- (void)addView{
    self.backgroundColor =UIColorFromHex(0xf3875d);
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.confirmBtn];
    [self.bgView addSubview:self.lb1];
    [self.bgView addSubview:self.lb2];
    [self.bgView addSubview:self.lb3];
    [self.bgView addSubview:self.qrImage];
    [self makeUpConstriant];
}

#pragma mark -约束适配
- (void)makeUpConstriant{
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.bottom.mas_equalTo(-10);
    }];
    [self.lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(40);
    }];
    [self.lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.lb1.mas_bottom).offset(16);
    }];
    [self.lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.lb2.mas_bottom).offset(16);
    }];
    [self.qrImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(self.lb3.mas_bottom).offset(19);
        make.width.mas_equalTo(80);
        make.height.mas_equalTo(80);
    }];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(36);
        make.top.mas_equalTo(self.qrImage.mas_bottom).offset(15);
    }];
   
}

#pragma mark -getter
- (UIView *)bgView{
    if (!_bgView) {
        _bgView =[[UIView alloc]init];
        [_bgView setBackgroundColor:[UIColor whiteColor]];
    }
    return _bgView;
}
- (UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"点这里生成分享图" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:UIColorFromHex(0xE26A41)];
        [_confirmBtn.titleLabel setFont:Demon_15_Font];
    }
    return _confirmBtn;
}
- (UILabel *)lb1{
    if (!_lb1) {
        _lb1 =[[UILabel alloc]init];
        [_lb1 setText:@"邀请好友用微信扫二维码"];
        [_lb1 setFont:Demon_16_Font];
    }
    return _lb1;
}
- (UILabel *)lb2{
    if (!_lb2) {
        _lb2 =[[UILabel alloc]init];
        [_lb2 setText:@"好友安装找电APP，并使用邀请码注册"];
        [_lb2 setFont:Demon_16_Font];
    }
    return _lb2;
}
- (UILabel *)lb3{
    if (!_lb3) {
        _lb3 =[[UILabel alloc]init];
        [_lb3 setText:@"即为邀请成功，马上获得10次抽奖机会"];
        [_lb3 setFont:Demon_16_Font];
    }
    return _lb3;
}
- (UIImageView *)qrImage{
    if (!_qrImage) {
        _qrImage =[[UIImageView alloc]init];
        [_qrImage setImage:[UIImage imageNamed:@"wkc_FEQR"]];
    }
    return _qrImage;
}
@end
