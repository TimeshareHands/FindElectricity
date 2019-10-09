//
//  FECycleViewController.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/4.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FECycleViewController.h"
#import "FECycleMap.h"
#import "FECycleDetailViewController.h"
@interface FECycleViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) FECycleMap *mapView;

@end

@implementation FECycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    [self setNavgaTitle:@"骑行赚积分"];
    [self addView];
}

- (void)addView{
    _tableView.tableHeaderView = _headView;
    [self.view addSubview:self.mapView];
    UIButton *beginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [beginBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [beginBtn setTitle:@"开始" forState:UIControlStateNormal];
    beginBtn.titleLabel.font = MTFont(MTBaseFont, 16);
    beginBtn.backgroundColor = UIColorFromHex(0x04bb2d);
    beginBtn.layer.cornerRadius = 40;
    beginBtn.clipsToBounds = YES;
    [beginBtn bk_addEventHandler:^(id sender) {
        FECycleDetailViewController *detailVC = [[FECycleDetailViewController alloc] init];
        [self.navigationController pushViewController:detailVC animated:YES];
    } forControlEvents:UIControlEventTouchUpInside];
    [self.mapView addSubview:beginBtn];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    [beginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mapView).offset(-20);
        make.centerX.mas_equalTo(self.mapView);
        make.height.width.mas_equalTo(80);
    }];
}

- (FECycleMap *)mapView {
    if (!_mapView) {
        _mapView = [[FECycleMap alloc] init];
        _mapView.delegate = self;
        _mapView.hidden = YES;
        _mapView.allowsAnnotationViewSorting = NO;
        [self.mapView startHeadingLocation];
        _mapView.showsUserLocation = YES;
//        _mapView.userTrackingMode = MAUserTrackingModeFollow;
    }
    return _mapView;
}

- (IBAction)goCycling:(UIButton *)sender {
    [self.mapView setHidden:NO];
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
