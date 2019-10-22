//
//  FEMapNaviViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/9/26.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMapNaviViewController.h"

@interface FEMapNaviViewController ()<AMapNaviRideViewDelegate>
//


@end

@implementation FEMapNaviViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.rideView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (AMapNaviRideView *)rideView
{
    if (_rideView == nil)
    {
        _rideView = [[AMapNaviRideView alloc] init];
        _rideView.frame = self.view.frame;
        _rideView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [_rideView setDelegate:self];
//        [_rideView setShowGreyAfterPass:YES];
//        [_rideView setAutoZoomMapLevel:YES];
        [_rideView setTrackingMode:AMapNaviViewTrackingModeCarNorth];
//        [_rideView setMapViewModeType:AMapNaviViewMapModeTypeDayNightAuto];
    }
    return _rideView;
}

#pragma mark - rideView Delegate

- (void)rideViewCloseButtonClicked:(AMapNaviRideView *)rideView
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(rideNaviViewCloseButtonClicked)])
    {
        [self.delegate rideNaviViewCloseButtonClicked];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)prefersStatusBarHidden{
    return YES;
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
