//
//  FEMessageViewController.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/7.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMessageViewController.h"
#import "FEMessageCell.h"
@interface FEMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataSource;
@end

@implementation FEMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"消息"];
}

- (void)initData {
    _dataSource = [NSMutableArray array];
}

#pragma mark --tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 12;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    FEMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FEMessageCell" owner:self options:nil][0];
    }
    cell.titleLab.text = @"舒服的设计费发";
    return cell;
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
