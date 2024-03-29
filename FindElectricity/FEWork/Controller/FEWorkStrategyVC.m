//
//  FEWorkStrategyVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkStrategyVC.h"
#import "FEGetPrizeShareFriendVC.h"
@interface FEWorkStrategyVC ()

@end

@implementation FEWorkStrategyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
    if([self.responseModel.is_read isEqualToString:@"0"]){
        [self requestReadStrategy];
    }
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)initView{
    UIView *bgView =[[UIView alloc]init];
    [bgView setBackgroundColor:UIColorFromHex(0xE26A41)];
    [self.view addSubview:bgView];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    UIButton *backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn.titleLabel setFont:Demon_11_Font];
    [backBtn setTitleColor:UIColorFromHex(0xE37549) forState:UIControlStateNormal];
    [backBtn setBackgroundColor:UIColorFromHex(0xFCEBA8)];
    [backBtn.layer setCornerRadius:16];
    [self.view addSubview:backBtn];
    [backBtn bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_LY(20));
        make.top.mas_equalTo(HEIGHT_LY(35));
        make.width.mas_equalTo(WIDTH_LY(46));
        make.height.mas_equalTo(HEIGHT_LY(40));
    }];
    UILabel *topLabel =[[UILabel alloc]init];
    [topLabel setText:@"电量值攻略"];
    [topLabel setTextColor:UIColorFromHex(0xFCEBA8)];
    [topLabel setFont:Demon_32_Font];
    [self.view addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(backBtn.mas_bottom).offset(HEIGHT_LY(10));
    }];
    UIView *whiteView =[[UIView alloc]init];
    [whiteView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_LY(20));
        make.right.mas_equalTo(WIDTH_LY(-20));
        make.bottom.mas_equalTo(HEIGHT_LY(-11));
        make.top.mas_equalTo(topLabel.mas_bottom).offset(HEIGHT_LY(15));
    }];
    UILabel *lb1 =[[UILabel alloc]init];
    [lb1 setText:@"1.电量值是什么？"];
    [lb1 setFont:Demon_16_Font];
    [lb1 setTextColor:UIColorFromHex(0xE37549)];
    [whiteView addSubview:lb1];
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_LY(20));
        make.top.mas_equalTo(HEIGHT_LY(21));
    }];
    UILabel *lb2 =[[UILabel alloc]init];
    [lb2 setText:@"电量值是找电app的财富象征，电量值越多，代表财富越多。"];
    [lb2 setFont:Demon_13_Font];
    [lb2 setNumberOfLines:0];
    [whiteView addSubview:lb2];

    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_LY(20));
        make.top.mas_equalTo(lb1.mas_bottom).offset(HEIGHT_LY(6));
        make.right.mas_equalTo(WIDTH_LY(-20));
    }];
    UILabel *lb3 =[[UILabel alloc]init];
    [lb3 setText:@"2.电量值可以做什么？"];
    [lb3 setTextColor:UIColorFromHex(0xE37549)];
    [lb3 setFont:Demon_16_Font];
    [whiteView addSubview:lb3];
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_LY(20));
        make.top.mas_equalTo(lb2.mas_bottom).offset(HEIGHT_LY(15));
    }];
    UILabel *lb4 =[[UILabel alloc]init];
    [lb4 setText:@"可以兑换抽奖卡或者抽奖机会，当您积累一定量电量值之后，可以去商城里兑换。"];
    [lb4 setFont:Demon_13_Font];
    [lb4 setNumberOfLines:0];
    [whiteView addSubview:lb4];
    [lb4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_LY(20));
        make.top.mas_equalTo(lb3.mas_bottom).offset(HEIGHT_LY(6));
        make.right.mas_equalTo(WIDTH_LY(-20));
    }];
    
    UILabel *lb5 =[[UILabel alloc]init];
    [lb5 setText:@"3.如何赚电量值？"];
    [lb5 setTextColor:UIColorFromHex(0xE37549)];
    [lb5 setFont:Demon_16_Font];
    [whiteView addSubview:lb5];
    [lb5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_LY(20));
        make.top.mas_equalTo(lb4.mas_bottom).offset(HEIGHT_LY(15));
    }];
    UILabel *lb6 =[[UILabel alloc]init];
    [lb6 setText:@"在找电APP中，可以通过很多方法赚取电量值，坚持就一定能够获得丰厚的回报\n1.可以通过每天坚持签到，获得电量值奖励，连续签到奖励会加倍，一定要坚持哦，一旦中断就要从头开始了；\n2.可以通过骑行获得电量值，骑行越长，获得的电量值越多；\n3.现在您在阅读电量值攻略也可以获得电量值的，不过只能获得一次哦；\n4.还有不定期限时做任务送电量值活动，好好把握哦。"];
    [lb6 setFont:Demon_13_Font];
    [lb6 setNumberOfLines:0];
    [whiteView addSubview:lb6];
    [lb6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_LY(20));
        make.top.mas_equalTo(lb5.mas_bottom).offset(HEIGHT_LY(6));
        make.right.mas_equalTo(WIDTH_LY(-20));
    }];
    
    UILabel *lb7 =[[UILabel alloc]init];
    [lb7 setText:@"4.如何获得抽奖机会？"];
    [lb7 setTextColor:UIColorFromHex(0xE37549)];
    [lb7 setFont:Demon_16_Font];
    [whiteView addSubview:lb7];
    [lb7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_LY(20));
        make.top.mas_equalTo(lb6.mas_bottom).offset(HEIGHT_LY(15));
    }];
    UILabel *lb8 =[[UILabel alloc]init];
       [lb8 setText:@"可以通过电量值兑换抽奖机会，或者邀请好友下载注册找电app,即可获得10次抽奖机会，邀请成功的人越多，抽奖机会越多。"];
       [lb8 setFont:Demon_13_Font];
       [lb8 setNumberOfLines:0];
       [whiteView addSubview:lb8];
       [lb8 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(WIDTH_LY(20));
           make.top.mas_equalTo(lb7.mas_bottom).offset(HEIGHT_LY(6));
            make.right.mas_equalTo(WIDTH_LY(-20));
       }];
    UIButton *bottomBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setImage:[UIImage imageNamed:@"wkc_choujiangTouch"] forState:UIControlStateNormal];
    [whiteView addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_LY(10));
        make.right.mas_equalTo(WIDTH_LY(-10));
        make.height.mas_equalTo(HEIGHT_LY(60));
        make.top.mas_equalTo(lb8.mas_bottom).offset(HEIGHT_LY(10));
    }];
    [bottomBtn bk_addEventHandler:^(id sender) {
        FEGetPrizeShareFriendVC *friendVC =[[FEGetPrizeShareFriendVC alloc]init];
        [self.navigationController pushViewController:friendVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
}
#pragma mark-获取电量值
-(void)requestReadStrategy{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];

    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(ReadStrategyHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
        if ([data[@"code"] intValue] == KSuccessCode) {
            dispatch_async(dispatch_get_main_queue(), ^{
               
            });
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
