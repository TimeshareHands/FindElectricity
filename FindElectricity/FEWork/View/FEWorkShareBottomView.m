//
//  FEWorkShareBottomView.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/20.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkShareBottomView.h"
@interface FEWorkShareBottomView()
@property(nonatomic, strong)UIButton *lineQV;
@property(nonatomic, strong)UIButton *wxV;
@property(nonatomic, strong)UILabel *lineQLbl;
@property(nonatomic, strong)UILabel *wxLbl;
@property(nonatomic, strong)UIButton *cancelBtn;
@end

@implementation FEWorkShareBottomView

-(id)init{
    if (self =[super init]) {
        self.backgroundColor =[UIColor whiteColor];
        [self addView];
    }
    return self;
}

#pragma mark -添加视图
-(void)addView{
    [self addSubview:self.lineQV];
    [self addSubview:self.wxV];
    [self addSubview:self.lineQLbl];
    [self addSubview:self.wxLbl];
    [self addSubview:self.cancelBtn];
    [self makeUpConstraint];
}

#pragma mark -约束适配
-(void)makeUpConstraint{
    [self.lineQV mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.mas_centerX).offset(WIDTH_LY(-25));
        make.width.mas_equalTo(WIDTH_LY(45));
        make.height.mas_equalTo(HEIGHT_LY(45));
        make.top.mas_equalTo(HEIGHT_LY(20));
    }];
    [self.wxV mas_makeConstraints:^(MASConstraintMaker *make) {
           make.left.mas_equalTo(self.mas_centerX).offset(WIDTH_LY(25));
           make.width.mas_equalTo(WIDTH_LY(45));
           make.height.mas_equalTo(HEIGHT_LY(45));
           make.top.mas_equalTo(HEIGHT_LY(20));
    }];
    [self.lineQLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.lineQV);
        make.bottom.mas_equalTo(self.lineQV.mas_bottom).offset(HEIGHT_LY(10));
    }];
    [self.wxLbl mas_makeConstraints:^(MASConstraintMaker *make) {
         make.centerX.mas_equalTo(self.wxV);
         make.bottom.mas_equalTo(self.wxV.mas_bottom).offset(HEIGHT_LY(10));
    }];
    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(HEIGHT_LY(40));
        make.left.mas_equalTo(self);
        make.right.mas_equalTo(self);
    }];
}

#pragma mark getter
-(UIButton *)lineQV{
    if (!_lineQV) {
        _lineQV =[UIButton buttonWithType:UIButtonTypeCustom];
        [_lineQV setImage:[UIImage imageNamed:@"wkc_FriendLine"] forState:UIControlStateNormal];
        [_lineQV bk_addEventHandler:^(id sender) {
            [self dismiss];
            if ([self.localDelagte respondsToSelector:@selector(shareLineQ)]) {
                [self.localDelagte shareLineQ];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _lineQV;
}
-(UIButton *)wxV{
    if (!_wxV) {
        _wxV =[UIButton buttonWithType:UIButtonTypeCustom];
        [_wxV setImage:[UIImage imageNamed:@"wkc_weixin"] forState:UIControlStateNormal];
        [_wxV bk_addEventHandler:^(id sender) {
            [self dismiss];
            if ([self.localDelagte respondsToSelector:@selector(shareWx)]) {
                [self.localDelagte shareWx];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _wxV;
}
-(UILabel *)lineQLbl{
    if (!_lineQLbl) {
        _lineQLbl =[[UILabel alloc]init];
        [_lineQLbl setText:@"朋友圈"];
    }
    return _lineQLbl;
}
-(UILabel *)wxLbl{
    if (!_wxLbl) {
        _wxLbl =[[UILabel alloc]init];
        [_wxLbl setText:@"微信"];
    }
    return _wxLbl;
}
-(UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    }
    return _cancelBtn;
}
-(void)show{
    [UIView animateWithDuration:1 animations:^{
        [self setFrame:CGRectMake(0, SCREEN_HEIGHT-100, SCREEN_WIDTH, 100)];
    }];
}
-(void)dismiss{
    [UIView animateWithDuration:1 animations:^{
        [self setFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 100)];
    }];
}
@end
