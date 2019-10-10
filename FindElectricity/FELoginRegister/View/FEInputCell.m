//
//  FEInputCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/8.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEInputCell.h"
@interface FEInputCell()
@property(nonatomic, strong)UITextField *inputTextField;
@property(nonatomic, strong)UIView *lineView;
@end

@implementation FEInputCell

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
}

#pragma mark -getter

- (UITextField *)inputTextField{
    if (!_inputTextField) {
        _inputTextField =[[UITextField alloc]init];
        [_inputTextField setFont:Demon_15_Font];
        [_inputTextField setPlaceholder:@"请输入账号"];
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
@end
