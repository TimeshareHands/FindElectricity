//
//  FEAddShopViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEAddShopViewController.h"
#import "FECycleMap.h"
@interface FEAddShopViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (assign, nonatomic) NSInteger flag;
@property (weak, nonatomic) IBOutlet UILabel *zaoTime;
@property (weak, nonatomic) IBOutlet UILabel *wanTime;
//view
@property (weak, nonatomic) IBOutlet UIDatePicker *myPicker;
@property (weak, nonatomic) IBOutlet UIView *maskView;

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *upLoadBtn;
@property (weak, nonatomic) IBOutlet FECycleMap *mapView;

@end

@implementation FEAddShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"商家入驻"];
    [self addView];
}

- (void)addView {
    _tableView.tableHeaderView = _headView;
    
    _upLoadBtn.layer.cornerRadius = 12;
    _upLoadBtn.layer.borderColor = UIColorFromHex(0xa7a7a7).CGColor;
    _upLoadBtn.layer.borderWidth = 1;
    _upLoadBtn.clipsToBounds = YES;
}

- (IBAction)dateAct:(UIButton *)sender
{
    if (sender.tag == 1) {
        _flag = 1;
    }
    else
    {
        _flag = 2;
    }
    [self showMyPicker];
}

#pragma mark - private method
- (void)showMyPicker
{
    self.maskView.hidden = NO;
    
}

- (void)hideMyPicker {
    self.maskView.hidden = YES;
}

- (IBAction)cancel:(id)sender {
    [self hideMyPicker];
}

- (IBAction)ensure:(id)sender {
    NSDate *date = _myPicker.date;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"HH:mm"];
    NSString *time = [dateFormatter stringFromDate:date];
    if (_flag == 1) {
        _zaoTime.text = time;
    }else
    {
        _wanTime.text = time;
    }
    [self hideMyPicker];
}

- (IBAction)save:(id)sender {
    //保存
    
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
