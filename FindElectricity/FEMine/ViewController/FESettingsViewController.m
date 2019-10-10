//
//  FESettingsViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FESettingsViewController.h"
#import "FESettingsCell.h"
#import "FEMineMsgViewController.h"
#import "FEAddressViewController.h"
#import "FEAboutViewController.h"
@interface FESettingsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (copy, nonatomic) NSArray *dataSource;
@end

@implementation FESettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"设置"];
    [self initData];
}

- (void)initData {
    _dataSource = @[@"个人信息",@"收货地址",@"关于我们"];
}

#pragma mark --tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    FESettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FESettingsCell" owner:self options:nil][0];
    }
    cell.textLab.text =_dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row) {
        case 0:
        {
            //个人信息
            FEMineMsgViewController *vc = [[FEMineMsgViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 1:
        {
            //地址
            FEAddressViewController *vc = [[FEAddressViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        case 2:
        {
            //关于我们
            FEAboutViewController *vc = [[FEAboutViewController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
            break;
        }
        default:
            break;
    }
    
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
