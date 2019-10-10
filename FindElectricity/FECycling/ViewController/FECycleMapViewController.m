//
//  FECycleMapViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/9.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FECycleMapViewController.h"
#import "FECycleMap.h"
@interface FECycleMapViewController ()
@property (weak, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) FECycleMap *mapView;
@end

@implementation FECycleMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)addView{
    [self.view addSubview:self.mapView];
    [self.mapView addSubview:_topView];
    UIButton *closeBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeBtn setImage:[UIImage imageNamed:@"cyc_close"] forState:UIControlStateNormal];
    [closeBtn bk_addEventHandler:^(id sender) {
        [self.navigationController popViewControllerAnimated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:closeBtn];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    [closeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mapView).offset(-27);
        make.centerX.mas_equalTo(self.mapView);
        make.height.width.mas_equalTo(50);
    }];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.mapView).offset(25);
        make.right.mas_equalTo(self.mapView).offset(-10);
        make.left.mas_equalTo(self.mapView).offset(10);
        make.height.mas_equalTo(90);
    }];
}

- (FECycleMap *)mapView {
    if (!_mapView) {
        _mapView = [[FECycleMap alloc] init];
        _mapView.delegate = self;
        _mapView.allowsAnnotationViewSorting = NO;
        [_mapView setIsShowMapCenter:NO];
        [self.mapView startHeadingLocation];
//        _mapView.showsUserLocation = YES;
//        _mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    return _mapView;
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
