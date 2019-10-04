//
//  FEWorkMainVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/1.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkMainVC.h"
#import "FEWorkMainHeadView.h"
#import "FETWorkMainTableViewCell.h"
#import "FEWorkEValueShopVC.h"
@interface FEWorkMainVC ()<UITableViewDelegate,UITableViewDataSource,FEWorkMainHeadViewDelegate>
@property (nonatomic, strong)FEWorkMainHeadView *headView;
@property (nonatomic, strong)UITableView *myTableView;
@end

@implementation FEWorkMainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark -添加视图
-(void)addView{
    [self.view addSubview:self.myTableView];
    [self makeUpconstraint];
}
#pragma mark -约束适配
-(void)makeUpconstraint{
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark -getter
-(FEWorkMainHeadView *)headView{
    if (!_headView) {
        _headView =[[FEWorkMainHeadView alloc]init];
        [_headView setLocalDelegate:self];
    }
    return _headView;
}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
    }
    return _myTableView;
}
#pragma mark --tableViewDelegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIndetify =@"cellIndentify";
    FETWorkMainTableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:kCellIndetify];
    if (cell ==nil) {
         cell =[[FETWorkMainTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
    }
   
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView =[[UIView alloc]init];
    [headView addSubview:self.headView];
    [self.headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView);
        make.right.mas_equalTo(headView);
        make.height.mas_equalTo(316);
        make.top.mas_equalTo(headView);
    }];
    return headView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 420;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 90;
}

#pragma FEWorkMainHeadViewDelegate
-(void)findElectricityAction{ //查找电量
    FEWorkEValueShopVC *detailVC =[[FEWorkEValueShopVC alloc]init];
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)choujiangAction {//点击抽奖


}
-(void)signInAction:(NSInteger)num{//签到

    
}
-(void)enterEvalueShop{//进入电量值商城

}
@end
