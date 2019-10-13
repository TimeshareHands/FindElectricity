//
//  FESelectCityViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/11.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FESelectCityViewController.h"
#import "TLCity.h"
@interface FESelectCityViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *data;
@property (nonatomic, strong) NSArray *cityNameAry;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
//@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) NSString *currentCity;

//shuju
@property (nonatomic, strong) NSMutableArray *tabViewMuArray;
@property (nonatomic, strong) NSMutableArray *cityData;
@property (nonatomic, strong) NSMutableArray *arraySection;
@end

@implementation FESelectCityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"城市选择";
    [self addView];
    _currentCity = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentCity];
//    [self getCurrentCity];
}

//- (void)getCurrentCity
//{
//    _locationManager = [[CLLocationManager alloc]init];
//    _locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;
//    _locationManager.delegate = self;
//    [_locationManager startUpdatingLocation];
//}

//定位协议
//- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
//{
//    CLLocation *currentLoc = [locations lastObject];
//    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
//    [geocoder reverseGeocodeLocation:currentLoc completionHandler:^(NSArray *placemarks, NSError *error) {
//        CLPlacemark *placemark = [placemarks lastObject];
//        _currentCity = placemark.locality;
//        MyLog(@"%@",_currentCity);
//        [self.tableView reloadData];
//    }];
////    [_locationManager stopUpdatingLocation];
////    [self.tableView reloadData];
//}

#pragma mark addView
- (void)addView
{
    // 添加
    _tableView.sectionIndexColor = [UIColor blackColor];
    _tableView.sectionIndexBackgroundColor = [UIColor clearColor];
    
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.data.count + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section < 1) {
        return 1;
    }
    TLCityGroup *group = [self.data objectAtIndex:section - 1];
    return group.arrayCitys.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell==nil)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.section) {
        TLCityGroup *group = [self.data objectAtIndex:indexPath.section - 1];
        TLCity *city =  [group.arrayCitys objectAtIndex:indexPath.row];
        [cell.textLabel setText:city.cityName];
    }
    else
    {
        if (_currentCity==nil)
        {
            cell.textLabel.text = @"长沙";
        }
        else
        {
            cell.textLabel.text = _currentCity;
        }
    }
    return cell;
}

#pragma mark UITableViewDelegate
- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *lab = [[UILabel alloc]init];
    lab.backgroundColor = UIColorFromHex(0xf2f2f2);
    if (section==0) {
        lab.text = @"  定位城市";
    }
    else
    {
        NSString *title = [_arraySection objectAtIndex:section];
        lab.text = [NSString stringWithFormat:@"  %@",title];
    }
    return lab;
}

//- (UIView *) tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UILabel *lab = [[UILabel alloc]init];
//    lab.backgroundColor = UIColorFromHex(0xf2f2f2);
//    if (section==0) {
//        lab.text = @"  请选择城市";
//    }
//    else
//    {
//        
//    }
//    return lab;
//}

- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 45;
}

//- (CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
//{
//    if (section == 0)
//    {
//        return 45;
//    }
//    else
//    {
//        return 0;
//    }
//}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *area = @"";
    if (indexPath.section==0)
    {
        area = _currentCity;
    }
    else
    {
        TLCityGroup *group = [self.data objectAtIndex:indexPath.section - 1];
        TLCity *city = [group.arrayCitys objectAtIndex:indexPath.row];
        area = city.cityName;
    }
    
    [self editInfoFieldName:@"area" fieldValue:area];
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return self.arraySection;
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
//    if(index == 0) {
//        [self.tableView scrollRectToVisible:self.searchController.searchBar.frame animated:NO];
//        return -1;
//    }
    return index;
}

- (NSMutableArray *) data
{
    if (_data == nil) {
        NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"CityData" ofType:@"plist"]];
        _data = [[NSMutableArray alloc] init];
        for (NSDictionary *groupDic in array) {
            TLCityGroup *group = [[TLCityGroup alloc] init];
            group.groupName = [groupDic objectForKey:@"initial"];
            for (NSDictionary *dic in [groupDic objectForKey:@"citys"]) {
                TLCity *city = [[TLCity alloc] init];
                city.cityID = [dic objectForKey:@"city_key"];
                city.cityName = [dic objectForKey:@"city_name"];
                city.shortName = [dic objectForKey:@"short_name"];
                city.pinyin = [dic objectForKey:@"pinyin"];
                city.initials = [dic objectForKey:@"initials"];
                [group.arrayCitys addObject:city];
                [self.cityData addObject:city];
            }
            [self.arraySection addObject:group.groupName];
            [_data addObject:group];
        }
    }
    return _data;
}

- (NSMutableArray *) cityData
{
    if (_cityData == nil) {
        _cityData = [[NSMutableArray alloc] init];
    }
    return _cityData;
}

- (NSMutableArray *) arraySection
{
    if (_arraySection == nil) {
        _arraySection = [[NSMutableArray alloc] initWithObjects: @"定位", nil];
    }
    return _arraySection;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)editInfoFieldName:(NSString *)fieldName fieldValue:(NSString *)fieldValue {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:fieldName forKey:@"fieldName"];
    [parameter setValue:fieldValue forKey:@"fieldValue"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(EditInfoHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
        if ([data[@"code"] intValue] == KSuccessCode) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakSelf.navigationController popViewControllerAnimated:YES];
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                MTSVPShowInfoText(data[@"msg"]);
            });
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
