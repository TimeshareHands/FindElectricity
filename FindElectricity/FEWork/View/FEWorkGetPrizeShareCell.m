//
//  FEWorkGetPrizeShareCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/11.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkGetPrizeShareCell.h"
@interface FEWorkGetPrizeShareCell()
@property(nonatomic, strong)UIView *bgView;
@property(nonatomic, strong)UILabel *lb1;
@property(nonatomic, strong)UILabel *lb2;
@property(nonatomic, strong)UILabel *lb3;
@property(nonatomic, strong)UILabel *lb4;
@property(nonatomic, strong)UIButton *confirmBtn;
@end
@implementation FEWorkGetPrizeShareCell

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
    [self.bgView addSubview:self.lb4];
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
        make.top.mas_equalTo(self.lb3.mas_bottom).offset(29);
    }];
    [self.lb4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self).offset(-26);
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
        [_confirmBtn setTitle:@"推荐好友" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:UIColorFromHex(0xE26A41)];
        [_confirmBtn.titleLabel setFont:Demon_15_Font];
        WEAKSELF;
        [_confirmBtn bk_addEventHandler:^(id sender) {
            if ([weakSelf.localDelegate respondsToSelector:@selector(shareToIntroduceAction)]) {
                [weakSelf.localDelegate shareToIntroduceAction];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
- (UILabel *)lb1{
    if (!_lb1) {
        _lb1 =[[UILabel alloc]init];
        [_lb1 setText:@"邀请朋友下载APP，注册并填写邀请码"];
        [_lb1 setFont:Demon_16_Font];
    }
    return _lb1;
}
- (UILabel *)lb2{
    if (!_lb2) {
        _lb2 =[[UILabel alloc]init];
        [_lb2 setText:@"邀请成功，可获得10次抽奖机会"];
        [_lb2 setFont:Demon_16_Font];
    }
    return _lb2;
}
- (UILabel *)lb3{
    if (!_lb3) {
        _lb3 =[[UILabel alloc]init];
        NSString *invcode =[NSString stringWithFormat:@"%@",[FEUserOperation manager].userModel.invCode];
        [_lb3 setAttributedText:[self setupAttributeString:[NSString stringWithFormat:@"我的邀请码：%@(点击复制)",invcode.length>0?invcode:@""] highlightText:invcode]];
        [_lb3 setFont:Demon_16_Font];
        [_lb3 setUserInteractionEnabled:YES];
        [_lb3 bk_whenTapped:^{
            [self copyClick];
        }];
    }
    return _lb3;
}
#pragma mark - 富文本部分字体飘灰
- (NSMutableAttributedString *)setupAttributeString:(NSString *)text highlightText:(NSString *)highlightText {
    NSRange hightlightTextRange = [text rangeOfString:highlightText];
    NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc] initWithString:text];
    [attributeStr addAttribute:NSForegroundColorAttributeName
                             value:UIColorFromHex(0xE26A41)
                             range:hightlightTextRange];
    [attributeStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:13.0f] range:hightlightTextRange];
    return attributeStr;
}
- (UILabel *)lb4{
    if (!_lb4) {
        _lb4 =[[UILabel alloc]init];
        [_lb4 setText:@"请赠送抽奖规则"];
        [_lb4 setFont:Demon_12_Font];
        [_lb4 setUserInteractionEnabled:YES];
        [_lb4 setTextColor:UIColorFromHex(0xE26A41)];
        WEAKSELF;
        [_lb4 bk_whenTapped:^{
            if ([weakSelf.localDelegate respondsToSelector:@selector(readStandard)]) {
                [weakSelf.localDelegate readStandard];
            }
        }];
    }
    return _lb4;
}

- (void)copyClick {
    UIPasteboard *pab = [UIPasteboard generalPasteboard];
    pab.string = self.lb3.text;
    MTSVPShowInfoText(@"复制成功");
}
@end
