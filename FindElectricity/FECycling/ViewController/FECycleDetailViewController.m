//
//  FECycleDetailViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/9.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FECycleDetailViewController.h"
#import "FECycleMapViewController.h"
#import "FEStopProcessBtn.h"
@interface FECycleDetailViewController ()
@property (weak, nonatomic) IBOutlet FEStopProcessBtn *endBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UIButton *goonBtn;

@end

@implementation FECycleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"骑行倒计时"];
    [self addView];
    CLLocationCoordinate2D dest = (CLLocationCoordinate2D){28.000,112.0000};
    [[FEMapManager manager] getDistanceFromCoord:_startCoord toCoord:dest finishBlock:^(id  _Nonnull response, FEAMapSearchType type, NSError * _Nonnull error) {
        NSArray *arr = ((AMapDistanceSearchResponse *)response).results;
        MYLog(@"%@--count:%d",arr,arr.count);
    }];
}

- (void)addView {
    WEAKSELF;
    _endBtn.endBlock = ^(FEStopProcessBtn * _Nonnull btn) {
        //结束
        [weakSelf endCycling];
    };
}

- (void)endCycling {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)tapAction:(UIButton *)sender {
    if (sender.tag == 0) {
        //展开地图
        FECycleMapViewController *vc = [[FECycleMapViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1) {
        //stop
        sender.hidden = YES;
        _goonBtn.hidden = NO;
        _endBtn.hidden = NO;
        
    }else if(sender.tag == 2) {
        //goon
        _stopBtn.hidden = NO;
        _goonBtn.hidden = YES;
        _endBtn.hidden = YES;
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
