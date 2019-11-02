//
//  FEWorkMainVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/1.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkMainVC.h"
#import "FEWorkMainHeadView.h"
#import "FETWorkMainTableViewCell.h"
#import "FEWorkEValueShopVC.h"
#import "FEWorkGetGiftVC.h"
#import "FEWorkTurnTableVC.h"
#import "FEWorkModel.h"
#import "FEWorkEValueDetailVC.h"
#import "FESignInActAlert.h"
#import "FEGetPrizeShareFriendVC.h"
#import "FECycleViewController.h"
#import "FEWorkStrategyVC.h"
@interface FEWorkMainVC ()<UITableViewDelegate,UITableViewDataSource,FEWorkMainHeadViewDelegate>
@property (nonatomic, strong)FEWorkMainHeadView *headView;
@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, strong)FEWorkPanelDataResponseModel *responseModel;
@property (nonatomic, strong)FESignInActAlert *signInAlertV;
@end

@implementation FEWorkMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(requestPanelData) name:@"loginSuccessNotification" object:nil];
    [self getUserData];
    [self requestPanelData];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"loginSuccessNotification" object:nil];
}
#pragma mark -添加视图
-(void)addView{
    [self.view addSubview:self.myTableView];
    [self makeUpconstraint];
}
#pragma mark -约束适配
-(void)makeUpconstraint{
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark -getter
-(FEWorkMainHeadView *)headView{
    if (!_headView) {
        _headView =[[FEWorkMainHeadView alloc]init];
        [_headView setLocalDelegate:self];
    }
    return _headView;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
    }
    return _myTableView;
}
-(FESignInActAlert *)signInAlertV{
    if (!_signInAlertV) {
        _signInAlertV =[[FESignInActAlert alloc]init];
    }
    return _signInAlertV;
}
#pragma mark --tableViewDelegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIndetify =@"cellIndentify";
    FETWorkMainTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:kCellIndetify];
    if (cell ==nil) {
         cell =[[FETWorkMainTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
    }
    if (indexPath.row ==0) {
        [cell setLeftImg:@"wkm_addMember" topText:@"邀请好友" topCenterText:@"+10次抽奖" centerText:@"邀请好友下载注册找电" bottomText:@"获得抽奖机会" buttonColor:UIColorFromHex(0xff954b) buttonTitle:@"去邀请"];
        cell.didClick = ^{
            FEGetPrizeShareFriendVC *shareVC =[[FEGetPrizeShareFriendVC alloc]init];
            [self.navigationController pushViewController:shareVC animated:YES];
        };
    }
    else if (indexPath.row ==1) {
        [cell setLeftImg:@"wkm_bike" topText:@"骑行" topCenterText:@"每骑行1km得100电量值" centerText:@"通过骑行" bottomText:@"每天最高可获得5000电量值" buttonColor:UIColorFromHex(0xf16867) buttonTitle:@"去骑行"];
        cell.didClick = ^{
            FECycleViewController *rideVC =[[FECycleViewController alloc]init];
            [self.navigationController pushViewController:rideVC animated:YES];
        };
    }else if(indexPath.row ==2){
         [cell setLeftImg:@"wkm_read" topText:@"阅读电量值攻略" topCenterText:@"+500电量值" centerText:@"阅读电量攻略" bottomText:@"获得电量值奖励" buttonColor:UIColorFromHex(0x03bf30) buttonTitle:@"去阅读"];
        cell.didClick = ^{
            FEWorkStrategyVC *stategyVC =[[FEWorkStrategyVC alloc]init];
            [self.navigationController pushViewController:stategyVC animated:YES];
        };
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView =[[UIView alloc]init];
    [headView setUserInteractionEnabled:YES];
    
    [headView addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView);
        make.right.mas_equalTo(headView);
        make.height.mas_equalTo(316);
        make.top.mas_equalTo(headView);
    }];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 420;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        FEGetPrizeShareFriendVC *shareVC =[[FEGetPrizeShareFriendVC alloc]init];
        [self.navigationController pushViewController:shareVC animated:YES];
    }else if(indexPath.row ==1){
        FECycleViewController *rideVC =[[FECycleViewController alloc]init];
        [self.navigationController pushViewController:rideVC animated:YES];
    }else{
        FEWorkStrategyVC *stategyVC =[[FEWorkStrategyVC alloc]init];
        [self.navigationController pushViewController:stategyVC animated:YES];
    }
}
#pragma FEWorkMainHeadViewDelegate
-(void)findElectricityAction{ //查找电量
    FEWorkEValueDetailVC *detailVC =[[FEWorkEValueDetailVC alloc]init];
    detailVC.lotterNum =self.responseModel.lottery_number;
    detailVC.myEvalue =self.responseModel.myElectrictyVal;
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)choujiangAction {//点击抽奖
     FEWorkTurnTableVC *chouVC =[[FEWorkTurnTableVC alloc]init];
    [self.navigationController pushViewController:chouVC animated:YES];

}
-(void)signInAction:(NSInteger)num{//签到
    WEAKSELF;
    NSMutableDictionary *parameter =[NSMutableDictionary dictionary];
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(SignHttp) parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
         NSDictionary *data = (NSDictionary *)responseObject;
         if ([data[@"code"] intValue] == KSuccessCode) {
            MTSVPDismiss;
           [weakSelf.signInAlertV setEvalue:[NSString stringWithFormat:@"%zd",num]];
           [weakSelf.signInAlertV show];
            [weakSelf requestPanelData];
        }else {
            MTSVPShowInfoText(data[@"msg"]);
        }
       
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
-(void)enterEvalueShop{//进入电量值商城
   FEWorkEValueShopVC *detailVC =[[FEWorkEValueShopVC alloc]init];
   [self.navigationController pushViewController:detailVC animated:YES];
}

#pragma mark 请求任务面板数据
-(void)requestPanelData{
        NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
        WEAKSELF;
       [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(TaskPanelDataHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
           NSLog(@"responseObject=%@",responseObject);
           weakSelf.responseModel =[FEWorkPanelDataResponseModel mj_objectWithKeyValues:responseObject[@"data"]];
           [weakSelf.headView fillData:self.responseModel];
       } failure:^(NSError * _Nonnull error) {
          
       }];
}
- (void)getUserData {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(UserNewInfoHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
        if ([data[@"code"] intValue] == KSuccessCode) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setUserInfo:[FELoginResponseUserInfoModel mj_objectWithKeyValues:responseObject[@"data"][@"userInfo"]]];
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                MTSVPShowInfoText(data[@"msg"]);
            });
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
-(void)setUserInfo:(FELoginResponseUserInfoModel*)model{
    [FEUserOperation manager].userModel =model;
}

@end
