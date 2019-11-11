//
//  FEWorkMainHeadView.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/2.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkMainHeadView.h"

@interface FEWorkMainHeadView()
@property (nonatomic, strong) UIView *topView;
@property (nonatomic, strong) UIImageView *headimg;
@property (nonatomic, strong) UILabel *infoLbl;
@property (nonatomic, strong) UIButton *shopBtn;
@property (nonatomic, strong) UIButton *topMenuBtn;//我的电量值一栏
@property (nonatomic, strong) UILabel *tm_HaveEvalueLbl;
@property (nonatomic, strong) UILabel *tm_ShowHaveEvalueLbl;
@property (nonatomic, strong) UILabel *tm_ShowGiveLbl;
@property (nonatomic, strong) UILabel *tm_GiveLbl;
@property (nonatomic, strong) UILabel *tm_ShowChouCountLbl;
@property (nonatomic, strong) UILabel *tm_chouCountLbl;
@property (nonatomic, strong) UIImageView *banerImg;
@property (nonatomic, strong) UIView *topGiveView;//签到领取电量一栏
@property (nonatomic, strong) UILabel *tG_leftTopLbl;
@property (nonatomic, strong) UILabel *tG_rightTopLbl;
@property (nonatomic, strong) UIButton *tG_coinImg1;
@property (nonatomic, strong) UILabel *tG_coinBottomLbl1;
@property (nonatomic, strong) UIButton *tG_coinImg2;
@property (nonatomic, strong) UILabel *tG_coinBottomLbl2;
@property (nonatomic, strong) UIButton *tG_coinImg3;
@property (nonatomic, strong) UILabel *tG_coinBottomLbl3;
@property (nonatomic, strong) UIButton *tG_coinImg4;
@property (nonatomic, strong) UILabel *tG_coinBottomLbl4;
@property (nonatomic, strong) UIButton *tG_coinImg5;
@property (nonatomic, strong) UILabel *tG_coinBottomLbl5;
@property (nonatomic, strong) UIButton *tG_coinImg6;
@property (nonatomic, strong) UILabel *tG_coinBottomLbl6;
@property (nonatomic, strong) UIButton *tG_coinImg7;
@property (nonatomic, strong) UILabel *tG_coinBottomLbl7;
@property (nonatomic, strong) UILabel *tG_coinLbl1;
@property (nonatomic, strong) UILabel *tG_coinLbl2;
@property (nonatomic, strong) UILabel *tG_coinLbl3;
@property (nonatomic, strong) UILabel *tG_coinLbl4;
@property (nonatomic, strong) UILabel *tG_coinLbl5;
@property (nonatomic, strong) UILabel *tG_coinLbl6;
@property (nonatomic, strong) UILabel *tG_coinLbl7;
@property (nonatomic, strong) UIView *bottomView;
@property (nonatomic, assign) NSInteger num;
@end

@implementation FEWorkMainHeadView

-(id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}

#pragma mark --添加视图
-(void)addView{
    
    [self addSubview:self.topView];
    [self addSubview:self.bottomView];
    [self.topView addSubview:self.headimg];
    [self.topView addSubview:self.infoLbl];
    [self.topView addSubview:self.shopBtn];
    [self addSubview:self.topMenuBtn];
    [self.topMenuBtn addSubview:self.tm_ShowHaveEvalueLbl];
    [self.topMenuBtn addSubview:self.tm_HaveEvalueLbl];
    [self.topMenuBtn addSubview:self.tm_ShowGiveLbl];
    [self.topMenuBtn addSubview:self.tm_GiveLbl];
    [self.topMenuBtn addSubview:self.tm_ShowChouCountLbl];
    [self.topMenuBtn addSubview:self.tm_chouCountLbl];
    
    [self addSubview:self.banerImg];
    [self addSubview:self.topGiveView];
    [self.topGiveView addSubview:self.tG_leftTopLbl];
    [self.topGiveView addSubview:self.tG_rightTopLbl];
    [self.topGiveView addSubview:self.tG_coinImg1];
    [self.topGiveView addSubview:self.tG_coinBottomLbl1];
    [self.topGiveView addSubview:self.tG_coinImg2];
    [self.topGiveView addSubview:self.tG_coinBottomLbl2];
    [self.topGiveView addSubview:self.tG_coinImg3];
    [self.topGiveView addSubview:self.tG_coinBottomLbl3];
    [self.topGiveView addSubview:self.tG_coinImg4];
    [self.topGiveView addSubview:self.tG_coinBottomLbl4];
    [self.topGiveView addSubview:self.tG_coinImg5];
    [self.topGiveView addSubview:self.tG_coinBottomLbl5];
    [self.topGiveView addSubview:self.tG_coinImg6];
    [self.topGiveView addSubview:self.tG_coinBottomLbl6];
    [self.topGiveView addSubview:self.tG_coinImg7];
    [self.topGiveView addSubview:self.tG_coinBottomLbl7];
    [self.topGiveView addSubview:self.tG_coinLbl1];
    [self.topGiveView addSubview:self.tG_coinLbl2];
    [self.topGiveView addSubview:self.tG_coinLbl3];
    [self.topGiveView addSubview:self.tG_coinLbl4];
    [self.topGiveView addSubview:self.tG_coinLbl5];
    [self.topGiveView addSubview:self.tG_coinLbl6];
    [self.topGiveView addSubview:self.tG_coinLbl7];
    [self makeUpconstriant];
}

#pragma mark --约束适配
-(void)makeUpconstriant{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(147);
        make.top.mas_equalTo(self);
    }];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.height.mas_equalTo(10);
        make.bottom.mas_equalTo(self);
    }];
    [self.headimg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(54);
        make.height.mas_equalTo(48);
        make.width.mas_equalTo(48);
    }];
    [self.infoLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.headimg.mas_right).offset(10);
        make.centerY.mas_equalTo(self.headimg);
    }];
    [self.shopBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.headimg);
        make.height.mas_equalTo(30);
        make.width.mas_equalTo(90);
    }];
    [self.topMenuBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(70);
        make.top.mas_equalTo(self.headimg.mas_bottom).offset(20);
    }];
    [self.tm_ShowHaveEvalueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.top.mas_equalTo(16);
        make.width.mas_equalTo(100);
    }];
    [self.tm_HaveEvalueLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(24);
        make.top.mas_equalTo(self.tm_ShowHaveEvalueLbl.mas_bottom);
        make.width.mas_equalTo(100);
    }];
    [self.tm_ShowGiveLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.topMenuBtn);
        make.top.mas_equalTo(16);
        make.width.mas_equalTo(100);
    }];
    [self.tm_GiveLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.tm_ShowGiveLbl.mas_centerX);
        make.top.mas_equalTo(self.tm_ShowGiveLbl.mas_bottom);
        make.width.mas_equalTo(100);
    }];
    [self.tm_ShowChouCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.topMenuBtn.mas_right).offset(-17);
        make.top.mas_equalTo(16);
        make.width.mas_equalTo(100);
    }];
    [self.tm_chouCountLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.tm_ShowChouCountLbl.mas_centerX);
        make.top.mas_equalTo(self.tm_ShowChouCountLbl.mas_bottom);
        make.width.mas_equalTo(100);
    }];
    [self.banerImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.height.mas_equalTo(90);
        make.top.mas_equalTo(self.topMenuBtn.mas_bottom);
    }];
    [self.topGiveView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
        make.top.mas_equalTo(self.banerImg.mas_bottom).offset(10);
        make.height.mas_equalTo(114);
    }];
    [self.tG_leftTopLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(10);
        make.top.mas_equalTo(13);
    }];
    
    [self.tG_rightTopLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.top.mas_equalTo(13);
    }];
    
    [self.tG_coinImg1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tG_leftTopLbl.mas_bottom).offset(15);
        make.left.mas_equalTo((SCREEN_WIDTH-252)/8);
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(36);
    }];
    [self.tG_coinBottomLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tG_coinImg1.mas_bottom).offset(5);
        make.centerX.mas_equalTo(self.tG_coinImg1.mas_centerX);
    }];
    [self.tG_coinImg2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.tG_coinImg1.mas_right).offset((SCREEN_WIDTH-252)/8);
        make.width.mas_equalTo(36);
        make.height.mas_equalTo(36);
        make.top.mas_equalTo(self.tG_coinImg1);
    }];
    [self.tG_coinBottomLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.tG_coinImg2);
        make.top.mas_equalTo(self.tG_coinImg2.mas_bottom).offset(5);
    }];
    [self.tG_coinImg3 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.tG_coinImg2.mas_right).offset((SCREEN_WIDTH-252)/8);
       make.width.mas_equalTo(36);
       make.height.mas_equalTo(36);
       make.top.mas_equalTo(self.tG_coinImg2);
    }];
    [self.tG_coinBottomLbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.mas_equalTo(self.tG_coinImg3);
       make.top.mas_equalTo(self.tG_coinImg3.mas_bottom).offset(5);
    }];
    [self.tG_coinImg4 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.tG_coinImg3.mas_right).offset((SCREEN_WIDTH-252)/8);
       make.width.mas_equalTo(36);
       make.height.mas_equalTo(36);
       make.top.mas_equalTo(self.tG_coinImg3);
    }];
    [self.tG_coinBottomLbl4 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.mas_equalTo(self.tG_coinImg4);
       make.top.mas_equalTo(self.tG_coinImg4.mas_bottom).offset(5);
    }];
    [self.tG_coinImg5 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.tG_coinImg4.mas_right).offset((SCREEN_WIDTH-252)/8);
       make.width.mas_equalTo(36);
       make.height.mas_equalTo(36);
       make.top.mas_equalTo(self.tG_coinImg4);
    }];
    [self.tG_coinBottomLbl5 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.mas_equalTo(self.tG_coinImg5);
       make.top.mas_equalTo(self.tG_coinImg5.mas_bottom).offset(5);
    }];
    [self.tG_coinImg6 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.tG_coinImg5.mas_right).offset((SCREEN_WIDTH-252)/8);
       make.width.mas_equalTo(36);
       make.height.mas_equalTo(36);
       make.top.mas_equalTo(self.tG_coinImg5);
    }];
    [self.tG_coinBottomLbl6 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.mas_equalTo(self.tG_coinImg6);
       make.top.mas_equalTo(self.tG_coinImg6.mas_bottom).offset(5);
    }];
    [self.tG_coinImg7 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(self.tG_coinImg6.mas_right).offset((SCREEN_WIDTH-252)/8);
       make.width.mas_equalTo(36);
       make.height.mas_equalTo(36);
       make.top.mas_equalTo(self.tG_coinImg6);
    }];
    [self.tG_coinBottomLbl7 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.centerX.mas_equalTo(self.tG_coinImg7);
       make.top.mas_equalTo(self.tG_coinImg7.mas_bottom).offset(5);
    }];
    [self.tG_coinLbl1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.tG_coinImg1);
        make.width.mas_equalTo(20);
    }];
    [self.tG_coinLbl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.tG_coinImg2);
        make.width.mas_equalTo(20);
    }];
    [self.tG_coinLbl3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.tG_coinImg3);
        make.width.mas_equalTo(20);
    }];
    [self.tG_coinLbl4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.tG_coinImg4);
        make.width.mas_equalTo(20);
    }];
    [self.tG_coinLbl5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.tG_coinImg5);
        make.width.mas_equalTo(20);
    }];
    [self.tG_coinLbl6 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.tG_coinImg6);
        make.width.mas_equalTo(20);
    }];
    [self.tG_coinLbl7 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.mas_equalTo(self.tG_coinImg7);
        make.width.mas_equalTo(20);
    }];
}

#pragma mark --getter
-(UIView *)topView{
    if (!_topView) {
        _topView =[[UIView alloc]init];
        [_topView setBackgroundColor:UIColorFromHex(0x2c2c31)];
    }
    return _topView;
}
-(UIView *)bottomView{
    if (!_bottomView) {
        _bottomView =[[UIView alloc]init];
        [_bottomView setBackgroundColor:[UIColor clearColor]];
    }
    return _bottomView;
}
-(UIImageView *)headimg{
    if (!_headimg) {
        _headimg =[[UIImageView alloc]init];
//        [_headimg setBackgroundColor:[UIColor blueColor]];
        [_headimg.layer setCornerRadius:24];
    }
    return _headimg;
}
-(UILabel *)infoLbl{
    if (!_infoLbl) {
        _infoLbl =[[UILabel alloc]init];
       
        [_infoLbl setFont:Demon_13_Font];
        [_infoLbl setTextColor:[UIColor whiteColor]];
    }
    return _infoLbl;
}
-(UIButton *)shopBtn{
    if (!_shopBtn) {
        _shopBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_shopBtn setBackgroundColor:UIColorFromHex(0x4BBE21)];
        [_shopBtn setTitle:@"电量值商城" forState:UIControlStateNormal];
        [_shopBtn .titleLabel setFont:Demon_12_Font];
        [_shopBtn bk_addEventHandler:^(id sender) {
            if ([self.localDelegate respondsToSelector:@selector(enterEvalueShop)]) {
                [self.localDelegate enterEvalueShop];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _shopBtn;
}
-(UIButton *)topMenuBtn{
    if (!_topMenuBtn) {
        _topMenuBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_topMenuBtn.layer setCornerRadius:5];
        [_topMenuBtn setBackgroundColor:[UIColor whiteColor]];
        [_topMenuBtn addTarget:self action:@selector(findElect) forControlEvents:UIControlEventTouchUpInside];
    }
    return _topMenuBtn;
}

-(UILabel *)tm_ShowHaveEvalueLbl{
    if (!_tm_ShowHaveEvalueLbl) {
        _tm_ShowHaveEvalueLbl =[[UILabel alloc]init];
        [_tm_ShowHaveEvalueLbl setText:@"520"];
        [_tm_ShowHaveEvalueLbl setFont:Demon_15_Font];
        [_tm_ShowHaveEvalueLbl setUserInteractionEnabled:YES];
        WEAKSELF;
        [_tm_ShowHaveEvalueLbl bk_whenTapped:^{
            [weakSelf findElect];
        }];
        [_tm_ShowHaveEvalueLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _tm_ShowHaveEvalueLbl;
}
-(UILabel *)tm_HaveEvalueLbl{
    if (!_tm_HaveEvalueLbl) {
        _tm_HaveEvalueLbl =[[UILabel alloc]init];
        [_tm_HaveEvalueLbl setText:@"我的电量值"];
        [_tm_HaveEvalueLbl setFont:Demon_14_Font];
        [_tm_HaveEvalueLbl setUserInteractionEnabled:YES];
        WEAKSELF;
       [_tm_HaveEvalueLbl bk_whenTapped:^{
           [weakSelf findElect];
       }];
        [_tm_HaveEvalueLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _tm_HaveEvalueLbl;
}
-(UILabel *)tm_ShowGiveLbl{
    if (!_tm_ShowGiveLbl) {
        _tm_ShowGiveLbl =[[UILabel alloc]init];
        [_tm_ShowGiveLbl setText:@"0"];
        [_tm_ShowGiveLbl setFont:Demon_15_Font];
          [_tm_ShowGiveLbl setUserInteractionEnabled:YES];
        WEAKSELF;
          [_tm_ShowGiveLbl bk_whenTapped:^{
              [weakSelf findElect];
          }];
         [_tm_ShowGiveLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _tm_ShowGiveLbl;
}
-(UILabel *)tm_GiveLbl{
    if (!_tm_GiveLbl) {
        _tm_GiveLbl =[[UILabel alloc]init];
        [_tm_GiveLbl setFont:Demon_14_Font];
         [_tm_GiveLbl setTextAlignment:NSTextAlignmentCenter];
         [_tm_GiveLbl setUserInteractionEnabled:YES];
        WEAKSELF;
         [_tm_GiveLbl bk_whenTapped:^{
             [weakSelf findElect];
         }];
        [_tm_GiveLbl setText:@"今天获得电量值"];
    }
    return _tm_GiveLbl;
}
-(UILabel *)tm_ShowChouCountLbl{
    if (!_tm_ShowChouCountLbl) {
        _tm_ShowChouCountLbl =[[UILabel alloc]init];
        [_tm_ShowChouCountLbl setText:@"5"];
        [_tm_ShowChouCountLbl setTextAlignment:NSTextAlignmentCenter];
        [_tm_ShowChouCountLbl setUserInteractionEnabled:YES];
        [_tm_ShowChouCountLbl setFont:Demon_15_Font];
        WEAKSELF;
        [_tm_ShowChouCountLbl bk_whenTapped:^{
            [weakSelf findElect];
        }];
    }
    return _tm_ShowChouCountLbl;
}
-(UILabel *)tm_chouCountLbl{
    if (!_tm_chouCountLbl) {
        _tm_chouCountLbl =[[UILabel alloc]init];
        [_tm_chouCountLbl setText:@"今日可抽奖数"];
        [_tm_chouCountLbl setFont:Demon_15_Font];
         [_tm_chouCountLbl setUserInteractionEnabled:YES];
        [_tm_chouCountLbl setTextAlignment:NSTextAlignmentCenter];
        WEAKSELF;
        [_tm_chouCountLbl bk_whenTapped:^{
            [weakSelf findElect];
        }];
    }
    return _tm_chouCountLbl;
}
-(UIView *)banerImg{
    if (!_banerImg) {
        _banerImg =[[UIImageView alloc]init];
        [_banerImg setImage:[UIImage imageNamed:@"wkm_unchou"]];
        [_banerImg setUserInteractionEnabled:YES];
        UITapGestureRecognizer *tapB =[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(choujiangAction)];
        [_banerImg addGestureRecognizer:tapB];
    }
    return _banerImg;
}
-(UIView *)topGiveView{
    if (!_topGiveView) {
        _topGiveView =[[UIView alloc]init];
        [_topGiveView setBackgroundColor:[UIColor whiteColor]];
    }
    return _topGiveView;
}
-(UILabel *)tG_leftTopLbl{
    if (!_tG_leftTopLbl) {
        _tG_leftTopLbl =[[UILabel alloc]init];
        [_tG_leftTopLbl setFont:Demon_15_Font];
        [_tG_leftTopLbl setText:@"签到领取电量值"];
    }
    return _tG_leftTopLbl;
}
-(UILabel *)tG_rightTopLbl{
    if (!_tG_rightTopLbl) {
        _tG_rightTopLbl =[[UILabel alloc]init];
        [_tG_rightTopLbl setFont:Demon_13_Font];
        [_tG_rightTopLbl setText:@"连续签到电量值成倍增加"];
        [_tG_rightTopLbl setTextColor:CS_Color_MidGray];
    }
    return _tG_rightTopLbl;
}
-(UIButton *)tG_coinImg1{
    if (!_tG_coinImg1) {
        _tG_coinImg1 =[UIButton buttonWithType:UIButtonTypeCustom];
        [_tG_coinImg1 setImage:[UIImage imageNamed:@"wkm_coinUnselected"] forState:UIControlStateNormal];
        [_tG_coinImg1 setImage:[UIImage imageNamed:@"wkm_coinSelected"] forState:UIControlStateSelected];
       
        WEAKSELF;
        [_tG_coinImg1 bk_addEventHandler:^(UIButton *sender) {
            self.num =10;
            [weakSelf performSelector:@selector(signInAct) withObject:nil];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _tG_coinImg1;
}
-(UILabel *)tG_coinBottomLbl1{
    if (!_tG_coinBottomLbl1) {
        _tG_coinBottomLbl1 =[[UILabel alloc]init];
        [_tG_coinBottomLbl1 setText:@"1天"];
        [_tG_coinBottomLbl1 setFont:Demon_10_Font];
    }
    return _tG_coinBottomLbl1;
}
-(UIButton *)tG_coinImg2{
    if (!_tG_coinImg2) {
        _tG_coinImg2 =[UIButton buttonWithType:UIButtonTypeCustom];
       
        [_tG_coinImg2 setImage:[UIImage imageNamed:@"wkm_coinUnselected"] forState:UIControlStateNormal];
        [_tG_coinImg2 setImage:[UIImage imageNamed:@"wkm_coinSelected"] forState:UIControlStateSelected];
        WEAKSELF;
       [_tG_coinImg2 bk_addEventHandler:^(UIButton *sender) {
            self.num =20;
           [weakSelf signInAct];
       } forControlEvents:UIControlEventTouchUpInside];
    }
    return _tG_coinImg2;
}
-(UILabel *)tG_coinBottomLbl2{
    if (!_tG_coinBottomLbl2) {
        _tG_coinBottomLbl2 =[[UILabel alloc]init];
        [_tG_coinBottomLbl2 setText:@"2天"];
        [_tG_coinBottomLbl2 setFont:Demon_10_Font];
    }
    return _tG_coinBottomLbl2;
}
-(UIButton *)tG_coinImg3{
    if (!_tG_coinImg3) {
        _tG_coinImg3 =[UIButton buttonWithType:UIButtonTypeCustom];
         [_tG_coinImg3 setImage:[UIImage imageNamed:@"wkm_coinUnselected"] forState:UIControlStateNormal];
      [_tG_coinImg3 setImage:[UIImage imageNamed:@"wkm_coinSelected"] forState:UIControlStateSelected];
     WEAKSELF;
        [_tG_coinImg3 bk_addEventHandler:^(UIButton *sender) {
              self.num =40;
            [weakSelf signInAct];
        } forControlEvents:UIControlEventTouchUpInside];
       
    }
    return _tG_coinImg3;
}
-(UILabel *)tG_coinBottomLbl3{
    if (!_tG_coinBottomLbl3) {
        _tG_coinBottomLbl3 =[[UILabel alloc]init];
        [_tG_coinBottomLbl3 setText:@"3天"];
        [_tG_coinBottomLbl3 setFont:Demon_10_Font];
    }
    return _tG_coinBottomLbl3;
}
-(UIButton *)tG_coinImg4{
    if (!_tG_coinImg4) {
        _tG_coinImg4 =[UIButton buttonWithType:UIButtonTypeCustom];
         [_tG_coinImg4 setImage:[UIImage imageNamed:@"wkm_coinUnselected"] forState:UIControlStateNormal];
        [_tG_coinImg4 setImage:[UIImage imageNamed:@"wkm_coinSelected"] forState:UIControlStateSelected];
        WEAKSELF;
       [_tG_coinImg4 bk_addEventHandler:^(UIButton *sender) {
            self.num =80;
           [weakSelf signInAct];
       } forControlEvents:UIControlEventTouchUpInside];
    }
    return _tG_coinImg4;
}
-(UILabel *)tG_coinBottomLbl4{
    if (!_tG_coinBottomLbl4) {
        _tG_coinBottomLbl4 =[[UILabel alloc]init];
        [_tG_coinBottomLbl4 setText:@"4天"];
        [_tG_coinBottomLbl4 setFont:Demon_10_Font];
    }
    return _tG_coinBottomLbl4;
}
-(UIButton *)tG_coinImg5{
    if (!_tG_coinImg5) {
        _tG_coinImg5 =[UIButton buttonWithType:UIButtonTypeCustom];
          [_tG_coinImg5 setImage:[UIImage imageNamed:@"wkm_coinUnselected"] forState:UIControlStateNormal];
         [_tG_coinImg5 setImage:[UIImage imageNamed:@"wkm_coinSelected"] forState:UIControlStateSelected];
        WEAKSELF;
        [_tG_coinImg5 bk_addEventHandler:^(UIButton *sender) {
             self.num =160;
            [weakSelf signInAct];
        } forControlEvents:UIControlEventTouchUpInside];

    }
    return _tG_coinImg5;
}
-(UILabel *)tG_coinBottomLbl5{
    if (!_tG_coinBottomLbl5) {
        _tG_coinBottomLbl5 =[[UILabel alloc]init];
        [_tG_coinBottomLbl5 setText:@"5天"];
        [_tG_coinBottomLbl5 setFont:Demon_10_Font];
    }
    return _tG_coinBottomLbl5;
}
-(UIButton *)tG_coinImg6{
    if (!_tG_coinImg6) {
        _tG_coinImg6 =[UIButton buttonWithType:UIButtonTypeCustom];
          [_tG_coinImg6 setImage:[UIImage imageNamed:@"wkm_coinUnselected"] forState:UIControlStateNormal];
           [_tG_coinImg6 setImage:[UIImage imageNamed:@"wkm_coinSelected"] forState:UIControlStateSelected];
        [_tG_coinImg6 setUserInteractionEnabled:YES];
        WEAKSELF;
         [_tG_coinImg6 bk_addEventHandler:^(UIButton *sender) {
             self.num =320;
             [weakSelf signInAct];
         } forControlEvents:UIControlEventTouchUpInside];
    }
    return _tG_coinImg6;
}
-(UILabel *)tG_coinBottomLbl6{
    if (!_tG_coinBottomLbl6) {
        _tG_coinBottomLbl6 =[[UILabel alloc]init];
        [_tG_coinBottomLbl6 setText:@"6天"];
        [_tG_coinBottomLbl6 setFont:Demon_10_Font];
    }
    return _tG_coinBottomLbl6;
}
-(UIButton *)tG_coinImg7{
    if (!_tG_coinImg7) {
        _tG_coinImg7 =[UIButton buttonWithType:UIButtonTypeCustom];
        [_tG_coinImg7 setImage:[UIImage imageNamed:@"wkm_coinUnselected"] forState:UIControlStateNormal];
       [_tG_coinImg7 setImage:[UIImage imageNamed:@"wkm_coinSelected"] forState:UIControlStateSelected];
        WEAKSELF;
        [_tG_coinImg7 bk_addEventHandler:^(UIButton *sender) {
             self.num =640;
            [weakSelf signInAct];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _tG_coinImg7;
}
-(UILabel *)tG_coinBottomLbl7{
    if (!_tG_coinBottomLbl7) {
        _tG_coinBottomLbl7 =[[UILabel alloc]init];
        [_tG_coinBottomLbl7 setText:@"7天"];
        [_tG_coinBottomLbl7 setFont:Demon_10_Font];
    }
    return _tG_coinBottomLbl7;
}
-(UILabel *)tG_coinLbl1{
    if (!_tG_coinLbl1) {
        _tG_coinLbl1 =[[UILabel alloc]init];
        [_tG_coinLbl1 setText:@"10"];
        [_tG_coinLbl1 setFont:Demon_10_Font];
        [_tG_coinLbl1 setTextAlignment:NSTextAlignmentCenter];
    }
    return _tG_coinLbl1;
}
-(UILabel *)tG_coinLbl2{
    if (!_tG_coinLbl2) {
        _tG_coinLbl2 =[[UILabel alloc]init];
         [_tG_coinLbl2 setText:@"20"];
          [_tG_coinLbl2 setFont:Demon_10_Font];
         [_tG_coinLbl2 setTextAlignment:NSTextAlignmentCenter];
    }
    return _tG_coinLbl2;
}
-(UILabel *)tG_coinLbl3{
    if (!_tG_coinLbl3) {
        _tG_coinLbl3 =[[UILabel alloc]init];
         [_tG_coinLbl3 setText:@"40"];
        [_tG_coinLbl3 setFont:Demon_10_Font];
         [_tG_coinLbl3 setTextAlignment:NSTextAlignmentCenter];
    }
    return _tG_coinLbl3;
}
-(UILabel *)tG_coinLbl4{
    if (!_tG_coinLbl4) {
        _tG_coinLbl4 =[[UILabel alloc]init];
         [_tG_coinLbl4 setText:@"80"];
        [_tG_coinLbl4 setFont:Demon_10_Font];
         [_tG_coinLbl4 setTextAlignment:NSTextAlignmentCenter];
    }
    return _tG_coinLbl4;
}
-(UILabel *)tG_coinLbl5{
    if (!_tG_coinLbl5) {
        _tG_coinLbl5 =[[UILabel alloc]init];
         [_tG_coinLbl5 setText:@"160"];
         [_tG_coinLbl5 setFont:Demon_10_Font];
          [_tG_coinLbl5 setTextAlignment:NSTextAlignmentCenter];
    }
    return _tG_coinLbl5;
}
-(UILabel *)tG_coinLbl6{
    if (!_tG_coinLbl6) {
        _tG_coinLbl6 =[[UILabel alloc]init];
         [_tG_coinLbl6 setText:@"320"];
          [_tG_coinLbl6 setFont:Demon_10_Font];
         [_tG_coinLbl6 setTextAlignment:NSTextAlignmentCenter];
    }
    return _tG_coinLbl6;
}
-(UILabel *)tG_coinLbl7{
    if (!_tG_coinLbl7) {
        _tG_coinLbl7 =[[UILabel alloc]init];
        [_tG_coinLbl7 setText:@"640"];
        [_tG_coinLbl7 setFont:Demon_10_Font];
        [_tG_coinLbl7 setTextAlignment:NSTextAlignmentCenter];
    }
    return _tG_coinLbl7;
}

#pragma mark 查询电量值
-(void)findElect{
    if ([self.localDelegate respondsToSelector:@selector(findElectricityAction)]) {
        [self.localDelegate findElectricityAction];
    }
}
#pragma mark 点击抽奖
-(void)choujiangAction{
       WEAKSELF
    if ([weakSelf.localDelegate respondsToSelector:@selector(choujiangAction)]) {
        [weakSelf.localDelegate choujiangAction];
    }
}
#pragma mark 签到
-(void)signInAct{

    WEAKSELF
    if ([weakSelf.localDelegate respondsToSelector:@selector(signInAction:)]) {
        [weakSelf.localDelegate signInAction:self.num];
    }
}
#pragma mark 进入电量值商城
-(void)enterEvalueShop{
       WEAKSELF
    if ([weakSelf.localDelegate respondsToSelector:@selector(enterEvalueShop)]) {
        [weakSelf.localDelegate enterEvalueShop];
    }
}
- (void)getUserData {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(UserNewInfoHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
        if ([data[@"code"] intValue] == KSuccessCode) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setUserInfo:[FELoginResponseUserInfoModel mj_objectWithKeyValues:responseObject[@"data"][@"userInfo"]]];
            });
        }else if ([data[@"code"] intValue] != KTokenFailCode){
            dispatch_async(dispatch_get_main_queue(), ^{
                MTSVPShowInfoText(data[@"msg"]);
            });
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setUserInfo:(FELoginResponseUserInfoModel *)userInfo {
   [_headimg sd_setImageWithURL:[NSURL URLWithString:userInfo.faceImg] placeholderImage:[UIImage imageNamed:kFEDefaultImg]];
        _headimg.clipsToBounds = YES;
    [_infoLbl setText:[self changeTelephone:userInfo.mobile]];
}

#pragma mark -填充数据
-(void)fillData:(FEWorkPanelDataResponseModel *)pannelModel{
    [self getUserData];
    [self.tm_ShowHaveEvalueLbl setText:pannelModel.myElectrictyVal];
    [self.tm_ShowGiveLbl setText:pannelModel.todayElectricity];
    [self.tm_ShowChouCountLbl setText:pannelModel.lottery_number];
    
    //ldq fix
    [self resetSignCoinUI];
    
    if ([pannelModel.sign_num isEqualToString:@"1"]) {
        _tG_coinImg1.selected =YES;
        _tG_coinImg1.userInteractionEnabled =NO;
    }else if([pannelModel.sign_num isEqualToString:@"2"]){
        _tG_coinImg1.selected =YES;
        _tG_coinImg1.userInteractionEnabled =NO;
        _tG_coinImg2.selected =YES;
        _tG_coinImg2.userInteractionEnabled =NO;
    }else if([pannelModel.sign_num isEqualToString:@"3"]){
        _tG_coinImg1.selected =YES;
        _tG_coinImg1.userInteractionEnabled =NO;
        _tG_coinImg2.selected =YES;
        _tG_coinImg2.userInteractionEnabled =NO;
        _tG_coinImg3.selected =YES;
        _tG_coinImg3.userInteractionEnabled =NO;
    }else if([pannelModel.sign_num isEqualToString:@"4"]){
        _tG_coinImg1.selected =YES;
       _tG_coinImg1.userInteractionEnabled =NO;
       _tG_coinImg2.selected =YES;
       _tG_coinImg2.userInteractionEnabled =NO;
       _tG_coinImg3.selected =YES;
       _tG_coinImg3.userInteractionEnabled =NO;
       _tG_coinImg4.selected =YES;
        _tG_coinImg4.userInteractionEnabled =NO;
    }else if([pannelModel.sign_num isEqualToString:@"5"]){
        _tG_coinImg1.selected =YES;
        _tG_coinImg1.userInteractionEnabled =NO;
        _tG_coinImg2.selected =YES;
        _tG_coinImg2.userInteractionEnabled =NO;
        _tG_coinImg3.selected =YES;
        _tG_coinImg3.userInteractionEnabled =NO;
        _tG_coinImg4.selected =YES;
        _tG_coinImg4.userInteractionEnabled =NO;
        _tG_coinImg5.selected =YES;
        _tG_coinImg5.userInteractionEnabled =NO;
    }else if([pannelModel.sign_num isEqualToString:@"6"]){
        _tG_coinImg1.selected =YES;
        _tG_coinImg1.userInteractionEnabled =NO;
        _tG_coinImg2.selected =YES;
        _tG_coinImg2.userInteractionEnabled =NO;
        _tG_coinImg3.selected =YES;
        _tG_coinImg3.userInteractionEnabled =NO;
        _tG_coinImg4.selected =YES;
        _tG_coinImg4.userInteractionEnabled =NO;
        _tG_coinImg5.selected =YES;
        _tG_coinImg5.userInteractionEnabled =NO;
        _tG_coinImg6.selected =YES;
        _tG_coinImg6.userInteractionEnabled =NO;
    }else if([pannelModel.sign_num isEqualToString:@"7"]){
         _tG_coinImg1.selected =YES;
          _tG_coinImg1.userInteractionEnabled =NO;
          _tG_coinImg2.selected =YES;
          _tG_coinImg2.userInteractionEnabled =NO;
          _tG_coinImg3.selected =YES;
          _tG_coinImg3.userInteractionEnabled =NO;
          _tG_coinImg4.selected =YES;
          _tG_coinImg4.userInteractionEnabled =NO;
          _tG_coinImg5.selected =YES;
          _tG_coinImg5.userInteractionEnabled =NO;
          _tG_coinImg6.selected =YES;
          _tG_coinImg6.userInteractionEnabled =NO;
          _tG_coinImg7.selected =YES;
          _tG_coinImg7.userInteractionEnabled =NO;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    return YES;
}

-(NSString*)changeTelephone:(NSString*)teleStr{
     NSString *string = [teleStr stringByReplacingOccurrencesOfString:[teleStr substringWithRange:NSMakeRange(3,4)]withString:@"****"];
    return string;
}


//ldq fix 1111
- (void)resetSignCoinUI {
    _tG_coinImg1.selected =NO;
    _tG_coinImg1.userInteractionEnabled =YES;
    _tG_coinImg2.selected =NO;
    _tG_coinImg2.userInteractionEnabled =YES;
    _tG_coinImg3.selected =NO;
    _tG_coinImg3.userInteractionEnabled =YES;
    _tG_coinImg4.selected =NO;
    _tG_coinImg4.userInteractionEnabled =YES;
    _tG_coinImg5.selected =NO;
    _tG_coinImg5.userInteractionEnabled =YES;
    _tG_coinImg6.selected =NO;
    _tG_coinImg6.userInteractionEnabled =YES;
    _tG_coinImg7.selected =NO;
    _tG_coinImg7.userInteractionEnabled =YES;
}

@end
