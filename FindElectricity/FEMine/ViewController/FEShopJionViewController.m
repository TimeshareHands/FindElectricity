//
//  FEShopJionViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEShopJionViewController.h"
#import "FEMyShopListCell.h"
#import "FEAddShopViewController.h"
@interface FEShopJionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSMutableArray *dataSource;

@end

@implementation FEShopJionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"商家入驻"];
    [self rightBtnWithTitle:@"添加" target:self action:@selector(addShop) color:UIColorFromHex(0xa7a7a7)];
    [self initData];
}

- (void)initData {
    _dataSource = [NSMutableArray array];
}

- (void)addShop {
    FEAddShopViewController *addShopVC = [[FEAddShopViewController alloc] init];
    [self.navigationController pushViewController:addShopVC animated:YES];
}

#pragma mark --tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    FEMyShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FEMyShopListCell" owner:self options:nil][0];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
