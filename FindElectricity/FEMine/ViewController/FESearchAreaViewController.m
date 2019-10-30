//
//  FESearchAreaViewController.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/30.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FESearchAreaViewController.h"
#import "FEMapManager.h"
@interface FESearchAreaViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (copy, nonatomic) NSMutableArray *dataSource;
@property (strong, nonatomic) dispatch_queue_t queue;
@end

@implementation FESearchAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tableView.estimatedRowHeight = 44;
    _tableView.tableFooterView = [[UIView alloc] init];
    _queue = dispatch_queue_create("findelct.com", NULL);
    // Do any additional setup after loading the view from its nib.
}

- (void)searchAreaWithText:(NSString *)keyword {
    dispatch_async(_queue, ^{
        [[FEMapManager manager] poiSearchKeywords:keyword location:_loc finishBlock:^(id  _Nonnull response, FEAMapSearchType type, NSError * _Nonnull error) {
            AMapPOISearchResponse *poi = (AMapPOISearchResponse *)response;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self getPOIData:poi];
            });
        }];
    });
}

- (void)getPOIData:(AMapPOISearchResponse *)respon {
    _dataSource = [NSMutableArray arrayWithArray:respon.pois];
    [_tableView reloadData];
}

#pragma mark --- UITextDelegate
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    NSString *key = [textField.text stringByReplacingCharactersInRange:range withString:string];
    [self  searchAreaWithText:textField.text];
    return YES;
}

- (void)textFieldDidChangeSelection:(UITextField *)textField {
    [self  searchAreaWithText:textField.text];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self  searchAreaWithText:textField.text];
    return YES;
}

- (IBAction)cancel:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark --tableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    AMapPOI *poi = _dataSource[indexPath.row];
    cell.textLabel.text = poi.name;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    AMapPOI *poi = _dataSource[indexPath.row];
    if (_selectArea) {
        _selectArea(poi);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
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
