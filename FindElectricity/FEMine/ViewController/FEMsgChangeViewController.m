//
//  FEMsgChangeViewController.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMsgChangeViewController.h"

@interface FEMsgChangeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *intpuTF;
@end

@implementation FEMsgChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"昵称"];
    [self rightBtnWithTitle:@"完成" target:self action:@selector(comfirm) color:UIColorFromHex(0x404040)];
    self.intpuTF.text = self.mscCell.rightLab.text;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self.intpuTF becomeFirstResponder];
}

- (void)comfirm
{
    NSString *str = self.intpuTF.text;
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    if (!str.length) {
        MTSVPShowInfoText(@"请输入内容");
        return;
    }
    
    if (self.mscCell) {
        self.mscCell.rightLab.text = str;
    }
    
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
