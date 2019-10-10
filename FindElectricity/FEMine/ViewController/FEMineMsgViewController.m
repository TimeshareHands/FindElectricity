//
//  FEMineMsgViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMineMsgViewController.h"
#import "FEMineMsgCell.h"
#import "FEMsgChangeViewController.h"
#import "FEChangePhoneViewController.h"
#import "FESignChangeViewController.h"
@interface FEMineMsgViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (copy, nonatomic) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) FEMineMsgCell *avtCell;
@property (weak, nonatomic) FEMineMsgCell *nicknameCell;
@property (weak, nonatomic) FEMineMsgCell *sexCell;
@property (weak, nonatomic) FEMineMsgCell *phoneCell;
@property (weak, nonatomic) FEMineMsgCell *addressCell;
@property (weak, nonatomic) FEMineMsgCell *signCell;


@end

@implementation FEMineMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"个人信息"];
    [self initData];
    [self addView];
}

- (void)addView {
    
}

- (void)initData {
    _dataSource = @[@[@"头像",@"名称",@"性别",@"电话号码",@"地址"],@[@"签名"]];
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
    FEMineMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FEMineMsgCell" owner:self options:nil][0];
    }
    NSArray *arr = _dataSource[indexPath.section];
    NSString *text = arr[indexPath.row];
    cell.leftLab.text = text;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                //头像
                cell.img.hidden = NO;
                _avtCell = cell;
                break;
            }
            case 1:
            {
                //名称
                _nicknameCell = cell;
                _nicknameCell.rightLab.text = @"小李";
                break;
            }
            case 2:
            {
                //性别
                _sexCell = cell;
                _sexCell.rightLab.text = @"男";
                break;
            }
            case 3:
            {
                //电话号码
                _phoneCell = cell;
                _phoneCell.rightLab.text = @"15667676668";
                break;
            }
            case 4:
            {
                //地址
                _addressCell = cell;
                _addressCell.rightLab.text = @"长沙";
                break;
            }
            default:
                break;
        }
    }else {
        switch (indexPath.row) {
            case 0:
            {
                //签名
                _signCell = cell;
                _signCell.rightLab.text = @"你牛逼";
                break;
            }
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                //头像
                
                break;
            }
            case 1:
            {
                //名称
                FEMsgChangeViewController *vc = [[FEMsgChangeViewController alloc] init];
                vc.mscCell = _nicknameCell;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 2:
            {
                //性别
                
                break;
            }
            case 3:
            {
                //电话号码
                FEMsgChangeViewController *vc = [[FEMsgChangeViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 4:
            {
                //地址
                
                break;
            }
            default:
                break;
        }
    }else {
        switch (indexPath.row) {
            case 0:
            {
                //签名
                FESignChangeViewController *vc = [[FESignChangeViewController alloc] init];
                vc.mscCell = _signCell;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [UIView new];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
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
