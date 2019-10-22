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
#import "FEWorkInviteStandStardVC.h"
#import <UShareUI/UShareUI.h>
@interface FEGetPrizeShareFriendVC ()<UITableViewDelegate,UITableViewDataSource,FEWorkGetPrizeShareWxCellDelegate,FEWorkGetPrizeShareCellDelegate,FEWorkGetPrizeShareAccordCellDelegate,FEWorkShareBottomViewDelegate,FEWorkInviteAlertViewDelegate>
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
@property(nonatomic,strong) FEWorkGetPrizeShareAccordCell *cell3;
@end

@implementation FEGetPrizeShareFriendVC

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
        [_inviteView setLocalDelegate:self];
    }
    return _inviteView;
}
-(FEWorkShareBottomView *)shareBottomView{
    if (!_shareBottomView) {
        _shareBottomView =[[FEWorkShareBottomView alloc]init];
    }
    return _shareBottomView;
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
        WEAKSELF;
        [_friendLineBtn bk_addEventHandler:^(id sender) {
            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _friendLineBtn;
}
-(UIButton *)wxBtn{
    if (!_wxBtn) {
        _wxBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_wxBtn setImage:[UIImage imageNamed:@"wkc_weixin"] forState:UIControlStateNormal];
        WEAKSELF;
        [_wxBtn bk_addEventHandler:^(id sender) {
            [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
        } forControlEvents:UIControlEventTouchUpInside];
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
           self.cell3 = [[FEWorkGetPrizeShareAccordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
            self.cell3.localDelegate =self;
            cell =self.cell3;
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
    [self shareAction];
}
-(void)readStandard{
    FEWorkInviteStandStardVC *standardVC =[[FEWorkInviteStandStardVC alloc]init];
    [self.navigationController pushViewController:standardVC animated:YES];
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
#pragma mark -
-(void)shareWx{
    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
}
-(void)shareLineQ{
    [self shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
}

#pragma mark -查询记录
-(void)requestRecord{
    NSMutableDictionary *parameter =[NSMutableDictionary dictionary];
    WEAKSELF;
    [[NetWorkManger manager]postDataWithUrl:BASE_URLWith(InvFriendLogHttp) parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
         if ([data[@"code"] intValue] == KSuccessCode) {
            MTSVPDismiss;
            
             NSString *lotterNum =data[@"data"][@"shareFriend"][@"lotteryNumber"];
             NSString *shareNum =data[@"data"][@"shareFriend"][@"shareNum"];
             NSString *regitserLotterNum =data[@"data"][@"register"][@"lotteryNumber"];
             NSString *regitserNum =data[@"data"][@"register"][@"registerNum"];
             [weakSelf.cell3.lb2 setAttributedText:[self setRichNumberWithLabel:[NSString stringWithFormat:@"分享给微信好友%@次，赠送%@次抽奖机会",shareNum,lotterNum] Color:[UIColor redColor]]];
             [weakSelf.cell3.lb3 setAttributedText:[self setRichNumberWithLabel:[NSString stringWithFormat:@"邀请好友下载登录%@个，赠送%@次抽奖机会",regitserNum,regitserLotterNum] Color:[UIColor redColor]]];

             [weakSelf.myTableView reloadData];
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
#pragma mark -FEWorkInviteAlertViewDelegate
-(void)goGiftAction{
    [self shareAction];
}
- (void)shareAction {
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_WechatSession)]];
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];
    
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"找电" descr:@"找电新版福利来啦！天天抽大奖礼品免费邮寄到家！下载注册填写邀请码，免费赠送10次抽奖机会，赶快一起来玩吧！" thumImage:[UIImage imageNamed:@"AppIcon"]];
    //设置网页地址
    shareObject.webpageUrl =@"http://apk.csjiayu.com/zhaodian/index.html?invitation=2222&from=singlemessage&isappinstalled=0";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

@end
