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
    
    [self initData];
    [self addView];
}

- (void)getUserData {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(UserNewInfoHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        [self setUserInfo:[FELoginResponseUserInfoModel mj_objectWithKeyValues:responseObject[@"data"][@"userInfo"]]];
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setUserInfo:(FELoginResponseUserInfoModel *)userInfo {
    _userInfo = userInfo;
    _nickname.text = _userInfo.nickName;
    _sign.text = _userInfo.signature;
    _leve.text = [NSString stringWithFormat:@" %@ ",_userInfo.grade];
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
    _dataSource = @[@[@{@"title":@"商家入住申请",@"icon":@"mine_checkIn"},@{@"title":@"商家收藏",@"icon":@"mine_collect"},@{@"title":@"商家位置纠正",@"icon":@"mine_modify"}],@[@{@"title":@"意见建议",@"icon":@"mine_advice"},@{@"title":@"推荐好友",@"icon":@"mine_introduce"}]];
}

- (FESharePopView *)sharePopView {
    if (!_sharePopView) {
        _sharePopView = [FESharePopView createView];
        _sharePopView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        WEAKSELF;
        _sharePopView.didClick = ^(FESharePopView * _Nonnull lau, NSInteger tag) {
            
            if (tag==1) {
                //朋友圈
                
            }else{
                //微信好友
                
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

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
