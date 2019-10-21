//
//  FEWorkGetGiftCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/3.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkGetGiftCell.h"
@interface FEWorkGetGiftCell()
@property (nonatomic, strong) UILabel *leftCenterLbl;
@property (nonatomic, strong) UILabel *rightTopLbl;
@property (nonatomic, strong) UILabel *rightBottomLbl;
@end

@implementation FEWorkGetGiftCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

#pragma mark 添加视图
- (void)addView{
    [self addSubview:self.leftCenterLbl];
    [self addSubview:self.rightTopLbl];
    [self addSubview:self.rightBottomLbl];
    [self makeUpconstriant];
}

#pragma mark 约束适配
- (void)makeUpconstriant{
    [self.leftCenterLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.centerY.mas_equalTo(self);
    }];
   
    [self.rightTopLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(-20);
        make.top.mas_equalTo(15);
    }];
    [self.rightBottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.rightTopLbl.mas_bottom).offset(11);
        make.right.mas_equalTo(self.rightTopLbl);
    }];
}

#pragma mark getter
-(UILabel *)leftCenterLbl{
    if (!_leftCenterLbl) {
        _leftCenterLbl =[[UILabel alloc]init];
        [_leftCenterLbl setText:@"兑换卫生纸卡1张"];
        [_leftCenterLbl setFont:Demon_16_Font];
    }
    return _leftCenterLbl;
}

-(UILabel *)rightTopLbl{
    if (!_rightTopLbl) {
        _rightTopLbl =[[UILabel alloc]init];
        [_rightTopLbl setText:@"-5000"];
        [_rightTopLbl setFont:Demon_18_Font];
        [_rightTopLbl setTextColor:UIColorFromHex(0xE26A41)];
    }
    return _rightTopLbl;
}
-(UILabel *)rightBottomLbl{
    if (!_rightBottomLbl) {
        _rightBottomLbl =[[UILabel alloc]init];
        [_rightBottomLbl setText:@"2019-06-20  15:19"];
        [_rightBottomLbl setFont:Demon_15_Font];
        [_rightBottomLbl setTextColor:UIColorFromHex(0xAEAEAE)];
      
    }
    return _rightBottomLbl;
}
-(void)setCount:(NSString *)count rightTopText:(NSString *)rightTopText rightBottomText:(NSString *)rightBottomText{
    [self.leftCenterLbl setText:[NSString stringWithFormat:@"兑换抽象次数%@",count]];
    [self.rightTopLbl setText:[NSString stringWithFormat:@"+%@",rightTopText]];
    [self.rightBottomLbl setText:[NSString stringWithFormat:@"%@",rightBottomText]];
}
@end
