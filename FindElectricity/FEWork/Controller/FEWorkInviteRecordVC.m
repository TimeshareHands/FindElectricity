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
    [self requestRecord];
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
    return self.listArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIndetify =@"cellIndentify";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:kCellIndetify];
    if (cell ==nil) {
       FEWorkInviteFriendRecordCell *recordCell =[[FEWorkInviteFriendRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
        NSDictionary *dic =self.listArr[indexPath.row];
        [recordCell fillLeftImage:dic[@"faceImg"] num:dic[@"num"] nickName:dic[@"nickName"] type:dic[@"type"] ctime:dic[@"ctime"]];
        cell =recordCell;
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}
#pragma mark -查询记录
-(void)requestRecord{
    NSMutableDictionary *parameter =[NSMutableDictionary dictionary];
    WEAKSELF;
    [[NetWorkManger manager]postDataWithUrl:BASE_URLWith(InvFriendLogHttp) parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
         if ([data[@"code"] intValue] == KSuccessCode) {
            MTSVPDismiss;
             weakSelf.listArr =data[@"data"][@"list"];
             NSString *lotterNum =data[@"data"][@"shareFriend"][@"lotteryNumber"];
             NSString *shareNum =data[@"data"][@"shareFriend"][@"shareNum"];
             NSString *regitserLotterNum =data[@"data"][@"register"][@"lotteryNumber"];
             NSString *regitserNum =data[@"data"][@"register"][@"registerNum"];
             [weakSelf.headLbl2 setAttributedText:[self setRichNumberWithLabel:[NSString stringWithFormat:@"分享给微信好友%@次，赠送%@次抽奖机会",shareNum,lotterNum] Color:[UIColor redColor]]];
             [weakSelf.headLbl3 setAttributedText:[self setRichNumberWithLabel:[NSString stringWithFormat:@"邀请好友下载登录%@个，赠送%@次抽奖机会",regitserNum,regitserLotterNum] Color:[UIColor redColor]]];
             [self.myTableView reloadData];
        }else {
            MTSVPShowInfoText(data[@"msg"]);
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/**
 *改变字符串中所有数字的颜色
 */
- (NSMutableAttributedString *)setRichNumberWithLabel:(NSString*)lbltext Color:(UIColor *)color {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lbltext];
    NSString *temp = nil;
    for(int i =0; i < [attributedString length]; i++) {
        temp = [lbltext substringWithRange:NSMakeRange(i, 1)];
        if ([self isPureInt:temp]) {
            [attributedString setAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                             color, NSForegroundColorAttributeName,
                                            nil]
                                      range:NSMakeRange(i, 1)];
        }
    }
   return attributedString;
}
 
 
/**
 *此方法是用来判断一个字符串是不是整型.
 *如果传进的字符串是一个字符,可以用来判断它是不是数字
 */
- (BOOL)isPureInt:(NSString *)string {
    NSScanner *scan = [NSScanner scannerWithString:string];
    int value;
    return [scan scanInt:&value] && [scan isAtEnd];
}

@end
