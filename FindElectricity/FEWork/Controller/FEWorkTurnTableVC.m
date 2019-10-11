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
        [_btnImageView setImage:[UIImage imageNamed:@"wkc_bigRotaryTable"]];
    }
    return _bgImageView;
}
-(UIImageView *)btnImageView{
    if (!_btnImageView) {
        _btnImageView =[[UIImageView alloc]init];
        [_btnImageView setImage:[UIImage imageNamed:@"wkc_choujiangAction"]];
    }
    return _btnImageView;
}
@end
