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
#import "MJRefresh.h"
#import "FEMySHopListMode.h"
@interface FEShopJionViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSMutableArray *dataSource;
@property (nonatomic, assign) int pageNo;
@property (nonatomic, assign) NSInteger index;
@end

@implementation FEShopJionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"商家入驻"];
    [self rightBtnWithTitle:@" 添加" target:self action:@selector(addShop) color:UIColorFromHex(0x404040)];
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
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    FEMyShopListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FEMyShopListCell" owner:self options:nil][0];
    }
    cell.model = _dataSource[indexPath.row];
    cell.btn.tag = indexPath.row;
    WEAKSELF;
    [cell.btn bk_addEventHandler:^(id sender) {
        [weakSelf delete:sender];
    } forControlEvents:UIControlEventTouchUpInside];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
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
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(TenantsLogHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
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
        [_dataSource addObjectsFromArray:[FEMySHopListMode mj_objectArrayWithKeyValuesArray:array]];
        if (_dataSource.count == 0)
        {
            MTSVPShowInfoText(@"暂无数据");
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

- (void)delete:(UIButton *)sender {
    _index = sender.tag;
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    
    [actionSheet addButtonWithTitle:@"确定删除"];
    // 同时添加一个取消按钮
    [actionSheet addButtonWithTitle:@"取消"];
    // 将取消按钮的index设置成我们刚添加的那个按钮，这样在delegate中就可以知道是那个按钮
    actionSheet.destructiveButtonIndex = actionSheet.numberOfButtons - 1;
    [actionSheet showInView:self.view];
}

#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            [self deleteShop];
            break;
        }
            
        default:
            break;
    }
}

//删除店铺
- (void)deleteShop {
    FEMySHopListMode *model = _dataSource[_index];
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:model.mapId forKey:@"mapId"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(DelTenantsHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self refreshData];
        });
        
    } failure:^(NSError * _Nonnull error) {
        
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
