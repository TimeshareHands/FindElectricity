//
//  FEWorkEValueDetailVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/3.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkEValueDetailVC.h"
#import "FEWorkEValueDetailHeadView.h"
#import "FEWorkEvalueCell.h"
#import "FEWorkEValueShopVC.h"
#import "FECycleViewController.h"
@interface FEWorkEValueDetailVC ()<UITableViewDelegate,UITableViewDataSource,FEWorkEValueDetailHeadViewDelegate>
@property (nonatomic, strong) FEWorkEValueDetailHeadView *headView;
@property (nonatomic, strong) UITableView *myTableView;
@property (nonatomic, strong) NSArray *titleArr;
@end

@implementation FEWorkEValueDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self.headView setlotterNum:self.lotterNum myEvalue:self.myEvalue];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestEvalueDetail];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma 添加视图
-(void)addView{
    self.title =@"电量详情";
    [self.view addSubview:self.myTableView];
    [self makeUpConstraint];
}

#pragma 约束适配
-(void)makeUpConstraint{
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.view);
       make.right.mas_equalTo(self.view);
       make.top.mas_equalTo(self.view);
       make.bottom.mas_equalTo(self.view);
    }];
}

#pragma getter
-(UITableView *)myTableView{
    if(!_myTableView){
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
    }
    return _myTableView;
}
-(FEWorkEValueDetailHeadView *)headView{
    if (!_headView) {
        _headView =[[FEWorkEValueDetailHeadView alloc]init];
        [_headView setLocalDelegate:self];
    }
    return _headView;
}

#pragma mark --tableViewDelegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *indexArr =self.titleArr.firstObject;
    return indexArr.count +1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIndetify =@"cellIndentify";
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if (cell ==nil) {
       FEWorkEvalueCell *evalueCell =[[FEWorkEvalueCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
        if (indexPath.row>0) {
         
            NSArray *indexArr =self.titleArr.firstObject;
            NSDictionary *dic =[NSDictionary dictionaryWithDictionary:indexArr[indexPath.row-1]];
            [evalueCell setleftTopText:[NSString stringWithFormat:@"%@",dic[@"type"]] leftBottomText:[NSString stringWithFormat:@"%@",dic[@"desc"]] rightTopText:[NSString stringWithFormat:@"+%@",dic[@"num"]] rightBottomText: [NSString stringWithFormat:@"%@",dic[@"ctime"]]];
        }
         cell =evalueCell;
    }
    if (indexPath.row ==0) {
       cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
       [cell.textLabel setText:@"积分收益详情"];
        [cell.textLabel setFont:Demon_15_Font];
        [cell.textLabel setTextColor:UIColorFromHex(0xA7A7A7)];
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
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footView =[[UIView alloc]init];
    UIButton *tapBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [tapBtn setImage:[UIImage imageNamed:@"wkm_Tap"] forState:UIControlStateNormal];
    [tapBtn bk_addEventHandler:^(id sender) {
        FECycleViewController *rideVC =[[FECycleViewController alloc]init];
        [self.navigationController pushViewController:rideVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [footView addSubview:tapBtn];
    [tapBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(footView);
        make.width.mas_equalTo(170);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(20);
    }];
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 140;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        return 44;
    }
    return 88;
}
-(void)requestEvalueDetail{
    WEAKSELF;
    NSMutableDictionary *parameter =[NSMutableDictionary dictionary];
    [[NetWorkManger manager]postDataWithUrl:BASE_URLWith(EletricityListHttp) parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
          NSDictionary *data = (NSDictionary *)responseObject;
           if ([data[@"code"] intValue] == KSuccessCode) {
              MTSVPDismiss;
               weakSelf.titleArr =[NSArray arrayWithObject:data[@"data"][@"list"]] ;
            [weakSelf.myTableView reloadData];
          } else if ([data[@"code"] intValue] != KTokenFailCode){
              dispatch_async(dispatch_get_main_queue(), ^{
                  MTSVPShowInfoText(data[@"msg"]);
              });
          }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
#pragma mark -FEWorkEValueDetailHeadViewDelegate
-(void)goDuiFUAction{
    FEWorkEValueShopVC *shopVC =[[FEWorkEValueShopVC alloc]init];
    [self.navigationController pushViewController:shopVC animated:YES];
}
@end
