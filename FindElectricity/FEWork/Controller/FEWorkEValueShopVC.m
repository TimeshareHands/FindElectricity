//
//  FEWorkEValueShopVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/3.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkEValueShopVC.h"
#import "FEWorkGiftCardCell.h"
#import "FEWorkEvalueGetPrizeChanceCell.h"
#import "FEWorkGetGiftVC.h"
@interface FEWorkEValueShopVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,strong)UITableView *myTableView;
@property (nonatomic, strong)UIView *horizonView;
@property (nonatomic, strong)UILabel *eValueLbl;
@property (nonatomic, strong)UILabel *getPrizeLbl;
@end

@implementation FEWorkEValueShopVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self rquestEvalueShop];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

#pragma mark 添加视图
- (void)addView{
    self.title =@"电量值商城";
    [self.view addSubview:self.myTableView];
    [self makeUpConstraint];
}

#pragma mark 约束适配
- (void)makeUpConstraint{
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark getter
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
    }
    return _myTableView;
}
-(UIView *)horizonView{
    if (!_horizonView) {
        _horizonView =[[UIView alloc]init];
        [_horizonView setBackgroundColor:UIColorFromHex(0xF3F6F9)];
    }
    return _horizonView;
}
-(UILabel *)eValueLbl{
    if (!_eValueLbl) {
        _eValueLbl =[[UILabel alloc]init];
        [_eValueLbl setFont:Demon_15_Font];
        [_eValueLbl setText:@"电量值 1510"];
        [_eValueLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _eValueLbl;
}
-(UILabel *)getPrizeLbl{
    if (!_getPrizeLbl) {
        _getPrizeLbl =[[UILabel alloc]init];
        [_getPrizeLbl setText:@"兑换记录"];
        [_getPrizeLbl setFont:Demon_15_Font];
        [_getPrizeLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _getPrizeLbl;
}
#pragma mark --tableViewDelegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section ==0){
        return 1;
    }else{
        return 6;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *kCellIndetify =@"cellIndentify";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:kCellIndetify];
   
    if (cell ==nil) {
        if (indexPath.section ==0) {
             cell =[[FEWorkEvalueGetPrizeChanceCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
        }else{
           FEWorkGiftCardCell *giftCell =[[FEWorkGiftCardCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
            if (indexPath.row ==0) {
                [giftCell settLeftImg:@"wkm_tolietPaperCard" topText:@"卫生纸卡1张" bottomText:@"5000电量值"];
            }else if(indexPath.row ==1){
                [giftCell settLeftImg:@"wkm_Edibleoil" topText:@"食用油卡1张" bottomText:@"6000电量值"];
            }else if(indexPath.row ==2){
                  [giftCell settLeftImg:@"wkm_DetergentCard" topText:@"洗洁精卡1张" bottomText:@"6000电量值"];
            }else if(indexPath.row ==3){
                  [giftCell settLeftImg:@"wkm_MobileCard" topText:@"手机卡1张" bottomText:@"175000电量值"];
            }else if(indexPath.row ==4){
                  [giftCell settLeftImg:@"wkm_moto" topText:@"电动车卡1张" bottomText:@"250000电量值"];
            }else if(indexPath.row ==5){
                   [giftCell settLeftImg:@"wkm_giftCard" topText:@"神秘礼物卡1张" bottomText:@"5000电量值"];
            }
            cell =giftCell;
        }
    }
    if (indexPath.section ==1) {
        if (indexPath.row ==0) {
            cell =[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
            [cell.textLabel setText:@"兑换礼品卡"];
            [cell.textLabel setFont:Demon_15_Font];
            [cell.textLabel setTextColor:UIColorFromHex(0xA7A7A7)];
        }
    }
     [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView =[[UIView alloc]init];
    if (section ==0) {
           [headView setBackgroundColor:[UIColor whiteColor]];
           [headView addSubview:self.horizonView];
           [headView addSubview:self.eValueLbl];
           [headView addSubview:self.getPrizeLbl];
            UIView *shadowView =[[UIView alloc]init];
             [headView addSubview:shadowView];
             [shadowView setBackgroundColor:UIColorFromHex(0xf3f6f9)];
             [shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
                 make.left.mas_equalTo(headView);
                 make.right.mas_equalTo(headView);
                 make.bottom.mas_equalTo(headView);
                 make.height.mas_equalTo(20);
             }];
           [self.horizonView mas_makeConstraints:^(MASConstraintMaker *make) {
                   make.centerX.mas_equalTo(headView);
                   make.width.mas_equalTo(1);
                   make.top.mas_equalTo(11);
                   make.bottom.mas_equalTo(shadowView.mas_top).offset(-11);
            }];
           [self.eValueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
               make.right.mas_equalTo(self.horizonView.mas_left).offset(-13);
               make.centerY.mas_equalTo(headView);
               make.width.mas_equalTo(SCREEN_WIDTH/2-11);
           }];
           [self.getPrizeLbl mas_makeConstraints:^(MASConstraintMaker *make) {
               make.left.mas_equalTo(self.horizonView.mas_right).offset(13);
               make.centerY.mas_equalTo(headView);
               make.width.mas_equalTo(SCREEN_WIDTH/2-11);
           }];
        [headView bk_whenTapped:^{
            FEWorkGetGiftVC *giftVC =[[FEWorkGetGiftVC alloc]init];
            [self.navigationController pushViewController:giftVC animated:YES];
        }];
          
    }
   
    return headView;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
         return 100;
    }
    return 0.1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==1) {
        if (indexPath.row ==0) {
            return 44;
        }
        return 88;
    }else{
        return 330;
    }
    
}
-(void)rquestEvalueShop{
    WEAKSELF;
    NSMutableDictionary *parameter =[NSMutableDictionary dictionary];
    [[NetWorkManger manager]postDataWithUrl:BASE_URLWith(ShopInfoHttp) parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
       if ([data[@"code"] intValue] == KSuccessCode) {
          MTSVPDismiss;
        [weakSelf.eValueLbl setText:[NSString stringWithFormat:@"电量值 %@",data[@"data"][@"myElectrictyVal"]]];
//        [weakSelf.myTableView reloadData];
      }else {
          MTSVPShowInfoText(data[@"msg"]);
      }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
@end
