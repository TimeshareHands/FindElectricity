//
//  FEWorkGetPrizeShareAccordCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/12.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkGetPrizeShareAccordCell.h"
@interface FEWorkGetPrizeShareAccordCell()
@property(nonatomic, strong)UIView *bgView;
@property(nonatomic, strong)UILabel *lb1;

@property(nonatomic, strong)UIButton *confirmBtn;
@end

@implementation FEWorkGetPrizeShareAccordCell

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
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.width.mas_equalTo(160);
        make.height.mas_equalTo(36);
        make.bottom.mas_equalTo(self.mas_bottom).offset(-15);
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
        [_confirmBtn setTitle:@"点击查看" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:UIColorFromHex(0xE26A41)];
        [_confirmBtn.titleLabel setFont:Demon_15_Font];
        WEAKSELF
        [_confirmBtn bk_addEventHandler:^(id sender) {
            if ([weakSelf.localDelegate respondsToSelector:@selector(findRecord)]) {
                [weakSelf.localDelegate findRecord];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
- (UILabel *)lb1{
    if (!_lb1) {
        _lb1 =[[UILabel alloc]init];
        [_lb1 setText:@"邀请好友记录"];
        [_lb1 setFont:Demon_16_Font];
    }
    return _lb1;
}
- (UILabel *)lb2{
    if (!_lb2) {
        _lb2 =[[UILabel alloc]init];
        [_lb2 setText:@"分享给微信好友2次，赠送2次抽奖机会"];
        [_lb2 setFont:Demon_16_Font];
    }
    return _lb2;
}
- (UILabel *)lb3{
    if (!_lb3) {
        _lb3 =[[UILabel alloc]init];
        [_lb3 setText:@"邀请好友下载登录0个，赠送0次抽奖机会"];
        [_lb3 setFont:Demon_16_Font];
    }
    return _lb3;
}

@end
