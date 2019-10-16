//
//  FEAddShopViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEAddShopViewController.h"
#import "FECycleMap.h"
#import <AMapSearchKit/AMapSearchKit.h>
@interface FEAddShopViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIActionSheetDelegate,MAMapViewDelegate,AMapSearchDelegate>
@property (assign, nonatomic) NSInteger flag;
@property (weak, nonatomic) IBOutlet UILabel *zaoTime;
@property (weak, nonatomic) IBOutlet UILabel *wanTime;
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *telephone;
@property (weak, nonatomic) IBOutlet UITextField *contact;
@property (weak, nonatomic) IBOutlet UITextField *imgName;
@property (weak, nonatomic) IBOutlet UITextField *pcq;
@property (weak, nonatomic) IBOutlet UITextField *address;
@property (weak, nonatomic) IBOutlet UITextField *other;

//view
@property (weak, nonatomic) IBOutlet UIDatePicker *myPicker;
@property (weak, nonatomic) IBOutlet UIView *maskView;

@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *upLoadBtn;
@property (weak, nonatomic) IBOutlet FECycleMap *mapView;

@property (strong, nonatomic) NSString *iconPath;
@property (strong, nonatomic) NSData *icon;
@property (strong, nonatomic) NSMutableArray *serverIds;

@property (nonatomic, strong) AMapSearchAPI *search;
@property (nonatomic, strong) AMapGeoPoint *geoPoint;
@property (nonatomic, strong) AMapReGeocodeSearchResponse *reGeocode;
@end

@implementation FEAddShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"商家入驻"];
    [self initData];
    [self addView];
}

- (void)initData {
    _serverIds = [NSMutableArray array];
}

- (void)addView {
    _tableView.tableHeaderView = _headView;
    
    _upLoadBtn.layer.cornerRadius = 12;
    _upLoadBtn.layer.borderColor = UIColorFromHex(0xa7a7a7).CGColor;
    _upLoadBtn.layer.borderWidth = 1;
    _upLoadBtn.clipsToBounds = YES;
    
    _mapView.showsUserLocation = YES;
    WEAKSELF;
    _mapView.locationUpdateBlock = ^(CLLocation * _Nonnull location, AMapLocationReGeocode * _Nonnull reGeocode, CGFloat locationAngle, NSError * _Nonnull error) {
            MYLog(@"map-location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@;agnle:%f;error:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress,locationAngle,error);
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (reGeocode.city) {
                
            }
            
            if (!weakSelf.geoPoint&&!location)
            {
                weakSelf.geoPoint = [AMapGeoPoint locationWithLatitude:location.coordinate.latitude
                longitude:location.coordinate.longitude];
                [weakSelf regSearchFromCoord:weakSelf.geoPoint];
                [weakSelf.mapView setCenterCoordinate:location.coordinate];
            }
            
        });
    };
    _mapView.delegate = self;
    _mapView.allowsAnnotationViewSorting = NO;
    [_mapView startUpdatingLocation];
//    [_mapView startHeadingLocation];
}

//获取地址信息
- (void)regSearchFromCoord:(AMapGeoPoint *)point {
    if(!_search){
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    AMapReGeocodeSearchRequest *regReq = [[AMapReGeocodeSearchRequest alloc] init];

    regReq.location = point;
    regReq.requireExtension = YES;
    [self.search AMapReGoecodeSearch:regReq];
}

#pragma mark AMapSearchAPI delegete
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        [self setReGeocode:response];
    }
    else{
        
    }
}

- (void)setReGeocode:(AMapReGeocodeSearchResponse *)reGeocode {
    _reGeocode = reGeocode;
    AMapAddressComponent *addCom = reGeocode.regeocode.addressComponent;
    _pcq.text = [NSString stringWithFormat:@"%@ %@ %@",addCom.province,addCom.city,addCom.district];
    _address.text = addCom.township;
}

#pragma mark AMapdelegete
- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    MYLog(@"--lati:%f;longt:%f",mapView.centerCoordinate.latitude,mapView.centerCoordinate.longitude);
    CLLocationCoordinate2D coord = _mapView.centerCoordinate;
    _geoPoint = [AMapGeoPoint locationWithLatitude:coord.latitude longitude:coord.longitude];
    [self regSearchFromCoord:_geoPoint];
}


#pragma mark - 判断设备是否有摄像头

- (BOOL)isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}


#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    switch (buttonIndex) {
        case 0:
        {
            UIImagePickerController *imgPickerC = [[UIImagePickerController alloc]init];
            imgPickerC.editing = YES;
            imgPickerC.allowsEditing = YES;
            imgPickerC.delegate = self;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                imgPickerC.sourceType = UIImagePickerControllerSourceTypeCamera;
                [self presentViewController:imgPickerC animated:YES completion:nil];
            }
            break;
        }
        case 1:
        {
            UIImagePickerController *imgPickerC = [[UIImagePickerController alloc]init];
            imgPickerC.editing = YES;
            imgPickerC.allowsEditing = YES;
            imgPickerC.delegate = self;
            imgPickerC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            [self presentViewController:imgPickerC animated:YES completion:nil];
            break;
        }
            
        default:
            break;
    }
}

//照相，选图片的delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *_selectedImage = [[UIImage alloc] init];
    _selectedImage = info[@"UIImagePickerControllerEditedImage"];
//    _avtCell.img.image = _selectedImage;
    _icon = UIImageJPEGRepresentation(_selectedImage, 0.3);
    // 这里base64Encoding 要修改
//    _iconString = [data base64Encoding];
    [self dismissViewControllerAnimated:YES completion:^{
        [self upLoadIcon];
    }];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
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

- (IBAction)dateAct:(UIButton *)sender
{
    if (sender.tag == 4) {
        _flag = 1;
    }
    else
    {
        _flag = 2;
    }
    [self showMyPicker];
}

//拼接serverID
- (void)serverID:(NSString *)sID isAdd:(BOOL)isAdd {
    if (isAdd) {
        [_serverIds containsObject:sID]? : [_serverIds addObject:sID];
    }else {
        ![_serverIds containsObject:sID]? : [_serverIds removeObject:sID];
    }
}

- (IBAction)btnAction:(UIButton *)sender {
    switch (sender.tag) {
        case 1:
        {
            //快充
            sender.selected = !sender.selected;
            [self serverID:[NSString stringWithFormat:@"%d",sender.tag] isAdd:sender.selected];
            break;
        }
        case 2:
        {
            //普充
            sender.selected = !sender.selected;
            [self serverID:[NSString stringWithFormat:@"%d",sender.tag] isAdd:sender.selected];
            break;
        }
        case 3:
        {
            //维修
            sender.selected = !sender.selected;
            [self serverID:[NSString stringWithFormat:@"%d",sender.tag] isAdd:sender.selected];
            break;
        }
        case 6:
        {
            //上传图片
            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
            
            [actionSheet addButtonWithTitle:@"拍照"];
            [actionSheet addButtonWithTitle:@"从手机相册选择"];
            // 同时添加一个取消按钮
            [actionSheet addButtonWithTitle:@"取消"];
            // 将取消按钮的index设置成我们刚添加的那个按钮，这样在delegate中就可以知道是那个按钮
            actionSheet.destructiveButtonIndex = actionSheet.numberOfButtons - 1;
            [actionSheet showInView:self.view];
            break;
        }
        default:
            break;
    }
}

- (IBAction)save:(id)sender {
    //保存
    
    if (!_reGeocode.regeocode) {
        MTSVPShowInfoText(@"请选择店铺位置")
        return;
    }
    if (_name.text.length == 0) {
        MTSVPShowInfoText(@"请填写商家名称")
        return;
    }
    if (_telephone.text.length != 11) {
        MTSVPShowInfoText(@"请填写正确的电话号码")
        return;
    }
    if (_contact.text.length == 0) {
        MTSVPShowInfoText(@"请填写联系人")
        return;
    }
    if (_iconPath.length == 0) {
        MTSVPShowInfoText(@"请上传招牌图片")
        return;
    }
    if (_serverIds.count == 0) {
        MTSVPShowInfoText(@"选择服务类型");
    }
    NSString *serverId = [_serverIds componentsJoinedByString:@","];
    AMapAddressComponent *addressCom = _reGeocode.regeocode.addressComponent;
    
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:_name.text forKey:@"merchantsName"];
    [parameter setValue:_telephone.text forKey:@"merchantsMobile"];
    [parameter setValue:_contact.text forKey:@"contact"];
    [parameter setValue:serverId forKey:@"serviceId"];
    [parameter setValue:_zaoTime.text forKey:@"openTime"];
    [parameter setValue:_wanTime.text forKey:@"closeTime"];
    [parameter setValue:_iconPath forKey:@"brandImage"];
    [parameter setValue:addressCom.province forKey:@"province"];
    [parameter setValue:addressCom.city forKey:@"city"];
    [parameter setValue:addressCom.district forKey:@"county"];
    [parameter setValue:addressCom.township forKey:@"street"];
    [parameter setValue:@(_geoPoint.longitude) forKey:@"longitude"];
    [parameter setValue:@(_geoPoint.latitude) forKey:@"latitude"];
    [parameter setValue:_other.text forKey:@"note"];
    
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(TenantsHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
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

- (void)upLoadIcon{
    [[NetWorkManger manager] uploadImageToQNFileData:_icon success:^(id  _Nonnull responseObject) {
        NSString *data = (NSString *)responseObject;
        if ([data containsString:@"http"]) {
            _iconPath = data;
            [_upLoadBtn setTitle:@"上传成功" forState:UIControlStateNormal];
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                MTSVPShowInfoText(data);
            });
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
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
