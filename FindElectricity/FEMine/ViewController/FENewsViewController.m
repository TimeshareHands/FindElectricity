//
//  FENewsViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/11.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FENewsViewController.h"
#import "FENewsCell.h"
#import "FEDocmDetailViewController.h"
@interface FENewsViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSMutableArray *dataSource;

@end

@implementation FENewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"办证"];
    [self initData];
}

- (void)initData {
    _dataSource = [NSMutableArray array];
}

#pragma mark --tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    FENewsCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FENewsCell" owner:self options:nil][0];
    }

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FEDocmDetailViewController *detailVC = [[FEDocmDetailViewController alloc] init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 90;
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
