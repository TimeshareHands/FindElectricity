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
#import "FETimeManager.h"
#import "FEFunction.h"
@protocol FECycleDetailVCDelegete <NSObject>
- (void)updateUIDataWithTime:(NSString *)time km:(NSString *)km elec:(NSString *)elec speed:(NSString *)spend;
@end
@interface FECycleDetailViewController ()
@property (weak, nonatomic) IBOutlet FEStopProcessBtn *endBtn;
@property (weak, nonatomic) IBOutlet UIButton *stopBtn;
@property (weak, nonatomic) IBOutlet UIButton *goonBtn;

@property (weak, nonatomic) IBOutlet UILabel *currentElec;
@property (weak, nonatomic) IBOutlet UILabel *speed;
@property (weak, nonatomic) IBOutlet UILabel *currentKM;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;

@property (assign, nonatomic) CGFloat kmNum;
@property (assign, nonatomic) NSTimeInterval sec;
@property (weak,nonatomic) id<FECycleDetailVCDelegete> delegete;
@end

@implementation FECycleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"骑行倒计时"];
    [self addView];
    [self getDistance:(CLLocationCoordinate2D){28.000,112.0000}];
    _sec = 1;
    FETimeManager *timeManager = [FETimeManager shareManager];
    [timeManager startTiming];
    WEAKSELF;
    timeManager.timeRunBlock = ^(NSTimeInterval sec) {
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.sec = sec;
            [weakSelf updateData];
        });
    };
}

//更新数据
- (void)updateData{
    self.currentTime.text = timeFormt(_sec);
    self.currentKM.text = [NSString stringWithFormat:@"%.2f",_kmNum];
    self.speed.text = [NSString stringWithFormat:@"%.2f",_kmNum/_sec];
    NSInteger changNum = [[NSUserDefaults standardUserDefaults] integerForKey:kFEKMToElecNum];
    self.currentElec.text = [NSString stringWithFormat:@"%.0f",_kmNum/changNum];
    if (_delegete&&[_delegete respondsToSelector:@selector(updateUIDataWithTime:km:elec:speed:)]) {
        [_delegete updateUIDataWithTime:self.currentTime.text km:self.currentKM.text elec:self.currentElec.text speed:self.speed.text];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)getDistance:(CLLocationCoordinate2D) destCoord{
    WEAKSELF;
    [[FEMapManager manager] getDistanceFromCoord:_startCoord toCoord:destCoord finishBlock:^(id  _Nonnull response, FEAMapSearchType type, NSError * _Nonnull error) {
        NSArray *arr = ((AMapDistanceSearchResponse *)response).results;
        MYLog(@"%@--count:%d",arr,arr.count);
        if (arr.count) {
            AMapDistanceResult *distance = [arr firstObject];
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.kmNum = distance.distance;
                [weakSelf updateData];
            });
        }
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
    [[FETimeManager shareManager] endTiming];
    [self submitCyclingDataRequest];
}

- (IBAction)tapAction:(UIButton *)sender {
    if (sender.tag == 0) {
        //展开地图
        FECycleMapViewController *vc = [[FECycleMapViewController alloc] init];
        self.delegete = vc;
        [self.navigationController pushViewController:vc animated:YES];
    }else if (sender.tag == 1) {
        //stop
        sender.hidden = YES;
        _goonBtn.hidden = NO;
        _endBtn.hidden = NO;
        [[FETimeManager shareManager] stopTiming];
        
    }else if(sender.tag == 2) {
        //goon
        _stopBtn.hidden = NO;
        _goonBtn.hidden = YES;
        _endBtn.hidden = YES;
        [[FETimeManager shareManager] goonTiming];
    }
}

- (void)submitCyclingDataRequest {
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(CirclingSubHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc{
    [[FETimeManager shareManager] endTiming];
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
