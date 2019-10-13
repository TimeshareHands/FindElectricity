//
//  FEMessageViewController.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/7.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMessageViewController.h"
#import "FEMessageCell.h"
#import "FEMessageModel.h"
#import "MJRefresh.h"
@interface FEMessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *dataSource;
@property (nonatomic, assign) int pageNo;
@end

@implementation FEMessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"消息"];
    [self initData];
    [self addView];
}

- (void)initData {
    _pageNo = 1;
    _dataSource = [NSMutableArray array];
}

- (void)addView
{
    WeakSelf(weakSelf);
    _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf refreshData];
    }];
    _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMore];
    }];
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
    FEMessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FEMessageCell" owner:self options:nil][0];
    }
    FEMessageModel *model = _dataSource[indexPath.row];
    cell.model = model;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 66;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshData];
}

- (void)getDataOfPage:(NSInteger)page pageSize:(NSInteger)pageSize {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:@(page) forKey:@"page"];
    [parameter setValue:@(pageSize) forKey:@"pageSize"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(SystemMsgHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf getDataSuccess:responseObject];
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 请求返回数据
- (void)getDataSuccess:(id)response
{
    //    [SVProgressHUD dismiss];
    NSDictionary *data = (NSDictionary *)response;
    MYLog(@"%@",data);
    [self.tableView.mj_header endRefreshing];
    [self.tableView.mj_footer endRefreshing];
    if ([data[@"code"] intValue] == KSuccessCode) {
        MTSVPDismiss;
        NSArray *array = data[@"data"][@"list"];
        if (array.count == 0) {
            [_tableView.mj_footer endRefreshingWithNoMoreData];
        }
        [_dataSource addObjectsFromArray:[FEMessageModel mj_objectArrayWithKeyValuesArray:array]];
        if (_dataSource.count == 0)
        {
            MTSVPShowInfoText(@"暂无消息");
        }
        [_tableView reloadData];
    }else {
        MTSVPShowInfoText(data[@"msg"]);
    }
}

- (void)refreshData
{
    //加载数据
    _pageNo = 1;
    [self.tableView.mj_footer resetNoMoreData];
    [_dataSource removeAllObjects];
    [self getDataOfPage:_pageNo pageSize:20];
    [self.tableView reloadData];
}

- (void)loadMore
{
    [self getDataOfPage:(++_pageNo) pageSize:20];
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
