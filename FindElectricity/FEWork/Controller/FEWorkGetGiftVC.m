//
//  FEWorkGetGiftVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/3.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkGetGiftVC.h"
#import "FEWorkGetGiftCell.h"
@interface FEWorkGetGiftVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *myTableView;
@property (nonatomic, strong)UIView *horizonView;
@property (nonatomic, strong)UILabel *countLbl;
@property (nonatomic, strong)UILabel *showCountLbl;
@property (nonatomic, strong)UILabel *pageLbl;
@property (nonatomic, strong)UILabel *showPageLbl;
@property (nonatomic, strong)NSArray *list;
@end

@implementation FEWorkGetGiftVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestRecord];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark 添加视图
- (void)addView{
    self.title =@"兑换记录";
    [self.view addSubview:self.myTableView];
    [self makeUpConstraint];
}

#pragma mark 约束适配
- (void)makeUpConstraint{
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
    }];
}

#pragma mark getter
- (UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
    }
    return _myTableView;
}
- (UIView *)horizonView{
    if (!_horizonView) {
        _horizonView =[[UIView alloc]init];
        [_horizonView setBackgroundColor:UIColorFromHex(0xE8E8E8)];
    }
    return _horizonView;
}
- (UILabel *)countLbl{
    if (!_countLbl) {
        _countLbl =[[UILabel alloc]init];
        [_countLbl setText:@"累计兑换抽奖机会"];
         [_countLbl setFont:Demon_15_Font];
         [_countLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _countLbl;
}
- (UILabel *)showCountLbl{
    if (!_showCountLbl) {
        _showCountLbl =[[UILabel alloc]init];
        [_showCountLbl setFont:Demon_14_Font];
        [_showCountLbl setText:@"6次"];
        [_showCountLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _showCountLbl;
}
- (UILabel *)pageLbl{
    if(!_pageLbl){
        _pageLbl =[[UILabel alloc]init];
        [_pageLbl setText:@"累计兑换礼品卡"];
        [_pageLbl setFont:Demon_14_Font];
        [_pageLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _pageLbl;
}
- (UILabel *)showPageLbl{
    if (!_showPageLbl) {
        _showPageLbl =[[UILabel alloc]init];
        [_showPageLbl setText:@"1张"];
        [_showPageLbl setFont:Demon_15_Font];
        [_showPageLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _showPageLbl;
}
#pragma mark --tableViewDelegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.list.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIndetify =@"cellIndentify";
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if (cell ==nil) {
        FEWorkGetGiftCell *giftCell =[[FEWorkGetGiftCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
        if(indexPath.row > 0){
            NSDictionary *dic =self.list[indexPath.row-1];
            [giftCell setCount:dic[@"name"] rightTopText:dic[@"num"] rightBottomText:dic[@"ctime"]];
        }
        cell =giftCell;
    }
    if (indexPath.row ==0) {
        cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
        [cell.textLabel setText:@"电量值兑换记录"];
        [cell.textLabel setFont:Demon_15_Font];
        [cell.textLabel setTextColor:UIColorFromHex(0xA7A7A7)];
    }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView =[[UIView alloc]init];
    [headView setBackgroundColor:[UIColor whiteColor]];
    [headView addSubview:self.horizonView];
    [headView addSubview:self.countLbl];
    [headView addSubview:self.showPageLbl];
    [headView addSubview:self.pageLbl];
    [headView addSubview:self.showCountLbl];
    [self.horizonView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(headView);
        make.width.mas_equalTo(1);
        make.top.mas_equalTo(25);
        make.bottom.mas_equalTo(-25);
    }];
    [self.showCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
           make.right.mas_equalTo(self.horizonView.mas_left).offset(-33);
           make.width.mas_equalTo(120);
           make.top.mas_equalTo(24);
       }];
    [self.countLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.horizonView.mas_left).offset(-33);
        make.width.mas_equalTo(120);
        make.top.mas_equalTo(self.showCountLbl.mas_bottom).offset(11);
    }];
    [self.showPageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.horizonView.mas_right).offset(33);
        make.width.mas_equalTo(120);
        make.top.mas_equalTo(24);
    }];
    [self.pageLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.horizonView.mas_right).offset(33);
        make.width.mas_equalTo(120);
        make.top.mas_equalTo(self.showPageLbl.mas_bottom).offset(11);
    }];
    UIView *shadowView =[[UIView alloc]init];
    [headView addSubview:shadowView];
    [shadowView setBackgroundColor:UIColorFromHex(0xf3f6f9)];
    [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(headView);
        make.right.mas_equalTo(headView);
        make.bottom.mas_equalTo(headView);
        make.height.mas_equalTo(10);
    }];
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 110;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row ==0) {
        return 44;
    }
    return 88;
}
-(void)requestRecord{
    WEAKSELF;
    NSMutableDictionary *dic =[NSMutableDictionary dictionary];
    [[NetWorkManger manager]postDataWithUrl:BASE_URLWith(ExhcangegoodlogHttp) parameters:dic needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
         NSDictionary *data = (NSDictionary *)responseObject;
         if ([data[@"code"] intValue] == KSuccessCode) {
                  MTSVPDismiss;
             [weakSelf.showCountLbl setText:[NSString stringWithFormat:@"%@次",data[@"data"][@"lottery_number"]]];
             [weakSelf.showPageLbl setText:[NSString stringWithFormat:@"%@张",data[@"data"][@"goods_card"]]];
        
             weakSelf.list =data[@"data"][@"list"];
             [weakSelf.myTableView reloadData];
              }else if ([data[@"code"] intValue] != KTokenFailCode){
                  dispatch_async(dispatch_get_main_queue(), ^{
                      MTSVPShowInfoText(data[@"msg"]);
                  });
              }
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
