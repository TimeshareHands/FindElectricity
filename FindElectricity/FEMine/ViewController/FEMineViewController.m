//
//  FEMineViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMineViewController.h"
#import "FEMineCell.h"
#import "FESettingsViewController.h"
#import "FEFeedbackViewController.h"
#import "FEShopJionViewController.h"
#import "FECollectViewController.h"
#import "FEPositionErrorViewController.h"
#import "FESharePopView.h"
#import <UMShare/UMShare.h>
@interface FEMineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (copy, nonatomic) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIImageView *avtImg;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *leve;
@property (weak, nonatomic) IBOutlet UILabel *sign;
@property (weak, nonatomic) FESharePopView *sharePopView;
@property (strong, nonatomic) FELoginResponseUserInfoModel *userInfo;
@end

@implementation FEMineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
       [NetWorkManger manager].senderVC =self;
    [self initData];
    [self addView];
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
        }else if ([data[@"code"] intValue] != KTokenFailCode){
            dispatch_async(dispatch_get_main_queue(), ^{
                MTSVPShowInfoText(data[@"msg"]);
            });
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setUserInfo:(FELoginResponseUserInfoModel *)userInfo {
    _userInfo = userInfo;
    _nickname.text = _userInfo.nickName;
    _sign.text = _userInfo.signature;
    _leve.text = [NSString stringWithFormat:@"  %@  ",_userInfo.grade];
    [_avtImg sd_setImageWithURL:[NSURL URLWithString:_userInfo.faceImg] placeholderImage:[UIImage imageNamed:kFEDefaultImg]];
    _avtImg.clipsToBounds = YES;
    _avtImg.layer.cornerRadius = 20;
}

- (void)addView {
    if (@available(iOS 11.0, *))
    {
        self.tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        
    }
    else
    {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    _tableView.tableHeaderView = _headView;
    _leve.layer.borderColor = [UIColor whiteColor].CGColor;
    _leve.layer.borderWidth = 1;
}

- (void)initData {
    _dataSource = @[@[@{@"title":@"商家入住申请",@"icon":@"mine_checkIn"},@{@"title":@"商家收藏",@"icon":@"mine_collect1"},@{@"title":@"商家位置纠正",@"icon":@"mine_modify"}],@[@{@"title":@"意见建议",@"icon":@"mine_advice"},@{@"title":@"推荐好友",@"icon":@"mine_introduce"}]];
}

- (FESharePopView *)sharePopView {
    if (!_sharePopView) {
        _sharePopView = [FESharePopView createView];
        _sharePopView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        WEAKSELF;
        _sharePopView.didClick = ^(FESharePopView * _Nonnull lau, NSInteger tag) {
            
            if (tag==1) {
                //朋友圈
                [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatTimeLine];
            }else{
                //微信好友
                [weakSelf shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
            }
        };
    }
    return _sharePopView;
}

#pragma mark --tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = _dataSource[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    FEMineCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FEMineCell" owner:self options:nil][0];
    }
    NSArray *arr = _dataSource[indexPath.section];
    NSDictionary *dic = arr[indexPath.row];
    cell.icon.image = [UIImage imageNamed:dic[@"icon"]];
    cell.titleLab.text = dic[@"title"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                //商家入驻
                FEShopJionViewController *vc = [[FEShopJionViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 1:
            {
                //收藏
                FECollectViewController *vc = [[FECollectViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 2:
            {
                //位置报告
                FEPositionErrorViewController *vc = [[FEPositionErrorViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
        }
    }else {
        switch (indexPath.row) {
            case 0:
            {
                //意见反馈
                FEFeedbackViewController *vc = [[FEFeedbackViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 1:
            {
                //推荐
                [MTKeyWindow addSubview:self.sharePopView];
                break;
            }
            default:
                break;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 53;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (IBAction)toSetting:(id)sender {
    FESettingsViewController *settVC  = [[FESettingsViewController alloc] init];
    [self.navigationController pushViewController:settVC animated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    [self getUserData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"找电" descr:@"找电新版福利来啦！天天抽大奖礼品免费邮寄到家！下载注册填写邀请码，免费赠送10次抽奖机会，赶快一起来玩吧！" thumImage:[UIImage imageNamed:@"AppIcon"]];
    //设置网页地址
    shareObject.webpageUrl =[NSString stringWithFormat:@"http://apk.csjiayu.com/zhaodian/index.html?invitation=%@&from=singlemessage&isappinstalled=0",[FEUserOperation manager].userModel.invCode];
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
