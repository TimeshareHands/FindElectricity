//
//  FEWorkInviteStandStardVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/12.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkInviteStandStardVC.h"

@interface FEWorkInviteStandStardVC ()
@property(nonatomic, strong)UIImageView *topImageView;
@property(nonatomic, strong)UIView *whiteView;
@property(nonatomic, strong)UIView *lineView;
@property(nonatomic, strong)UILabel *Label1;
@property(nonatomic, strong)UILabel *Label2;
@property(nonatomic, strong)UILabel *Label3;
@property(nonatomic, strong)UILabel *Label4;
@property(nonatomic, strong)UILabel *Label5;
@property(nonatomic, strong)UILabel *Labell;
@end

@implementation FEWorkInviteStandStardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)initView{
    self.title =@"邀请好友规则";
    [self.view setBackgroundColor:UIColorFromHex(0xE26A41)];
    [self.view addSubview:self.topImageView];
    [self.view addSubview:self.whiteView];
    [self.whiteView addSubview:self.lineView];
    [self.whiteView addSubview:self.Label1];
    [self.whiteView addSubview:self.Label2];
    [self.whiteView addSubview:self.Label3];
    [self.whiteView addSubview:self.Label4];
    [self.whiteView addSubview:self.Label5];
    [self.whiteView addSubview:self.Labell];
    [self makeUpConstraint];
}
-(void)makeUpConstraint{
    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.height.mas_equalTo(140);
        make.top.mas_equalTo(12);
    }];
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.right.mas_equalTo(-20);
        make.top.mas_equalTo(self.topImageView.mas_bottom);
        make.bottom.mas_equalTo(-12);
    }];
    [self.Labell mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.whiteView);
        make.top.mas_equalTo(11);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.whiteView);
        make.top.mas_equalTo(self.Labell.mas_bottom).offset(11);
    }];
    [self.Label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.lineView.mas_bottom).offset(11);
        make.right.mas_equalTo(-20);
    }];
    [self.Label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.Label1.mas_bottom).offset(18);
        make.right.mas_equalTo(-20);
    }];
    [self.Label3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.Label2.mas_bottom).offset(28);
        make.right.mas_equalTo(-20);
    }];
    [self.Label4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.Label3.mas_bottom).offset(28);
        make.right.mas_equalTo(-20);
    }];
    [self.Label5 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(20);
        make.top.mas_equalTo(self.Label4.mas_bottom).offset(18);
        make.right.mas_equalTo(-20);
    }];
}
#pragma mark- getter
- (UIImageView *)topImageView{
    if (!_topImageView) {
        _topImageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wkc_choujiangBanner"]];
    }
    return _topImageView;
}
- (UIView *)whiteView{
    if (!_whiteView) {
        _whiteView =[[UIView alloc]init];
        [_whiteView setBackgroundColor:[UIColor whiteColor]];
    }
    return _whiteView;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView =[[UIView alloc]init];
        [_lineView setBackgroundColor:UIColorFromHex(0x565656)];
    }
    return _lineView;
}
- (UILabel *)Labell{
    if (!_Labell) {
        _Labell =[[UILabel alloc]init];
        [_Labell setFont:Demon_16_Font];
        [_Labell setTextColor:UIColorFromHex(0xE26B42)];
        [_Labell setText:@"抽奖规则"];
    }
    return _Labell;
}
- (UILabel *)Label1{
    if (!_Label1) {
        _Label1 =[[UILabel alloc]init];
        [_Label1 setFont:Demon_13_Font];
        [_Label1 setText:@"在找电获得抽奖机会最快的方法就是分享好友， 如何确保分享后能够获得次数呢？"];
        [_Label1 setNumberOfLines:0];
    }
    return _Label1;
}
- (UILabel *)Label2{
    if (!_Label2) {
        _Label2 =[[UILabel alloc]init];
        [_Label2 setFont:Demon_16_Font];
        [_Label2 setText:@"1. 分享给微信好友赠送抽奖次数"];
        [_Label2 setTextColor:UIColorFromHex(0xE26B42)];
         [_Label2 setNumberOfLines:0];
    }
    return _Label2;
}
- (UILabel *)Label3{
    if (!_Label3) {
        _Label3 =[[UILabel alloc]init];
        [_Label3 setText:@"成功分享到微信朋友圈或者好友，赠送抽奖次数，最多赠送5次。"];
        [_Label3 setFont:Demon_13_Font];
         [_Label3 setNumberOfLines:0];
    }
    return _Label3;
}
- (UILabel *)Label4{
    if (!_Label4) {
        _Label4 =[[UILabel alloc]init];
        [_Label4 setTextColor:UIColorFromHex(0xE26B42)];
        [_Label4 setText:@"2. 分享给好友，好友点击你分享的页面或者扫描二维码后，下载注册并且登录找电后，即可赠送10次抽奖机会"];
        [_Label4 setFont:Demon_16_Font];
         [_Label4 setNumberOfLines:0];
    }
    return _Label4;
}
- (UILabel *)Label5{
    if (!_Label5) {
        _Label5 =[[UILabel alloc]init];
        [_Label5 setText:@"注意：如果你分享给的人以前就注册过找电了，那么就不能算是你邀请成功了的，所以不会赠送次数，务必让对方通过你分享的链接来下载注册登录找电APP，才能保证赠送次数到账哦。"];
        [_Label5 setFont:Demon_13_Font];
         [_Label5 setNumberOfLines:0];
    }
    return _Label5;
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
