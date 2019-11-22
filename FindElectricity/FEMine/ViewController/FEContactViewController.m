//
//  FEContactViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/11/22.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEContactViewController.h"

@interface FEContactViewController ()

@end

@implementation FEContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"联系客服"];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)copyText:(id)sender {
    UIPasteboard *pasteboard = [UIPasteboard generalPasteboard];
    pasteboard.string = @"JQR8998666";
    MTSVPShowInfoText(@"已复制");
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
