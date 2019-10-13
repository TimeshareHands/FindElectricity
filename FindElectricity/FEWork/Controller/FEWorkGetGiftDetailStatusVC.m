//
//  FEWorkGetGiftDetailStatusVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkGetGiftDetailStatusVC.h"
#import "FEWorkGetGiftDetailStatusCell.h"
@interface FEWorkGetGiftDetailStatusVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)UILabel *leftLbl1;
@property(nonatomic, strong)UILabel *leftLbl2;
@property(nonatomic, strong)UILabel *leftLbl3;
@property(nonatomic, strong)UILabel *rightLbl;
@end

@implementation FEWorkGetGiftDetailStatusVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark -添加视图
-(void)addView{
    self.title =@"中奖详情";
    [self.view addSubview:self.myTableView];
    [self makeUpConstriant];
}
#pragma mark -约束适配
-(void)makeUpConstriant{
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}
#pragma mark -getter
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
    }
    return _myTableView;
}
-(UILabel *)leftLbl1{
    if (!_leftLbl1) {
        _leftLbl1 =[[UILabel alloc]init];
        [_leftLbl1 setText:@"礼品"];
        [_leftLbl1 setFont:Demon_15_Font];
    }
    return _leftLbl1;
}
-(UILabel *)leftLbl2{
    if (!_leftLbl2) {
        _leftLbl2 =[[UILabel alloc]init];
        [_leftLbl2 setText:@"卫生纸"];
        [_leftLbl2 setFont:Demon_15_Font];
    }
    return _leftLbl2;
}
-(UILabel *)leftLbl3{
    if (!_leftLbl3) {
        _leftLbl3 =[[UILabel alloc]init];
        [_leftLbl3 setText:@"中奖时间：2019年9月11日"];
        [_leftLbl3 setFont:Demon_13_Font];
    }
    return _leftLbl3;
}
-(UILabel *)rightLbl{
    if (!_rightLbl) {
        _rightLbl =[[UILabel alloc]init];
        [_rightLbl setText:@"已发货"];
        [_rightLbl setFont:Demon_15_Font];
        [_rightLbl setTextColor:UIColorFromHex(0x5FD053)];
    }
    return _rightLbl;
}
#pragma tableViewDelegate &&tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
     static NSString *kCellIndetify =@"cellIndentify";
       UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:kCellIndetify];
       if (cell ==nil) {
           cell =[[FEWorkGetGiftDetailStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
       }
       return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView =[[UIView alloc]init];
    UIView *whiteView =[[UIView alloc]init];
    [whiteView setBackgroundColor:[UIColor whiteColor]];
    [whiteView.layer setCornerRadius:5];
    [headView addSubview:whiteView];
    [whiteView addSubview:self.leftLbl1];
    [whiteView addSubview:self.leftLbl2];
    [whiteView addSubview:self.leftLbl3];
    [whiteView addSubview:self.rightLbl];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(10);
        make.height.mas_equalTo(83);
    }];
    [self.leftLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(20);
    }];
    [self.leftLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.leftLbl1.mas_right).offset(20);
        make.top.mas_equalTo(self.leftLbl1);
    }];
    [self.leftLbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(self.leftLbl2.mas_bottom).offset(15);
    }];
    [self.rightLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(20);
    }];
    return headView;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 160;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 103;
}
@end

