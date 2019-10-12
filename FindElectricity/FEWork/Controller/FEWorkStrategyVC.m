//
//  FEWorkStrategyVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkStrategyVC.h"

@interface FEWorkStrategyVC ()

@end

@implementation FEWorkStrategyVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
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
    [backBtn.layer setCornerRadius:10.5];
    [self.view addSubview:backBtn];
    [backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(35);
        make.width.mas_equalTo(46);
        make.height.mas_equalTo(21);
    }];
    UILabel *topLabel =[[UILabel alloc]init];
    [topLabel setText:@"电量值攻略"];
    [topLabel setTextColor:UIColorFromHex(0xFCEBA8)];
    [topLabel setFont:Demon_38_Font];
    [self.view addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(backBtn.mas_bottom).offset(12);
    }];
    UIView *whiteView =[[UIView alloc]init];
    [whiteView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:whiteView];
    [whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.bottom.mas_equalTo(-11);
        make.top.mas_equalTo(topLabel.mas_bottom).offset(18);
    }];
    UILabel *lb1 =[[UILabel alloc]init];
    [lb1 setText:@"1.电量值是什么？"];
    [lb1 setFont:Demon_16_Font];
    [lb1 setTextColor:UIColorFromHex(0xE37549)];
    [whiteView addSubview:lb1];
    [lb1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(31);
    }];
    UILabel *lb2 =[[UILabel alloc]init];
    [lb2 setText:@"电量值是找电app的财富象征，电量值越多，代表财富越多。"];
    [lb2 setFont:Demon_13_Font];
    [lb2 setNumberOfLines:0];
    [whiteView addSubview:lb2];

    [lb2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(lb1.mas_bottom).offset(6);
        make.right.mas_equalTo(-20);
    }];
    UILabel *lb3 =[[UILabel alloc]init];
    [lb3 setText:@"2.电量值可以做什么？"];
    [lb3 setTextColor:UIColorFromHex(0xE37549)];
    [lb3 setFont:Demon_16_Font];
    [whiteView addSubview:lb3];
    [lb3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(lb2.mas_bottom).offset(28);
    }];
    UILabel *lb4 =[[UILabel alloc]init];
    [lb4 setText:@"可以兑换抽奖卡或者抽奖机会，当您积累一定量电量值之后，可以去商城里兑换。"];
    [lb4 setFont:Demon_13_Font];
    [lb4 setNumberOfLines:0];
    [whiteView addSubview:lb4];
    [lb4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(lb3.mas_bottom).offset(6);
        make.right.mas_equalTo(-20);
    }];
    
    UILabel *lb5 =[[UILabel alloc]init];
    [lb5 setText:@"3.如何赚电量值？"];
    [lb5 setTextColor:UIColorFromHex(0xE37549)];
    [lb5 setFont:Demon_16_Font];
    [whiteView addSubview:lb5];
    [lb5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(lb4.mas_bottom).offset(28);
    }];
    UILabel *lb6 =[[UILabel alloc]init];
    [lb6 setText:@"在找电APP中，可以通过很多方法赚取电量值，坚持就一定能够获得丰厚的回报\n1.可以通过每天坚持签到，获得电量值奖励，连续签到奖励会加倍，一定要坚持哦，一旦中断就要从头开始了；\n2.可以通过骑行获得电量值，骑行越长，获得的电量值越多；\n3.现在您在阅读电量值攻略也可以获得电量值的，不过只能获得一次哦；\n4.还有不定期限时做任务送电量值活动，好好把握哦。"];
    [lb6 setFont:Demon_13_Font];
    [lb6 setNumberOfLines:0];
    [whiteView addSubview:lb6];
    [lb6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(lb5.mas_bottom).offset(6);
        make.right.mas_equalTo(-20);
    }];
    
    UILabel *lb7 =[[UILabel alloc]init];
    [lb7 setText:@"4.如何获得抽奖机会？"];
    [lb7 setTextColor:UIColorFromHex(0xE37549)];
    [lb7 setFont:Demon_16_Font];
    [whiteView addSubview:lb7];
    [lb7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(lb6.mas_bottom).offset(28);
    }];
    UILabel *lb8 =[[UILabel alloc]init];
       [lb8 setText:@"可以通过电量值兑换抽奖机会，或者邀请好友下载注册找电app,即可获得10次抽奖机会，邀请成功的人越多，抽奖机会越多。"];
       [lb8 setFont:Demon_13_Font];
       [lb8 setNumberOfLines:0];
       [whiteView addSubview:lb8];
       [lb8 mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(20);
           make.top.mas_equalTo(lb7.mas_bottom).offset(6);
            make.right.mas_equalTo(-20);
       }];
    UIButton *bottomBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    [bottomBtn setImage:[UIImage imageNamed:@"wkc_choujiangTouch"] forState:UIControlStateNormal];
    [whiteView addSubview:bottomBtn];
    [bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(40);
        make.top.mas_equalTo(lb8.mas_bottom).offset(28);;
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
