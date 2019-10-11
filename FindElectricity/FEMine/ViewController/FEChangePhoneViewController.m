//
//  FEChangePhoneViewController.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEChangePhoneViewController.h"

@interface FEChangePhoneViewController ()

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

- (void)comfirm
{
//    NSString *str = self.intpuTF.text;
//
//    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
//
//    if (!str.length) {
//        MTSVPShowInfoText(@"请输入内容");
//        return;
//    }
    
    [self.navigationController popViewControllerAnimated:YES];
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
