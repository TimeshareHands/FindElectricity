//
//  FEWorkTurnTableVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkTurnTableVC.h"
#import "FEWorkGetPrizeContentCell.h"
#import "FETWorkGetPrizeIntroduceCell.h"
#import "FEGetPrizeRosterCell.h"
#import "FETotalGetPrizeRecordCell.h"
#import "FEWorkGetGiftAlertView.h"
#import "FEWorkGetGiftShareAlertView.h"
#import "FEGetPrizeShareFriendVC.h"
#import "FEWorkEValueShopVC.h"
#import "FEWorkReceiveAddressAlert.h"
#import "FEAddressViewController.h"
#import "FELauchShow.h"
#import "FEWorkTurnTableGoBikeAlert.h"
#import "FECycleViewController.h"
@interface FEWorkTurnTableVC ()<CAAnimationDelegate,UITableViewDelegate,UITableViewDataSource,FETWorkGetPrizeIntroduceCellDelegate,FEWorkGetGiftAlertViewDelegate,FEWorkReceiveAddressAlertDelegate,FEWorkGetPrizeContentCellDelegate,FEWorkTurnTableGoBikeAlertDelegate>
@property(nonatomic, strong)UIImageView *bgImageView;
@property(nonatomic, strong)UIImageView *btnImageView;
@property(nonatomic, assign)NSInteger circleAngle;
@property(nonatomic, assign)BOOL isAnimation;
@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)UIButton *backBtn;
@property(nonatomic, strong)UIImageView *centerImage;
@property(nonatomic, strong)UIButton *wxBDBtn;
@property(nonatomic, strong)NSString *lotterNum;
@property(nonatomic, strong)NSString *elect_val;
@property(nonatomic, strong)NSArray *receive_good_list;//获奖名单
@property(nonatomic, strong)NSArray *prize_arr_winlist;//已集齐的卡
@property(nonatomic, strong)NSArray *prize_arr;//转盘数据
@property(nonatomic, strong)NSArray *self_receive_good_list;//我的获奖名单
@property(nonatomic, copy)NSString *goodId;//商品号
@property(nonatomic, copy)NSString *numInteger;//积分
@property(nonatomic, strong)FELauchShow *lauchShow;
@end

@implementation FEWorkTurnTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
    [self requestDayDaySong];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [NetWorkManger manager].senderVC =self;
    [self requestCurretData];
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma  mark  添加视图
- (void)addView{
    [self.view setBackgroundColor:UIColorFromHex(0x8542E5)];
    [self.view addSubview:self.myTableView];
    [self.view addSubview:self.backBtn];
    [self.view addSubview:self.centerImage];
//    [self.view addSubview:self.wxBDBtn];
    [self makeUpconstraint];
}

#pragma  mark 约束适配
- (void)makeUpconstraint{
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(self.centerImage.mas_bottom);
        make.bottom.mas_equalTo(self.view);
    }];
    [self.backBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.width.mas_equalTo(53);
        make.height.mas_equalTo(46);
        make.top.mas_equalTo(49);
    }];
    [self.centerImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.centerY.mas_equalTo(self.backBtn);
        make.width.mas_equalTo(60);
        make.height.mas_equalTo(39);
    }];
//    [self.wxBDBtn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-32);
//        make.width.mas_equalTo(100);
//        make.height.mas_equalTo(30);
//        make.centerY.mas_equalTo(self.backBtn);
//    }];
}

#pragma mark getter
-(UIButton *)backBtn{
    if (!_backBtn) {
        _backBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_backBtn setImage:[UIImage imageNamed:@"map_back"] forState:UIControlStateNormal];
        [_backBtn bk_addEventHandler:^(id sender) {
            [self.navigationController popViewControllerAnimated:YES];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _backBtn;
}
-(UIImageView *)centerImage{
    if (!_centerImage) {
        _centerImage =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wkc_everydayChoujiang"]];
    }
    return _centerImage;
}
//-(UIButton *)wxBDBtn{
//    if (!_wxBDBtn) {
//        _wxBDBtn =[UIButton buttonWithType:UIButtonTypeCustom];
//        [_wxBDBtn setTitle:@"绑定微信" forState:UIControlStateNormal];
//        [_wxBDBtn.titleLabel setFont:Demon_15_Font];
//        [_wxBDBtn.layer setCornerRadius:12];
//    }
//    return _wxBDBtn;
//}
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
        [_myTableView setBackgroundColor:UIColorFromHex(0x8542E5)];
    }
    return _myTableView;
}

-(UIImageView *)bgImageView{
    if (!_bgImageView) {
        _bgImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 20, 300,300)];
//        [_bgImageView setImage:[UIImage imageNamed:@"wkc_bigRotaryTable"]];
        _bgImageView.center =CGPointMake(self.view.center.x, 160);
     
        [_bgImageView setUserInteractionEnabled:YES];
    }
    return _bgImageView;
}

-(UIImageView *)btnImageView{
    if (!_btnImageView) {
        _btnImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 60, 60)];
        _btnImageView.image = [UIImage imageNamed:@"wkc_choujiangAction"];
        _btnImageView.center =_bgImageView.center;
         _btnImageView.userInteractionEnabled = YES;
       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(requestChouJiang)];
       [_btnImageView addGestureRecognizer:tap];
    }
    return _btnImageView;
}
#pragma mark -tableViewdegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.prize_arr_winlist.count+2;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
       FETWorkGetPrizeIntroduceCell *introduceCell =[[FETWorkGetPrizeIntroduceCell alloc]init];
        [introduceCell.layer setCornerRadius:10];
        [introduceCell setLocalDelegate:self];
        [introduceCell setChoujiangCount:self.lotterNum myEvalue:self.elect_val];
        return introduceCell;
    }else if(indexPath.section ==7){
        FEGetPrizeRosterCell *rosterCell =[[FEGetPrizeRosterCell alloc]init];
        [rosterCell.layer setCornerRadius:10];
        rosterCell.listArr =self.receive_good_list;
        return rosterCell;
    }else if(indexPath.section ==8){
        FETotalGetPrizeRecordCell *rosterCell =[[FETotalGetPrizeRecordCell alloc]init];
        [rosterCell.layer setCornerRadius:10];
        rosterCell.listArr =self.self_receive_good_list;
        return rosterCell;
    }else{
        FEWorkGetPrizeContentCell *contentCell =[[FEWorkGetPrizeContentCell alloc]init];
        NSDictionary *contentDic =self.prize_arr_winlist[indexPath.section-1];
        [contentCell setUnitText:contentDic[@"unit"] num:contentDic[@"num"] title:contentDic[@"title"] winNum:contentDic[@"winningnum"] pic:contentDic[@"pic"] goodsId:contentDic[@"id"]];
        [contentCell setLocalDelegate:self];
        [contentCell.layer setCornerRadius:10];
        return contentCell;
        
    }
  
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView =[[UIView alloc]init];
    if (section ==0) {
        [headView addSubview:self.bgImageView];
        //添加GO按钮图片
        UIImageView *imageBg =[[UIImageView alloc]init];
        [imageBg setImage:[UIImage imageNamed:@"wkc_bigRotaryTable"]];
        imageBg.layer.transform =  CATransform3DMakeRotation(M_PI/8.0, 0, 0, 1);
        [self.bgImageView addSubview:imageBg];
        [imageBg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.bgImageView);
            make.right.mas_equalTo(self.bgImageView);
            make.top.mas_equalTo(self.bgImageView);
            make.bottom.mas_equalTo(self.bgImageView);
        }];
        [headView addSubview:self.btnImageView];
        
        //添加文字
        for (int i = 0; i < 8; i ++) {
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0,M_PI * CGRectGetHeight(self.bgImageView.frame)/8,CGRectGetHeight(self.bgImageView.frame)*3/3.8)];
            label.layer.anchorPoint = CGPointMake(0.5, 1.0);
            label.center = CGPointMake(CGRectGetHeight(self.bgImageView.frame)/2, CGRectGetHeight(self.bgImageView.frame)/2);
            [label setTextColor:UIColorFromHex(0xDB8F5F)];
            label.textAlignment = NSTextAlignmentCenter;
            label.font = [UIFont boldSystemFontOfSize:14];
            CGFloat angle = M_PI*2/8 * i;
            label.transform = CGAffineTransformMakeRotation(angle);
            [self.bgImageView addSubview:label];
            UIImageView *imageView =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0,M_PI/2 * CGRectGetHeight(self.bgImageView.frame)/8,CGRectGetHeight(self.bgImageView.frame)*3/9)];
            UIImageView *centerImg =[[UIImageView alloc]init];
            [imageView addSubview:centerImg];
            if (self.prize_arr.count>0) {
                NSDictionary *pizDic = self.prize_arr[i];
                 label.text = [NSString stringWithFormat:@"%@", pizDic[@"prize"]];
                 [centerImg sd_setImageWithURL:[NSURL URLWithString:pizDic[@"pic"]]];
            }
            [centerImg mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerX.mas_equalTo(imageView);
              make.width.mas_equalTo(45);
              make.height.mas_equalTo(45);
              make.top.mas_equalTo(10);
            }];
            imageView.layer.anchorPoint = CGPointMake(0.5, 1);
            imageView.center = CGPointMake(CGRectGetHeight(self.bgImageView.frame)/2, CGRectGetHeight(self.bgImageView.frame)/2);
            imageView.transform = CGAffineTransformMakeRotation(angle);
            
            [self.bgImageView addSubview:imageView];
          
//             [imageView setBackgroundColor:[UIColor redColor]];
        
        }
    }
    return headView;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView =[[UIView alloc]init];
    if (section ==8) {
        UILabel *bottomLabel =[[UILabel alloc]init];
        [bottomLabel setText:@"参与抽奖活动，视为同意活动规则，本活动解释权归本公司所有"];
        [bottomLabel setTextAlignment:NSTextAlignmentCenter];
        [bottomLabel setFont:Demon_13_Font];
        [bottomLabel setTextColor:[UIColor whiteColor]];
        [footView addSubview:bottomLabel];
        [bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(10);
            make.right.mas_equalTo(-10);
            make.top.mas_equalTo(10);
        }];
    }
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        return 220;
    }else if(indexPath.section ==7){
        return 160;
    }else if(indexPath.section ==8){
        return 120;
    }
    return 280;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
         return 340;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section ==8) {
        return 20;
    }
    return 0.1;
}
- (FELauchShow *)lauchShow {
    if (!_lauchShow) {
        _lauchShow = [FELauchShow createView];
        _lauchShow.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        WEAKSELF;
        _lauchShow.didClick = ^(FELauchShow * _Nonnull lau, NSInteger tag) {
            [weakSelf.lauchShow hidden];
            if (tag==1) {
                //去抽奖
                [weakSelf requestChouJiang];
            }
        };
    }
    return _lauchShow;
}
#pragma mark 点击Go按钮
-(void)btnClick{
    
    NSLog(@"点击Go");
    //判断是否正在转
    if (_isAnimation) {
        return;
    }
    _isAnimation = YES;
//    5 电动车
//    6 手机卡
//    7 神秘礼物卡
//    8 使用油卡
//    9 洗洁精卡
//    10 卫生纸卡
//    11 积分奖励
//    12 谢谢参与
    //控制概率[5,12]
    NSInteger lotteryPro = self.goodId.integerValue;
    if (self.numInteger.integerValue>0) {//积分大于0奖励
        lotteryPro =11;
    }
    //设置转圈的圈数
    NSInteger circleNum = 6;
    if (lotteryPro ==5) {//电动车
        _circleAngle = 0;
    }else if(lotteryPro ==6){//手机卡
        _circleAngle = 315;
    }else if (lotteryPro ==7){//零食大礼包
         _circleAngle = 270;
    }else if (lotteryPro ==8){//洗衣液
         _circleAngle = 225;
    }else if (lotteryPro ==9){//垃圾袋
        _circleAngle = 180;
    }else if (lotteryPro ==10){//卫生纸卡
        _circleAngle = 135;
    }else if (lotteryPro ==11){//积分奖励
        _circleAngle = 90;
    }else if (lotteryPro ==12){//谢谢参与
        _circleAngle = 45;
    }
    
    CGFloat perAngle = M_PI/(180.0);
    
    NSLog(@"turnAngle = %ld",(long)_circleAngle);
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:_circleAngle * perAngle + 360 * perAngle * circleNum];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    
    
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode =kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [_bgImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}
#pragma mark 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    _isAnimation =NO;
    NSLog(@"动画停止");
    __block NSString *title;
    UIImage  *topImage =[UIImage imageNamed:@"wkc_ChoujiangGet"];
  
    [self.prize_arr enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSDictionary *prizeDic =obj;
        NSString *prizeId =[NSString stringWithFormat:@"%@",prizeDic[@"id"]];
        if(self.numInteger.integerValue>0){
            title = [NSString stringWithFormat:@"积分奖励%@",self.numInteger];
        }
        if ([prizeId isEqualToString:self.goodId]) {
            title =[NSString stringWithFormat:@"抽中%@",prizeDic[@"prize"]];
        }
        
    }];
    FEWorkGetGiftAlertView *gitAlertVIew =[[FEWorkGetGiftAlertView alloc]init];
    [gitAlertVIew setImage:topImage andTopText:title];
    [gitAlertVIew setLocalDelegate:self];
    [gitAlertVIew show];
    [self requestCurretData];
//    if (_circleAngle == 0) {
//        title = @"抽中电动车卡一张";
//    }else if (_circleAngle == 45){
//
//    }else if (_circleAngle == 90){
//        topImage =[UIImage imageNamed:@"wkc_smile"];
//        title = @"谢谢参与!";
//    }else if (_circleAngle == 135){
//        title = @"抽中神秘礼物卡一张";
//    }else if (_circleAngle == 180){
//        title = @"抽中电动车卡一张";
//    }else if (_circleAngle == 225){
//        title = @"抽中手机卡一张";
//    }else if (_circleAngle == 270){
//        title = @"抽中洗洁精卡一张";
//    }else if (_circleAngle == 315){
//        title = @"抽中食用油卡一张";
//    }
    
   
}
#pragma mark -FEWorkGetGiftAlertViewDelegate
-(void)continueChouJiang{
    [self requestChouJiang];
}

#pragma mark -FETWorkGetPrizeIntroduceCellDelegate

-(void)getChoujiangchange{
    FEGetPrizeShareFriendVC *shareVC =[[FEGetPrizeShareFriendVC alloc]init];
    [self.navigationController pushViewController:shareVC animated:YES];
}

-(void)duihuanEvalue{
    FEWorkEValueShopVC *shopVC =[[FEWorkEValueShopVC alloc]init];
    [self.navigationController pushViewController:shopVC animated:YES];
}


#pragma mark -抽奖页面当前数据
-(void)requestCurretData{
    NSMutableDictionary *parameter =[NSMutableDictionary dictionary];
    [[NetWorkManger manager]postDataWithUrl:BASE_URLWith(LuckydrawdateHttp) parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
       if ([data[@"code"] intValue] == KSuccessCode) {
                 MTSVPDismiss;
           self.lotterNum =data[@"data"][@"lottery_number"];
           self.elect_val =data[@"data"][@"elect_val"];
           self.receive_good_list =data[@"data"][@"receive_good_list"];
           self.prize_arr =data[@"data"][@"prize_arr"];
           self.prize_arr_winlist =data[@"data"][@"prize_arr_win"];
           self.self_receive_good_list =data[@"data"][@"self_receive_good_list"];
           [self.myTableView reloadData];
          
         }else if ([data[@"code"] intValue] != KTokenFailCode){
             dispatch_async(dispatch_get_main_queue(), ^{
                 MTSVPShowInfoText(data[@"msg"]);
             });
         }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark -抽奖
-(void)requestChouJiang{
    WEAKSELF;
    NSMutableDictionary *parameter =[NSMutableDictionary dictionary];
       [[NetWorkManger manager]postDataWithUrl:BASE_URLWith(LuckyDrawHttp) parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
           NSDictionary *data = (NSDictionary *)responseObject;
          if ([data[@"code"] intValue] == KSuccessCode) {
                    MTSVPDismiss;
              weakSelf.goodId =[NSString stringWithFormat:@"%@",data[@"data"][@"yes"]];
              weakSelf.numInteger =[NSString stringWithFormat:@"%@",data[@"data"][@"num"]];
              [weakSelf btnClick];
            
            }else {
                FEWorkTurnTableGoBikeAlert *gobikeAlert =[[FEWorkTurnTableGoBikeAlert alloc]init];
                [gobikeAlert setLocalDelegate:self];
                [gobikeAlert show];
//                MTSVPShowInfoText(data[@"msg"]);
            }
       } failure:^(NSError * _Nonnull error) {
           
       }];
}
#pragma mark -FEWorkTurnTableGoBikeAlertDelegate
-(void)goBike{
    FECycleViewController *rideVC =[[FECycleViewController alloc]init];
    [self.navigationController pushViewController:rideVC animated:YES];
}
#pragma mark -领取
-(void)requestlingqu:(NSString *)goodsId{
    NSMutableDictionary *parameter =[NSMutableDictionary dictionary];
    [parameter setValue:[FEUserOperation manager].userModel.address forKey:@"address"];
    [parameter setValue:[FEUserOperation manager].userModel.contacts forKey:@"contacts"];
    [parameter setValue:[FEUserOperation manager].userModel.telephone forKey:@"telephone"];
    [parameter setValue:goodsId forKey:@"id"];
    WEAKSELF;
       [[NetWorkManger manager]postDataWithUrl:BASE_URLWith(ReceiveGoodHttp) parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
           NSDictionary *data = (NSDictionary *)responseObject;
          if ([data[@"code"] intValue] == KSuccessCode) {
                    MTSVPDismiss;
               MTSVPShowInfoText(@"领取成功");
              [weakSelf requestCurretData];
            }else if ([data[@"code"] intValue] != KTokenFailCode){
        MTSVPShowInfoText(data[@"msg"]);
    }
       } failure:^(NSError * _Nonnull error) {
           
       }];
}
#pragma mark -天天送
-(void)requestDayDaySong{
    [[self lauchShow] getShowData];
}
#pragma mark -FEWorkGetPrizeContentCellDelegate
-(void)confirmToLinqu:(NSString *)goodsId{
    FEWorkReceiveAddressAlert *gitAlertVIew =[[FEWorkReceiveAddressAlert alloc]init];
    [gitAlertVIew setId:goodsId];
    [gitAlertVIew setLocalDelegate:self];
    [gitAlertVIew show];
}
#pragma mark -FEWorkReceiveAddressAlertDelegate
-(void)confirmlinqu:(NSString *)goodsId{
    [self requestlingqu:goodsId];
}
-(void)gotoAddress{
    FEAddressViewController *addressVC =[[FEAddressViewController alloc]init];
    [self.navigationController pushViewController:addressVC animated:YES];
}
@end
