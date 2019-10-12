//
//  FEFeedbackViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEFeedbackViewController.h"
#import "SZTextView.h"
@interface FEFeedbackViewController ()
@property (weak, nonatomic) IBOutlet SZTextView *text;

@end

@implementation FEFeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"意见建议"];
}


- (IBAction)submit:(id)sender {
    if (_text.text.length==0) {
        MTSVPShowInfoText(@"请输入意见或建议");
        return;
    }
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:_text.text forKey:@"content"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(AddAdviceHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
        if ([data[@"code"] intValue] == KSuccessCode) {
            MTSVPShowSuccessWithText(@"提交成功");
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }else {
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
