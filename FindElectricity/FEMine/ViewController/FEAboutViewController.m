//
//  FEAboutViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEAboutViewController.h"

@interface FEAboutViewController ()
@property (weak, nonatomic) IBOutlet UIButton *getUpdateBtn;
@property (weak, nonatomic) IBOutlet UILabel *version;

@end

@implementation FEAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"关于找电"];
    _getUpdateBtn.layer.cornerRadius = 7.5;
    _getUpdateBtn.layer.borderColor = [[UIColor colorWithRed:40.0f/255.0f green:184.0f/255.0f blue:136.0f/255.0f alpha:1.0f] CGColor];
    _getUpdateBtn.layer.borderWidth = 1.5;
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
