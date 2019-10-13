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
@interface FEWorkTurnTableVC ()<CAAnimationDelegate,UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UIImageView *bgImageView;
@property(nonatomic, strong)UIImageView *btnImageView;
@property(nonatomic, assign)NSInteger circleAngle;
@property(nonatomic, assign)BOOL isAnimation;
@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)UIButton *backBtn;
@property(nonatomic, strong)UIImageView *centerImage;
@property(nonatomic, strong)UIButton *wxBDBtn;
@end

@implementation FEWorkTurnTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
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
    [self.view addSubview:self.wxBDBtn];
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
    [self.wxBDBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-32);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(30);
        make.centerY.mas_equalTo(self.backBtn);
    }];
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
-(UIButton *)wxBDBtn{
    if (!_wxBDBtn) {
        _wxBDBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_wxBDBtn setTitle:@"绑定微信" forState:UIControlStateNormal];
        [_wxBDBtn.titleLabel setFont:Demon_15_Font];
        [_wxBDBtn.layer setCornerRadius:12];
    }
    return _wxBDBtn;
}
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
        _bgImageView =[[UIImageView alloc]init];
        [_bgImageView setImage:[UIImage imageNamed:@"wkc_bigRotaryTable"]];
        _bgImageView.transform = CGAffineTransformMakeRotation(M_PI/8);
    }
    return _bgImageView;
}

-(UIImageView *)btnImageView{
    if (!_btnImageView) {
        _btnImageView =[[UIImageView alloc]init];
        [_btnImageView setImage:[UIImage imageNamed:@"wkc_choujiangAction"]];
        _btnImageView.userInteractionEnabled = YES;
       UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnClick)];
       [_btnImageView addGestureRecognizer:tap];
    }
    return _btnImageView;
}
#pragma mark -tableViewdegate &&tableViewDataSource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 9;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
       FETWorkGetPrizeIntroduceCell *introduceCell =[[FETWorkGetPrizeIntroduceCell alloc]init];
        [introduceCell.layer setCornerRadius:10];
        return introduceCell;
    }else if(indexPath.section ==7){
        FEGetPrizeRosterCell *rosterCell =[[FEGetPrizeRosterCell alloc]init];
        [rosterCell.layer setCornerRadius:10];
        return rosterCell;
    }else if(indexPath.section ==8){
        FETotalGetPrizeRecordCell *rosterCell =[[FETotalGetPrizeRecordCell alloc]init];
               [rosterCell.layer setCornerRadius:10];
               return rosterCell;
    }else{
        FEWorkGetPrizeContentCell *contentCell =[[FEWorkGetPrizeContentCell alloc]init];
        [contentCell.layer setCornerRadius:10];
        return contentCell;
        
    }
  
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView =[[UIView alloc]init];
    if (section ==0) {
        [headView addSubview:self.bgImageView];
          [headView addSubview:self.btnImageView];
          [self.bgImageView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.centerX.mas_equalTo(headView);
              make.top.mas_equalTo(20);
              make.width.mas_equalTo(260);
              make.height.mas_equalTo(260);
          }];
          [self.btnImageView mas_makeConstraints:^(MASConstraintMaker *make) {
              make.center.mas_equalTo(self.bgImageView);
              make.height.mas_equalTo(50);
              make.width.mas_equalTo(50);
          }];
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
         return 300;
    }
    return 10;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section ==8) {
        return 20;
    }
    return 0.1;
}
#pragma mark 点击Go按钮
-(void)btnClick{
    
    NSLog(@"点击Go");
    
    //判断是否正在转
    if (_isAnimation) {
        return;
    }
    _isAnimation = YES;

    //控制概率[0,80)
    NSInteger lotteryPro = arc4random()%80;
    //设置转圈的圈数
    NSInteger circleNum = 6;
    
    if (lotteryPro < 10) {
        _circleAngle = 0;
    }else if (lotteryPro < 20){
        _circleAngle = 45;
    }else if (lotteryPro < 30){
        _circleAngle = 90;
    }else if (lotteryPro < 40){
        _circleAngle = 135;
    }else if (lotteryPro < 50){
        _circleAngle = 180;
    }else if (lotteryPro < 60){
        _circleAngle = 225;
    }else if (lotteryPro < 70){
        _circleAngle = 270;
    }else if (lotteryPro < 80){
        _circleAngle = 315;
    }
    
    CGFloat perAngle = M_PI/180.0;
    
    NSLog(@"turnAngle = %ld",(long)_circleAngle);
    
    CABasicAnimation *rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:_circleAngle * perAngle + 360 * perAngle * circleNum];
    rotationAnimation.duration = 3.0f;
    rotationAnimation.cumulative = YES;
    rotationAnimation.delegate = self;
    
    
    //由快变慢
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
    rotationAnimation.fillMode=kCAFillModeForwards;
    rotationAnimation.removedOnCompletion = NO;
    [_bgImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
}
#pragma mark 动画结束
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    _isAnimation =NO;
    NSLog(@"动画停止");
    NSString *title;
    if (_circleAngle == 0) {
        title = @"谢谢参与!";
    }else if (_circleAngle == 45){
        title = @"恭喜你，获得特等奖！";
    }else if (_circleAngle == 90){
        title = @"谢谢参与!";
    }else if (_circleAngle == 135){
        title = @"恭喜你，获得三等奖！";
    }else if (_circleAngle == 180){
        title = @"谢谢参与!";
    }else if (_circleAngle == 225){
        title = @"恭喜你，获得二等奖！";
    }else if (_circleAngle == 270){
        title = @"谢谢参与!";
    }else if (_circleAngle == 315){
        title = @"恭喜你，获得一等奖！";
    }

}
@end
