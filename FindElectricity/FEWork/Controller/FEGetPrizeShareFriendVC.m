//
//  FEGetPrizeShareFriendVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/11.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEGetPrizeShareFriendVC.h"
#import "FEWorkGetPrizeShareCell.h"
#import "FEWorkGetPrizeShareWxCell.h"
#import "FEWorkGetPrizeShareAccordCell.h"
#import "FEWorkInviteAlertView.h"
#import "FEWorkInviteRecordVC.h"
#import "FEWorkShareBottomView.h"
@interface FEGetPrizeShareFriendVC ()<UITableViewDelegate,UITableViewDataSource,FEWorkGetPrizeShareWxCellDelegate,FEWorkGetPrizeShareCellDelegate,FEWorkGetPrizeShareAccordCellDelegate>
@property(nonatomic,strong)UITableView *myTableView;
@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UIButton *friendLineBtn;
@property(nonatomic,strong)UIButton *wxBtn;
@property(nonatomic,strong)UIButton *faceTofaceBtn;
@property(nonatomic,strong)UILabel *friendLineLbl;
@property(nonatomic,strong)UILabel *wxLbl;
@property(nonatomic,strong)UILabel *faceTofaceLbl;
@property(nonatomic,strong)FEWorkInviteAlertView *inviteView;
@property(nonatomic,strong)FEWorkShareBottomView *shareBottomView;
@end

@implementation FEGetPrizeShareFriendVC

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

#pragma  mark -添加视图
- (void)addView{
    self.title =@"分享好友";
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.bottomView];
    [self.bottomView addSubview:self.friendLineBtn];
    [self.bottomView addSubview:self.wxBtn];
    [self.bottomView addSubview:self.faceTofaceBtn];
    [self.bottomView addSubview:self.friendLineLbl];
    [self.bottomView addSubview:self.wxLbl];
    [self.bottomView addSubview:self.faceTofaceLbl];
    [self makeUpConstriant];
}
#pragma  mark -约束适配
- (void)makeUpConstriant{
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.bottomView.mas_top);
        make.top.mas_equalTo(self.view);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    [self.wxBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomView);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(16);
    }];
    [self.wxLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.bottomView);
        make.top.mas_equalTo(self.wxBtn.mas_bottom).offset(10);
    }];
    [self.friendLineBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.wxBtn.mas_left).offset(-66);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(16);
    }];
    [self.friendLineLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.friendLineBtn);
        make.top.mas_equalTo(self.friendLineBtn.mas_bottom).offset(10);
    }];
    [self.faceTofaceBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.wxBtn.mas_right).offset(66);
        make.width.mas_equalTo(44);
        make.height.mas_equalTo(44);
        make.top.mas_equalTo(16);
    }];
    [self.faceTofaceLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.faceTofaceBtn);
        make.top.mas_equalTo(self.faceTofaceBtn.mas_bottom).offset(10);
    }];
}

#pragma mark -getter
-(FEWorkInviteAlertView *)inviteView{
    if (!_inviteView) {
        _inviteView =[[FEWorkInviteAlertView alloc]init];
    }
    return _inviteView;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
    }
    return _myTableView;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView =[[UIView alloc]init];
        [_bottomView setBackgroundColor:[UIColor whiteColor]];
    }
    return _bottomView;
}
-(UIButton *)friendLineBtn{
    if (!_friendLineBtn) {
        _friendLineBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_friendLineBtn setImage:[UIImage imageNamed:@"wkc_FriendLine"] forState:UIControlStateNormal];
    }
    return _friendLineBtn;
}
-(UIButton *)wxBtn{
    if (!_wxBtn) {
        _wxBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_wxBtn setImage:[UIImage imageNamed:@"wkc_weixin"] forState:UIControlStateNormal];
        
    }
    return _wxBtn;
}
-(UIButton *)faceTofaceBtn{
    if (!_faceTofaceBtn) {
        _faceTofaceBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_faceTofaceBtn setImage:[UIImage imageNamed:@"wkc_FaceToFace"] forState:UIControlStateNormal];
        WEAKSELF;
        [_faceTofaceBtn bk_addEventHandler:^(id sender) {
            [weakSelf.inviteView show];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _faceTofaceBtn;
}
-(UILabel *)friendLineLbl{
    if (!_friendLineLbl) {
        _friendLineLbl =[[UILabel alloc]init];
        [_friendLineLbl setText:@"朋友圈"];
        [_friendLineLbl setFont:Demon_14_Font];
    }
    return _friendLineLbl ;
}
-(UILabel *)wxLbl{
    if (!_wxLbl) {
        _wxLbl =[[UILabel alloc]init];
        [_wxLbl setText:@"微信"];
         [_wxLbl setFont:Demon_14_Font];
    }
    return _wxLbl ;
}
-(UILabel *)faceTofaceLbl{
    if (!_faceTofaceLbl) {
        _faceTofaceLbl =[[UILabel alloc]init];
        [_faceTofaceLbl setText:@"面对面"];
        [_faceTofaceLbl setFont:Demon_14_Font];
    }
    return _faceTofaceLbl ;
}
#pragma mark tableViewDelegate &&tableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIndetify =@"cellIndentify";
    
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:kCellIndetify];
    if (cell ==nil) {
        if (indexPath.row ==0) {
            FEWorkGetPrizeShareCell* cell1 = [[FEWorkGetPrizeShareCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
            cell1.localDelegate =self;
            cell =cell1;
        }else if(indexPath.row ==1){
           FEWorkGetPrizeShareWxCell  *cell2 = [[FEWorkGetPrizeShareWxCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
            cell2.localDelegate =self;
            cell =cell2;
        }else{
            FEWorkGetPrizeShareAccordCell *cell3 = [[FEWorkGetPrizeShareAccordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
            cell3.localDelegate =self;
            cell =cell3;
        }
        
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView =[[UIView alloc]init];
    UIImageView *headImg =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wkc_activeBanner"]];
    [headView addSubview:headImg];
    [headImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView);
        make.right.mas_equalTo(headView);
        make.top.mas_equalTo(headView);
        make.bottom.mas_equalTo(headView);
    }];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
         return 262;
    }else if(indexPath.row ==1){
        return 320;
    }else{
        return 225;
    }
   
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 201;
}
#pragma mark -
-(void)shareToIntroduceAction{
    
}
#pragma mark -
-(void)generateShareImgAction{
    [self.inviteView show];
}
#pragma mark -
-(void)findRecord{
    FEWorkInviteRecordVC *recordVC =[[FEWorkInviteRecordVC alloc]init];
    [self.navigationController pushViewController:recordVC animated:YES];
}
@end
