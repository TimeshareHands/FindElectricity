//
//  FECycleDetailViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/9.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FECycleDetailViewController.h"
#import "FECycleMapViewController.h"
@interface FECycleDetailViewController ()

@end

@implementation FECycleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"骑行倒计时"];
}
- (IBAction)tapAction:(UIButton *)sender {
    if (sender.tag == 0) {
        //展开地图
        FECycleMapViewController *vc = [[FECycleMapViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1) {
        //stop
        
    }else if(sender.tag == 2) {
        //goon
        
    }
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
