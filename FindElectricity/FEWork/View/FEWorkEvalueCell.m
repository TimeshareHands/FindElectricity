//
//  FEWorkEvalueCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/3.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkEvalueCell.h"
@interface FEWorkEvalueCell()
@property (nonatomic, strong) UILabel *leftTopLbl;
@property (nonatomic, strong) UILabel *leftBottomLbl;
@property (nonatomic, strong) UILabel *rightTopLbl;
@property (nonatomic, strong) UILabel *rightBottomLbl;
@end

@implementation FEWorkEvalueCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

#pragma mark 添加视图
- (void)addView{
    [self addSubview:self.leftTopLbl];
    [self addSubview:self.leftBottomLbl];
    [self addSubview:self.rightTopLbl];
    [self addSubview:self.rightBottomLbl];
    [self makeUpconstriant];
}

#pragma mark 约束适配
- (void)makeUpconstriant{
    [self.leftTopLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(20);
        make.top.mas_equalTo(15);
    }];
    [self.leftBottomLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftTopLbl);
        make.top.mas_equalTo(self.leftTopLbl.mas_bottom).offset(11);
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
-(void)setleftTopText:(NSString *)leftTopText leftBottomText:(NSString *)leftBottomText rightTopText:(NSString *)rightTopText rightBottomText:(NSString *)rightBottomText{
    [self.leftTopLbl setText:leftTopText];
    [self.leftBottomLbl setText:leftBottomText];
    [self.rightTopLbl setText:rightTopText];
    [self.rightBottomLbl setText:rightBottomText];
}
#pragma mark getter
-(UILabel *)leftTopLbl{
    if (!_leftTopLbl) {
        _leftTopLbl =[[UILabel alloc]init];
        [_leftTopLbl setText:@"邀请好友"];
        [_leftTopLbl setFont:Demon_18_Font];
    }
    return _leftTopLbl;
}
-(UILabel *)leftBottomLbl{
    if (!_leftBottomLbl) {
        _leftBottomLbl =[[UILabel alloc]init];
        [_leftBottomLbl setText:@"成功邀请1位好友"];
        [_leftBottomLbl setFont:Demon_15_Font];
        [_leftBottomLbl setTextColor:UIColorFromHex(0xAEAEAE)];
    }
    return _leftBottomLbl;
}
-(UILabel *)rightTopLbl{
    if (!_rightTopLbl) {
        _rightTopLbl =[[UILabel alloc]init];
        [_rightTopLbl setText:@"+10"];
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
@end
