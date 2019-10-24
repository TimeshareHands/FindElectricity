//
//  FESmsCodeCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/8.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FESmsCodeCell.h"
#import "UIButton+Extend.h"
@interface FESmsCodeCell()

@end
@implementation FESmsCodeCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

#pragma  mark -添加视图
- (void)addView{
    [self addSubview:self.inputTextField];
    [self addSubview:self.lineView];
    [self addSubview:self.smsBtn];
    [self makeUpconstriant];
}

#pragma  mark -约束适配
- (void)makeUpconstriant{
    [self.inputTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(33);
        make.centerY.mas_equalTo(self);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(0.5);
    }];
    [self.smsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.lineView);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self);
    }];
}

#pragma mark -getter

- (UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField =[[UITextField alloc]init];
        [_inputTextField setPlaceholder:@"请输入验证码"];
        [_inputTextField setFont:Demon_15_Font];
    }
    return _inputTextField;
}

- (UIView *)lineView{
    if (!_lineView) {
        _lineView =[[UIView alloc]init];
        [_lineView setBackgroundColor:UIColorFromHex(0xC8C8C8)];
    }
    return _lineView;
}
- (UIButton *)smsBtn{
    if (!_smsBtn) {
        _smsBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_smsBtn setTitle:@"发送验证码" forState:UIControlStateNormal];
        [_smsBtn setBackgroundColor:UIColorFromHex(0xC9C9C9)];
        [_smsBtn.titleLabel setFont:Demon_15_Font];
        [_smsBtn.layer setCornerRadius:5];
    }
    return _smsBtn;
}
@end
