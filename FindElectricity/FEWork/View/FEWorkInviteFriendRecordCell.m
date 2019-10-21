//
//  FEWorkInviteFriendRecordCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkInviteFriendRecordCell.h"
@interface FEWorkInviteFriendRecordCell()
@property(nonatomic ,strong)UIImageView *leftImageView;
@property(nonatomic ,strong)UILabel *leftLabel;
@property(nonatomic ,strong)UILabel *topRightLabel;
@property(nonatomic ,strong)UILabel *bottomRightLabel1;
@property(nonatomic ,strong)UILabel *bottomRightLabel2;
@property(nonatomic ,strong)UIView *lineView;
@end

@implementation FEWorkInviteFriendRecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self =[super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self addView];
    }
    return self;
}

#pragma mark 添加视图
-(void)addView{
    [self addSubview:self.leftImageView];
    [self addSubview:self.leftLabel];
    [self addSubview:self.bottomRightLabel1];
    [self addSubview:self.bottomRightLabel2];
    [self addSubview:self.topRightLabel];
    [self addSubview:self.lineView];
    [self makeUpConstriant];
}
#pragma mark 约束适配
-(void)makeUpConstriant{
    [self.leftImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.centerY.mas_equalTo(self);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(40);
    }];
    [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftImageView.mas_right).offset(10);
        make.centerY.mas_equalTo(self);
    }];
    [self.topRightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(23);
    }];
    [self.bottomRightLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.topRightLabel.mas_bottom).offset(6);
    }];
    [self.bottomRightLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.bottomRightLabel2.mas_left).offset(-14);
        make.centerY.mas_equalTo(self.bottomRightLabel2);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.bottom.mas_equalTo(self);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(1);
    }];
}
-(void)fillLeftImage:(NSString*)imgUrl num:(NSString *)num nickName:(NSString *)nickName type:(NSString *)type  ctime:(NSString *)ctime{
    [self.leftImageView setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:kFEDefaultImg]];
    [self.leftLabel setText:[NSString stringWithFormat:@"%@",nickName]];
    [self.topRightLabel setText:[NSString stringWithFormat:@"%@",ctime]];
    [self.bottomRightLabel1 setText:[NSString stringWithFormat:@"%@",type]];
    [self.bottomRightLabel2 setText:[NSString stringWithFormat:@"赠送%@次",num] ];
}
#pragma mark getter
-(UIImageView *)leftImageView{
    if (!_leftImageView) {
        _leftImageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wkc_smile"]];
    }
    return _leftImageView;
}
-(UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel =[[UILabel alloc]init];
        [_leftLabel setText:@"微信：叫兽"];
        [_leftLabel setFont:Demon_15_Font];
    }
    return _leftLabel;
}
-(UILabel *)topRightLabel{
    if (!_topRightLabel) {
        _topRightLabel =[[UILabel alloc]init];
        [_topRightLabel setText:@"2019-09-17"];
        [_topRightLabel setFont:Demon_14_Font];
    }
    return _topRightLabel;
}
-(UILabel *)bottomRightLabel1{
    if (!_bottomRightLabel1) {
        _bottomRightLabel1 =[[UILabel alloc]init];
        [_bottomRightLabel1 setText:@"好友注册成功"];
        [_bottomRightLabel1 setFont:Demon_12_Font];
        [_bottomRightLabel1 setTextColor:UIColorFromHex(0x57cb43)];
    }
    return _bottomRightLabel1;
}
-(UILabel *)bottomRightLabel2{
    if (!_bottomRightLabel2) {
        _bottomRightLabel2 =[[UILabel alloc]init];
        [_bottomRightLabel2 setFont:Demon_12_Font];
        [_bottomRightLabel2 setText:@"赠送10次"];
        [_bottomRightLabel1 setTextColor:UIColorFromHex(0x57cb43)];
    }
    return _bottomRightLabel2;
}
-(UIView *)lineView{
    if (!_lineView) {
        _lineView =[[UIView alloc]init];
        [_lineView setBackgroundColor:UIColorFromHex(0xf8f8f8)];
    }
    return _lineView;
}
@end
