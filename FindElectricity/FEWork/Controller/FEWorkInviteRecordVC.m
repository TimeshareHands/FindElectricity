//
//  FEWorkInviteRecordVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkInviteRecordVC.h"
#import "FEWorkInviteFriendRecordCell.h"
@interface FEWorkInviteRecordVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)UIView *headView;
@property(nonatomic, strong)UIImageView *headImageView;
@property(nonatomic, strong)UIView *whiteView;
@property(nonatomic, strong)UILabel *headLbl1;
@property(nonatomic, strong)UILabel *headLbl2;
@property(nonatomic, strong)UILabel *headLbl3;
@end

@implementation FEWorkInviteRecordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark 添加视图
- (void)addView{
    self.title =@"邀请好友记录";
    [self.view setBackgroundColor:UIColorFromHex(0x7640ff)];
    [self.view addSubview:self.headView];
    [self.headView addSubview:self.headImageView];
    [self.headView addSubview:self.whiteView];
    [self.whiteView addSubview:self.headLbl1];
    [self.whiteView addSubview:self.headLbl2];
    [self.whiteView addSubview:self.headLbl3];
    [self.view addSubview:self.myTableView];
    [self makeUpconstriant];
}
#pragma mark- 约束适配
- (void)makeUpconstriant{
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.height.mas_equalTo(300);
    }];
    [self.headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headView);
        make.right.mas_equalTo(self.headView);
        make.top.mas_equalTo(self.headView);
        make.height.mas_equalTo(169);
    }];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(self.headView);
        make.top.mas_equalTo(self.headImageView.mas_bottom);
    }];
    [self.headLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.whiteView);
        make.top.mas_equalTo(13);
    }];
    [self.headLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.whiteView);
        make.top.mas_equalTo(self.headLbl1.mas_bottom).offset(26);
    }];
    [self.headLbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.whiteView);
        make.top.mas_equalTo(self.headLbl2.mas_bottom).offset(13);
    }];
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.headView.mas_bottom).offset(10);
        make.bottom.mas_equalTo(self.view);
    }];
}
#pragma mark -getter
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
    }
    return _myTableView;
}
-(UIView *)headView{
    if (!_headView) {
        _headView =[[UIView alloc]init];
    }
    return _headView;
}
-(UIImageView *)headImageView{
    if (!_headImageView) {
        _headImageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wkc_invitePoster"]];
    }
    return _headImageView;
}
-(UIView *)whiteView{
    if (!_whiteView) {
        _whiteView =[[UIView alloc]init];
        [_whiteView setBackgroundColor:[UIColor whiteColor]];
    }
    return _whiteView;
}
-(UILabel *)headLbl1{
    if (!_headLbl1) {
        _headLbl1 =[[UILabel alloc]init];
        [_headLbl1 setText:@"邀请好友记录"];
        [_headLbl1 setFont:Demon_18_Font];
    }
    return _headLbl1;
}
-(UILabel *)headLbl2{
    if (!_headLbl2) {
        _headLbl2 =[[UILabel alloc]init];
        [_headLbl2 setText:@"分享给微信好友2次，赠送2次抽奖机会"];
        [_headLbl2 setFont:Demon_14_Font];
    }
    return _headLbl2;
}
-(UILabel *)headLbl3{
    if (!_headLbl3) {
        _headLbl3 =[[UILabel alloc]init];
        [_headLbl3 setText:@"邀请好友下载登录0个，赠送0次抽奖机会"];
         [_headLbl3 setFont:Demon_14_Font];
    }
    return _headLbl3;
}
#pragma mark -tableViewDelegate&&tableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIndetify =@"cellIndentify";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:kCellIndetify];
    if (cell ==nil) {
        cell =[[FEWorkInviteFriendRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

@end
