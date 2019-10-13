//
//  FETotalGetPrizeRecordCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FETotalGetPrizeRecordCell.h"
@interface FETotalGetPrizeRecordCell()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UILabel *titleLabel;
@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)UIView *lineView;
@end
@implementation FETotalGetPrizeRecordCell

-(id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}
#pragma mark -添加视图
-(void)addView{
    [self addSubview:self.lineView];
    [self addSubview:self.titleLabel];
    [self addSubview:self.myTableView];
    [self makeUpconstriant];
}
#pragma mark -约束适配
-(void)makeUpconstriant{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(15);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.titleLabel);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(1);
    }];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(5);
        make.right.mas_equalTo(-5);
        make.top.mas_equalTo(self.titleLabel.mas_bottom).offset(15);
        make.bottom.mas_equalTo(-15);
    }];
}
#pragma mark -getter
-(UIView *)lineView{
    if (!_lineView) {
        _lineView =[[UIView alloc]init];
        [_lineView setBackgroundColor:UIColorFromHex(0xA3A3A3)];
    }
    return _lineView;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel =[[UILabel alloc]init];
        [_titleLabel setText:@"我的获奖记录"];
        [_titleLabel setFont:Demon_13_Font];
    }
    return _titleLabel;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
        [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _myTableView;
}
#pragma mark -tableViewdelegate &&tableViewdatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell =[[UITableViewCell alloc]init];
    UILabel *label =[[UILabel alloc]init];
    [label setText:@"2018年10月16日    领取 卫生纸1提    领取人：xxx    未发货 "];
    [label setFont:Demon_10_Font];
    [label setTextAlignment:NSTextAlignmentCenter];
    [cell addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(cell);
        make.right.mas_equalTo(cell);
        make.top.mas_equalTo(cell);
        make.bottom.mas_equalTo(cell);
    }];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 20;
}


@end
