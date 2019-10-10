//
//  FEMineMsgViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMineMsgViewController.h"
#import "FEMineMsgCell.h"
@interface FEMineMsgViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (copy, nonatomic) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *nickname;
@property (weak, nonatomic) IBOutlet UILabel *leve;
@property (weak, nonatomic) IBOutlet UILabel *sign;


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
                break;
            }
            case 1:
            {
                //名称
                
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
