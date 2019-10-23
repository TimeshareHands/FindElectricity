//
//  FERegisterAccountVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/8.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FERegisterAccountVC.h"
#import "FESmsCodeCell.h"
#import "FEInputCell.h"
#import "UIButton+Extend.h"
@interface FERegisterAccountVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)UIButton *confirmBtn;
@property(nonatomic, strong)FESmsCodeCell *smsCodeCell;
@property(nonatomic, strong)FEInputCell *smsInputCell;
@property(nonatomic, strong)FEInputCell *passwordCell;
@property(nonatomic, strong)FEInputCell *invCodeCell;
@end

@implementation FERegisterAccountVC

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
#pragma mark --添加视图
- (void)addView{
    self.title  =@"注册账号";
    [self.view addSubview:self.myTableView];
    [self makeUpConstriant];
}
#pragma mark --约束适配
- (void)makeUpConstriant{
    [self.myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}
#pragma mark --getter
-(UITableView *)myTableView{
    if (!_myTableView) {
        _myTableView =[[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStylePlain];
        [_myTableView setDelegate:self];
        [_myTableView setDataSource:self];
        [_myTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    }
    return _myTableView;
}
-(UIButton *)confirmBtn{
    if (!_confirmBtn) {
        _confirmBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_confirmBtn setTitle:@"立即注册" forState:UIControlStateNormal];
        [_confirmBtn setBackgroundColor:UIColorFromHex(0x03bf30)];
        [_confirmBtn.layer setCornerRadius:10];
        WEAKSELF;
        [_confirmBtn bk_addEventHandler:^(id sender) {
            [weakSelf registerAction];
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _confirmBtn;
}
#pragma tableViewDelegate &&tableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kCellIndetify =@"cellIndentify";
       UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
       if (cell ==nil) {
           if (indexPath.row ==0) {
               self.smsCodeCell =[[FESmsCodeCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
               WEAKSELF;
                [_smsCodeCell.smsBtn bk_addEventHandler:^(id sender) {
                    [weakSelf yanZMBtnAction];
                } forControlEvents:UIControlEventTouchUpInside];
               cell =self.smsCodeCell;
           }else if(indexPath.row ==1){
                self.smsInputCell =[[FEInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
               [self.smsInputCell.inputTextField setPlaceholder:@"请输入验证码"];
               cell =self.smsInputCell;
           }else if(indexPath.row ==2){
               self.passwordCell =[[FEInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
               [self.passwordCell.inputTextField setPlaceholder:@"请输入新密码"];
               cell =self.passwordCell;
           }else{
               self.invCodeCell =[[FEInputCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:kCellIndetify];
               [self.invCodeCell.inputTextField setPlaceholder:@"邀请码（选填）"];
               cell =self.invCodeCell;
           }
            
       }
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footView =[[UIView alloc]init];
    [footView addSubview:self.confirmBtn];
    [self.confirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(15);
        make.right.mas_equalTo(-15);
        make.height.mas_equalTo(45);
        make.top.mas_equalTo(20);
    }];
    return footView;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 100;
}
#pragma mark -
#pragma mark 点击事件
- (void)yanZMBtnAction {
    
    if ([self.smsCodeCell.inputTextField.text checkPhoneNumInput]) {
        [self.smsCodeCell.smsBtn startWithSecondTime:59 title:@"获取验证码"  countDownTitle:@"s" mainColor:UIColorFromHex(0xC9C9C9) countColor:[UIColor lightGrayColor]];
        
        NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
        [parameters setObject:self.smsCodeCell.inputTextField.text forKey:@"mobile"];
        [parameters setObject:@"BIND" forKey:@"type"];
        [parameters setObject:@"MEM" forKey:@"appType"];
        [[NetWorkManger manager]postDataWithUrl:BASE_URLWith(SendCodeHttp) parameters:parameters needToken:NO timeout:25 success:^(id  _Nonnull responseObject) {
            
        } failure:^(NSError * _Nonnull error) {
        
        }];
       
        
    } else {
        [self showHint:@"手机号码不正确"];
    }
    
}
- (BOOL)checkContent {
    
    if (![self.smsCodeCell.inputTextField.text checkPhoneNumInput]) {
        
        [self showHint:@"手机号码不正确"];
        return NO;
    }
    
    
      if (self.smsInputCell.inputTextField.text.length<3) {
           
           [self showHint:@"请输入正确的验证码"];
           return NO;
       }
       if ([self.passwordCell.inputTextField.text containStr:@" "]) {
            [self showHint:@"密码不能包含空格" ];
       }
       
       if ([self.smsInputCell.inputTextField.text containStr:@" "]) {
           
           [self showHint:@"验证码不能包含空格" ];
           return NO;
       }
    
    
    return YES;
}
#pragma mark 注册
- (void)registerAction{
    if ([self checkContent]) {
        FERegisterRequestModel *requestModel =[[FERegisterRequestModel alloc]init];
        requestModel.verifyCode =self.smsInputCell.inputTextField.text;
        requestModel.invCode =self.invCodeCell.inputTextField.text;
        requestModel.pwd =self.passwordCell.inputTextField.text;
        requestModel.mobile =self.smsCodeCell.inputTextField.text;
        [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(MobileRegisterHttp)  parameters:[requestModel mj_JSONObject] needToken:NO timeout:25 success:^(id  _Nonnull responseObject) {
            NSDictionary *data = (NSDictionary *)responseObject;
             if ([data[@"code"] intValue] == KSuccessCode) {
             MTSVPDismiss;
                 [self.navigationController popViewControllerAnimated:YES];
             }else {
                  MTSVPShowInfoText(data[@"msg"]);
             }
          
        } failure:^(NSError * _Nonnull error) {
            
        }];
  }
}
@end
