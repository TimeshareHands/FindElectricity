//
//  FEWorkTurnTableVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkTurnTableVC.h"

@interface FEWorkTurnTableVC ()<CAAnimationDelegate>
@property(nonatomic, strong)UIImageView *bgImageView;
@property(nonatomic, strong)UIImageView *btnImageView;
@property(nonatomic, assign)NSInteger circleAngle;
@property(nonatomic, assign)BOOL isAnimation;
@end

@implementation FEWorkTurnTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}
#pragma  mark  添加视图
- (void)addView{
    [self.view addSubview:self.bgImageView];
    [self.view addSubview:self.btnImageView];
    [self makeUpconstriant];
}
#pragma  mark 约束适配
- (void)makeUpconstriant{
    
}
#pragma mark getter

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
