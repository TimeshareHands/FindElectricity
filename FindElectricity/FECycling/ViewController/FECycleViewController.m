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
#import "FEFunction.h"
@interface FECycleViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) FECycleMap *mapView;
@property (weak, nonatomic) IBOutlet UILabel *currentElec;
@property (weak, nonatomic) IBOutlet UILabel *tipLab;
@property (weak, nonatomic) IBOutlet UILabel *todayElec;
@property (weak, nonatomic) IBOutlet UILabel *allElec;
@property (weak, nonatomic) IBOutlet UILabel *currentKM;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UILabel *maxElec;


@property (assign, nonatomic) CLLocationCoordinate2D startCoord;
@end

@implementation FECycleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = nil;
    [self setNavgaTitle:@"骑行赚积分"];
    [self addView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [NetWorkManger manager].senderVC =self;
    [self getCyclingDataRequest];
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
    WEAKSELF;
    [beginBtn bk_addEventHandler:^(id sender) {
        FECycleDetailViewController *detailVC = [[FECycleDetailViewController alloc] init];
        detailVC.startCoord = weakSelf.startCoord;
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
        [_mapView setIsShowMapCenter:NO];
//        _mapView.delegate = self;
//        _mapView.hidden = YES;
        WEAKSELF;
        _mapView.locationUpdateBlock = ^(CLLocation * _Nonnull location, AMapLocationReGeocode * _Nonnull reGeocode, CGFloat locationAngle, NSError * _Nonnull error) {
                MYLog(@"map-location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@;agnle:%f;error:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress,locationAngle,error);
            
            weakSelf.startCoord = location.coordinate;
        };
        _mapView.allowsAnnotationViewSorting = NO;
        [self.mapView startUpdatingLocation];
        _mapView.showsUserLocation = YES;
        _mapView.userTrackingMode = MAUserTrackingModeFollow;
        [_mapView setZoomLevel:15.1 animated:NO];
    }
    return _mapView;
}

- (IBAction)goCycling:(UIButton *)sender {
    [self.mapView setHidden:NO];
}

- (void)getCyclingDataRequest {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(CirclingPanelDataHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf getDataSuccess:responseObject];
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)getDataSuccess:(id)response
{
    //    [SVProgressHUD dismiss];
    NSDictionary *data = (NSDictionary *)response;
    MYLog(@"%@",data);
    if ([data[@"code"] intValue] == KSuccessCode) {
        MTSVPDismiss;
        NSDictionary *elecInfo = data[@"data"];
//        MTSVPShowInfoText(data[@"data"][@"announcement"]);
        if (elecInfo.allKeys)
        {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSInteger kmToElec = [elecInfo[@"kmToElectricity"] integerValue];
            [userDefault setInteger:kmToElec forKey:kFEKMToElecNum];
            NSInteger currentKM = (NSInteger)([userDefault integerForKey:kFECycleKM]);
            NSInteger currentTime = (NSInteger)([userDefault integerForKey:kFECycleTime]);
            _currentElec.text = [NSString stringWithFormat:@"%.2f",currentKM/1000.0*kmToElec];
            _currentTime.text = timeFormt(currentTime);
            NSInteger todayE = [elecInfo[@"todayElectricity"] integerValue];
            NSInteger maxE = [elecInfo[@"maxElectricity"] integerValue];
            NSInteger allE = [elecInfo[@"allElectricity"] integerValue];
            _tipLab.text = [NSString stringWithFormat:@"每骑行1km得%d电量值",kmToElec];
            _maxElec.text = [NSString stringWithFormat:@"%d电量值",maxE];
            _todayElec.text = [NSString stringWithFormat:@"%d",todayE];
            _allElec.text = [NSString stringWithFormat:@"%d",allE];
            _currentKM.text = [NSString stringWithFormat:@"%.2f",currentKM/1000.0];
            if (currentTime>0) {
                _mapView.hidden = YES;
                [userDefault removeObjectForKey:kFECycleTime];
                [userDefault removeObjectForKey:kFECycleKM];
            }else{
                _mapView.hidden = NO;
            }
        }
    }else {
        MTSVPShowInfoText(data[@"msg"]);
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
