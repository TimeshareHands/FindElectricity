//
//  FEChangePhoneViewController.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEChangePhoneViewController.h"

@interface FEChangePhoneViewController ()
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextField *msCode;
@property (weak, nonatomic) IBOutlet UIButton *sendCode;

@end

@implementation FEChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"修改手机号"];
    [self rightBtnWithTitle:@"完成" target:self action:@selector(comfirm) color:UIColorFromHex(0x404040)];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}

- (IBAction)sendMsCode:(UIButton *)sender {
    sender.enabled = NO;
    NSString *phone = [self.phone.text eliminateSpace];
    if (phone.length!= 11) {
        MTSVPShowInfoText(@"请填写正确的手机号码");
        return;
    }
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:phone forKey:@"mobile"];
    [parameter setValue:@"CHANGEMOBILE" forKey:@"type"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(SendCodeHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
        if ([data[@"code"] intValue] == KSuccessCode) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                MTSVPShowSuccessWithText(@"发送成功");
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(30 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    sender.enabled = YES;
                });
            });
        }else if ([data[@"code"] intValue] != KTokenFailCode){
            dispatch_async(dispatch_get_main_queue(), ^{
                MTSVPShowInfoText(data[@"msg"]);
            });
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

- (void)comfirm
{
    NSString *phone = [self.phone.text eliminateSpace];
    NSString *code = [self.msCode.text eliminateSpace];
    if (!phone.length&&!code.length) {
        MTSVPShowInfoText(@"请完善信息");
        return;
    }
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:code forKey:@"verifyCode"];
    [parameter setValue:phone forKey:@"mobile"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(ChangeMobileHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
        if ([data[@"code"] intValue] == KSuccessCode) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }else if ([data[@"code"] intValue] != KTokenFailCode){
            dispatch_async(dispatch_get_main_queue(), ^{
                MTSVPShowInfoText(data[@"msg"]);
            });
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
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
