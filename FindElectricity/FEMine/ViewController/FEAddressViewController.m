//
//  FEAddressViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEAddressViewController.h"

@interface FEAddressViewController ()
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *phone;
@property (weak, nonatomic) IBOutlet UITextView *address;
@property (strong, nonatomic) NSDictionary *data;
@end

@implementation FEAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"收货地址"];
    [self getData];
}

- (IBAction)save:(id)sender {
    if (!(_name.text.length&&_phone.text.length&&_address.text.length)) {
        MTSVPShowInfoText(@"请完善信息后提交");
        return;
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:_name.text forKey:@"contacts"];
    [parameter setValue:_phone.text forKey:@"telephone"];
    [parameter setValue:_address.text forKey:@"address"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(AddressSetHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
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

- (void)getData {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(AddressInfoHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
        if ([data[@"code"] intValue] == KSuccessCode) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setData:data[@"data"]];
            });
        }else if ([data[@"code"] intValue] != KTokenFailCode){
            dispatch_async(dispatch_get_main_queue(), ^{
                MTSVPShowInfoText(data[@"msg"]);
            });
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    _name.text = data[@"contacts"];
    _phone.text = data[@"telephone"];
    _address.text = data[@"address"];
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
