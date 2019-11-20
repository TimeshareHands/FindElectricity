//
//  FESignInActAlert.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/20.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FESignInActAlert.h"
@interface FESignInActAlert()

@property(nonatomic, strong)UIView *shadowView;
@property(nonatomic, strong)UIImageView *centerImgLogo;
@property(nonatomic, strong)UILabel *topLbl;
@property(nonatomic, strong)UILabel *bottomLabel;

@end
@implementation FESignInActAlert

- (id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}

#pragma mark 添加视图
- (void)addView{
    [self setBackgroundColor:[UIColor whiteColor]];
    [self addSubview:self.topLbl];
    [self addSubview:self.centerImgLogo];
    [self addSubview:self.bottomLabel];
    [self makeUpConstriant];
}

#pragma mark 约束适配
- (void)makeUpConstriant{
    [self.topLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(WIDTH_LY(2));
        make.right.mas_equalTo(WIDTH_LY(-2));
        make.top.mas_equalTo(WIDTH_LY(18));
    }];
  
    [self.centerImgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.topLbl.mas_bottom).offset(12);
        make.centerX.mas_equalTo(self);
        make.height.mas_equalTo(WIDTH_LY(36));
        make.width.mas_equalTo(WIDTH_LY(36));
    }];
    [self.bottomLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.centerImgLogo.mas_bottom).offset(HEIGHT_LY(8));
        make.height.mas_equalTo(HEIGHT_LY(20));
        make.centerX.mas_equalTo(self);
        make.left.mas_equalTo(WIDTH_LY(28));
        make.right.mas_equalTo(WIDTH_LY(-28));
    }];
}

#pragma mark getter
- (UIImageView *)centerImgLogo{
    if (!_centerImgLogo) {
        _centerImgLogo =[[UIImageView alloc]init];
        [_centerImgLogo setImage:[UIImage imageNamed:@"wkm_giveCoin"]];
    }
    return _centerImgLogo;
}
- (UILabel *)topLbl{
    if (!_topLbl) {
        _topLbl =[[UILabel alloc]init];
        [_topLbl setFont:Demon_13_Font];
        [_topLbl setText:@"电量值奖励"];
        [_topLbl setTextAlignment:NSTextAlignmentCenter];
    }
    return _topLbl;
}
-(UILabel *)bottomLabel{
    if (!_bottomLabel) {
        _bottomLabel =[[UILabel alloc]init];
        [_bottomLabel setText:@"+160"];
        [_bottomLabel setFont:Demon_20_Font];
        [_bottomLabel setTextColor:UIColorFromHex(0xffcb41)];
        [_bottomLabel setTextAlignment:NSTextAlignmentCenter];
    }
    return _bottomLabel;
}
-(UIView *)shadowView{
    if (!_shadowView) {
        _shadowView =[[UIView alloc]init];
        _shadowView.backgroundColor =[UIColor blackColor];
        [_shadowView setAlpha:0.1];
    }
    return _shadowView;
}

- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self.shadowView];
    [keyWindow addSubview:self];
    [self.shadowView mas_makeConstraints:^(MASConstraintMaker *make) {
         make.left.mas_equalTo(keyWindow);
         make.right.mas_equalTo(keyWindow);
         make.top.mas_equalTo(keyWindow);
         make.bottom.mas_equalTo(keyWindow);
    }];
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH_LY(120));
        make.center.mas_equalTo(keyWindow);
        make.height.mas_equalTo(WIDTH_LY(120));
    }];
     [self performSelector:@selector(hidden) withObject:nil afterDelay:3];
}

- (void)hidden {
    [self.shadowView removeFromSuperview];
    [self removeFromSuperview];
}
-(void)setEvalue:(NSString *)evalue{
    [self.bottomLabel setText:[NSString stringWithFormat:@"+%@",evalue]];
}
@end
