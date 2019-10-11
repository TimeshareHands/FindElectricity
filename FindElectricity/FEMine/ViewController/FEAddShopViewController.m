//
//  FEAddShopViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEAddShopViewController.h"
#import "FECycleMap.h"
@interface FEAddShopViewController ()
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


- (IBAction)save:(id)sender {
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
