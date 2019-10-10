//
//  FEFindPasswordVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/8.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEFindPasswordVC.h"
#import "FESmsCodeCell.h"
#import "FEInputCell.h"
@interface FEFindPasswordVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)UIButton *confirmBtn;
@end

@implementation FEFindPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
#pragma mark --添加视图
- (void)addView{
    self.title =@"找回密码";
    [self.view addSubview:self.myTableView];
    [self makeUpConstriant];
}
#pragma mark --约束适配
- (void)makeUpConstriant{
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}
#pragma mark --getter
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
    }
    return _myTableView;
}
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"提交" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:UIColorFromHex(0x61EB9E)];
        [_confirmBtn.layer setCornerRadius:10];
    }
    return _confirmBtn;
}
#pragma tableViewDelegate &&tableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIndetify =@"cellIndentify";
       UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:kCellIndetify];
       if (cell ==nil) {
           if (indexPath.row ==0) {
               cell =[[FESmsCodeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
           }else{
                cell =[[FEInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
           }
            
       }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView =[[UIView alloc]init];
    [footView addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(20);
    }];
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}

#pragma mark 找回密码
- (void)findPassWordAction{
    FEFindPasswordRequestModel *requestModel =[[FEFindPasswordRequestModel alloc]init];
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(FindPwdHttp)  parameters:[requestModel mj_JSONObject] needToken:NO timeout:25 success:^(id  _Nonnull responseObject) {
        [FEUserOperation manager].userModel =[FELoginResponseUserInfoModel mj_objectWithKeyValues:responseObject[@"data"][@"userInfo"]];
        [FEUserOperation manager].token =responseObject[@"data"][@"token"];
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
