//
//  FELoginViewController.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/7.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FELoginViewController.h"
#import "FERegisterAccountVC.h"
#import "FEFindPasswordVC.h"

@interface FELoginViewController ()
@property(nonatomic, strong)UIImageView *topImgLogo;
@property(nonatomic, strong)UILabel *topLbl;
@property(nonatomic, strong)UITextField *accountTxt;
@property(nonatomic, strong)UITextField *passwordTxt;
@property(nonatomic, strong)UIView *lineView1;
@property(nonatomic, strong)UIView *lineView2;
@property(nonatomic, strong)UILabel *protocalLbl;
@property(nonatomic, strong)UIButton *protocalBtn;
@property(nonatomic, strong)UIButton *checkBtn;
@property(nonatomic, strong)UILabel *rememberLbl;
@property(nonatomic, strong)UIButton *comfirmBtn;
@property(nonatomic, strong)UIButton *registerBtn;
@property(nonatomic, strong)UIButton *forgetBtn;
@property(nonatomic, strong)UIButton *wxLoginBtn;
@property(nonatomic, strong)UILabel *wxLoginLbl;
@end

@implementation FELoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}

#pragma mark -添加视图
- (void)addView{
    UITapGestureRecognizer *cancleKeyBoard =[[UITapGestureRecognizer alloc]bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
        [self.view endEditing:YES];
    }];
    [self.view addGestureRecognizer:cancleKeyBoard];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:self.topImgLogo];
    [self.view addSubview:self.topLbl];
    [self.view addSubview:self.lineView1];
    [self.view addSubview:self.lineView2];
    [self.view addSubview:self.accountTxt];
    [self.view addSubview:self.passwordTxt];
    [self.view addSubview:self.protocalLbl];
    [self.view addSubview:self.protocalBtn];
    [self.view addSubview:self.checkBtn];
    [self.view addSubview:self.rememberLbl];
    [self.view addSubview:self.comfirmBtn];
    [self.view addSubview:self.registerBtn];
    [self.view addSubview:self.forgetBtn];
    [self.view addSubview:self.wxLoginBtn];
    [self.view addSubview:self.wxLoginLbl];
    [self makeUpConstriant];
}
- (void)makeUpConstriant{
    [self.topImgLogo mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).offset(150);
        make.width.mas_equalTo(90);
        make.height.mas_equalTo(90);
    }];
    [self.topLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.topImgLogo.mas_bottom);
    }];
    [self.accountTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(33);
        make.top.mas_equalTo(self.topLbl.mas_bottom).offset(20);
    }];
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.accountTxt.mas_bottom).offset(10);
        make.height.mas_equalTo(1);
        make.right.mas_equalTo(-15);
    }];
   
    [self.passwordTxt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.lineView1.mas_bottom).offset(20);
    }];
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
       make.left.mas_equalTo(15);
       make.top.mas_equalTo(self.passwordTxt.mas_bottom).offset(10);
       make.height.mas_equalTo(1);
       make.right.mas_equalTo(-15);
    }];
    [self.protocalLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.lineView2.mas_bottom).offset(10);
    }];
    [self.protocalBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.protocalLbl.mas_right).offset(2);
        make.centerY.mas_equalTo(self.protocalLbl);
    }];
    [self.rememberLbl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.view).offset(-15);
        make.centerY.mas_equalTo(self.protocalLbl);
    }];
    [self.checkBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.rememberLbl.mas_left).offset(-5);
        make.centerY.mas_equalTo(self.rememberLbl);
    }];
    [self.comfirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(self.rememberLbl.mas_bottom).offset(30);
    }];
    [self.registerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.top.mas_equalTo(self.comfirmBtn.mas_bottom).offset(10);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    [self.forgetBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.top.mas_equalTo(self.registerBtn);
        make.width.mas_equalTo(100);
        make.height.mas_equalTo(44);
    }];
    [self.wxLoginLbl mas_makeConstraints:^(MASConstraintMaker *make) {
           make.centerX.mas_equalTo(self.view);
           make.bottom.mas_equalTo(self.view).offset(-50);
       }];
    [self.wxLoginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.wxLoginLbl.mas_top).offset(-10);
    }];
   
}
#pragma mark -getter
- (UIImageView *)topImgLogo{
    if (!_topImgLogo) {
        _topImgLogo =[[UIImageView alloc]init];
        [_topImgLogo setImage:[UIImage imageNamed:@"felogin_logo"]];
    }
    return _topImgLogo;
}
- (UILabel *)topLbl{
    if (!_topLbl) {
        _topLbl =[[UILabel alloc]init];
        [_topLbl setText:@"找电"];
        [_topLbl setTextColor:UIColorFromHex(0x61EB9E)];
        [_topLbl setFont:Demon_32_Font];
    }
    return _topLbl;
}
- (UIView *)lineView1{
    if (!_lineView1) {
        _lineView1 =[[UIView alloc]init];
        [_lineView1 setBackgroundColor:UIColorFromHex(0xC9C9C9)];
    }
    return _lineView1;
}
- (UIView *)lineView2{
    if (!_lineView2) {
        _lineView2 =[[UIView alloc]init];
         [_lineView2 setBackgroundColor:UIColorFromHex(0xC9C9C9)];
    }
    return _lineView2;
}
- (UITextField *)accountTxt{
    if (!_accountTxt) {
        _accountTxt =[[UITextField alloc]init];
        [_accountTxt setPlaceholder:@"请输入手机号"];
        [_accountTxt setFont:Demon_15_Font];
    }
    return _accountTxt;
}
- (UITextField *)passwordTxt{
    if (!_passwordTxt) {
        _passwordTxt =[[UITextField alloc]init];
        [_passwordTxt setPlaceholder:@"请输入密码"];
        [_passwordTxt setFont:Demon_15_Font];
    }
    return _passwordTxt;
}
- (UILabel *)protocalLbl{
    if (!_protocalLbl) {
        _protocalLbl =[[UILabel alloc]init];
        [_protocalLbl setText:@"登录即表示同意"];
        [_protocalLbl setFont:Demon_15_Font];
        [_protocalLbl setTextColor:UIColorFromHex(0xC9C9C9)];
    }
    return _protocalLbl;
}
- (UIButton *)protocalBtn{
    if (!_protocalBtn) {
        _protocalBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_protocalBtn setTitle:@"《找电用户隐私协议》" forState:UIControlStateNormal];
        [_protocalBtn setTitleColor:UIColorFromHex(0x61EB9E) forState:UIControlStateNormal];
        [_protocalBtn.titleLabel setFont:Demon_15_Font];
    }
    return _protocalBtn;
}
- (UIButton *)checkBtn{
    if (!_checkBtn) {
        _checkBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_checkBtn setImage:[UIImage imageNamed:@"felogin_uncheck"] forState:UIControlStateNormal];
    }
    return _checkBtn;
}
- (UILabel *)rememberLbl{
    if (!_rememberLbl) {
        _rememberLbl =[[UILabel alloc]init];
        [_rememberLbl setText:@"记住密码"];
        [_rememberLbl setFont:Demon_15_Font];
        [_rememberLbl setTextColor:UIColorFromHex(0xC9C9C9)];
    }
    return _rememberLbl;
}
- (UIButton *)comfirmBtn{
    if (!_comfirmBtn) {
        _comfirmBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_comfirmBtn setTitle:@"登录" forState:UIControlStateNormal];
        [_comfirmBtn setBackgroundColor:UIColorFromHex(0x5FE79B)];
         [_comfirmBtn.titleLabel setFont:Demon_24_Font];
        [_comfirmBtn bk_addEventHandler:^(id sender) {
            [self loginAction];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _comfirmBtn;
}
- (UIButton *)registerBtn{
    if (!_registerBtn) {
        _registerBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_registerBtn setTitle:@"注册" forState:UIControlStateNormal];
        [_registerBtn setTitleColor:UIColorFromHex(0xC9C9C9) forState:UIControlStateNormal];
        [_registerBtn bk_addEventHandler:^(id sender) {
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _registerBtn;
}
- (UIButton *)forgetBtn{
    if (!_forgetBtn) {
        _forgetBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_forgetBtn setTitle:@"忘记密码" forState:UIControlStateNormal];
        [_forgetBtn setTitleColor:UIColorFromHex(0xC9C9C9) forState:UIControlStateNormal];
        [_forgetBtn bk_addEventHandler:^(id sender) {
            
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _forgetBtn;
}
- (UIButton *)wxLoginBtn{
    if (!_wxLoginBtn) {
        _wxLoginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_wxLoginBtn setImage:[UIImage imageNamed:@"felogin_wxlogin"] forState:UIControlStateNormal];
    }
    return _wxLoginBtn;
}
- (UILabel *)wxLoginLbl{
    if (!_wxLoginLbl) {
        _wxLoginLbl =[[UILabel alloc]init];
        [_wxLoginLbl setText:@"微信登录"];
        [_wxLoginLbl setTextColor:UIColorFromHex(0xC9C9C9)];
    }
    return _wxLoginLbl;
}

#pragma mark 登录
- (void)loginAction{
    FELoginRequestModel *requestModel =[[FELoginRequestModel alloc]init];
    requestModel.mobile =self.accountTxt.text;
    requestModel.pwd =self.passwordTxt.text;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(MobileLoginHttp)  parameters:[requestModel mj_JSONObject] needToken:NO timeout:25 success:^(id  _Nonnull responseObject) {
        [FEUserOperation manager].userModel =[FELoginResponseUserInfoModel mj_objectWithKeyValues:responseObject[@"data"][@"userInfo"]];
        [FEUserOperation manager].token =responseObject[@"data"][@"token"];
        [self dismissViewControllerAnimated:YES completion:nil];
        if ([self.localDelegate respondsToSelector:@selector(LoginSuccess)]) {
            [self.localDelegate LoginSuccess];
        }
    } failure:^(NSError * _Nonnull error) {
        if ([self.localDelegate respondsToSelector:@selector(loginFailed:)]) {
            [self.localDelegate loginFailed:error];
        }
    }];
}

#pragma mark 注册
- (void)registerAction{
    FERegisterAccountVC *registerVC =[[FERegisterAccountVC alloc]init];
    [self.navigationController pushViewController:registerVC animated:YES];
}

#pragma mark 找回密码
- (void)findPassWordAction{
    FEFindPasswordVC *findPassVC =[[FEFindPasswordVC alloc]init];
    [self.navigationController pushViewController:findPassVC animated:YES];
}
@end
