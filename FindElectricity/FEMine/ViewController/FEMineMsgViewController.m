//
//  FEMineMsgViewController.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMineMsgViewController.h"
#import "FEMineMsgCell.h"
#import "FEMsgChangeViewController.h"
#import "FEChangePhoneViewController.h"
#import "FESignChangeViewController.h"
#import "FESelectCityViewController.h"
@interface FEMineMsgViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (copy, nonatomic) NSArray *dataSource;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) FEMineMsgCell *avtCell;
@property (weak, nonatomic) FEMineMsgCell *nicknameCell;
@property (weak, nonatomic) FEMineMsgCell *sexCell;
@property (weak, nonatomic) FEMineMsgCell *phoneCell;
@property (weak, nonatomic) FEMineMsgCell *addressCell;
@property (weak, nonatomic) FEMineMsgCell *signCell;
@property (nonatomic, strong) NSData *icon;
@property (strong, nonatomic) FELoginResponseUserInfoModel *userInfo;
@end

@implementation FEMineMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavgaTitle:@"个人信息"];
    [self initData];
    [self addView];
}

- (void)addView {
    
}

- (void)initData {
    _dataSource = @[@[@"头像",@"名称",@"性别",@"电话号码",@"地址"],@[@"签名"]];
}

- (void)showActionWith:(NSInteger)tag
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil, nil];
    actionSheet.tag = tag;
    if (tag == 1) {
        //选择性别
        [actionSheet addButtonWithTitle:@"男"];
        [actionSheet addButtonWithTitle:@"女"];
    }
    else{
        [actionSheet addButtonWithTitle:@"拍照"];
        [actionSheet addButtonWithTitle:@"从手机相册选择"];
    }
    // 同时添加一个取消按钮
    [actionSheet addButtonWithTitle:@"取消"];
    // 将取消按钮的index设置成我们刚添加的那个按钮，这样在delegate中就可以知道是那个按钮
    actionSheet.destructiveButtonIndex = actionSheet.numberOfButtons - 1;
    [actionSheet showInView:self.view];
}

#pragma mark - 判断设备是否有摄像头

- (BOOL)isCameraAvailable
{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}


#pragma mark - UIActionSheet delegate

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag) {
        //性别
        switch (buttonIndex) {
            case 0:
            {
                _sexCell.rightLab.text = @"男";
                [self editInfoFieldName:@"sex" fieldValue:@"1"];
                break;
            }
            case 1:
            {
                _sexCell.rightLab.text = @"女";
                [self editInfoFieldName:@"sex" fieldValue:@"2"];
                break;
            }
                
            default:
                break;
        }
    }else{
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
}

//照相，选图片的delegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *_selectedImage = [[UIImage alloc] init];
    _selectedImage = info[@"UIImagePickerControllerEditedImage"];
    _avtCell.img.image = _selectedImage;
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

#pragma mark --tableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *arr = _dataSource[section];
    return arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"cell";
    FEMineMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell==nil)
    {
        cell = [[NSBundle mainBundle] loadNibNamed:@"FEMineMsgCell" owner:self options:nil][0];
    }
    NSArray *arr = _dataSource[indexPath.section];
    NSString *text = arr[indexPath.row];
    cell.leftLab.text = text;
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                //头像
                cell.img.hidden = NO;
                _avtCell = cell;
                break;
            }
            case 1:
            {
                //名称
                _nicknameCell = cell;
                _nicknameCell.rightLab.text = @"小李";
                break;
            }
            case 2:
            {
                //性别
                _sexCell = cell;
                _sexCell.rightLab.text = @"男";
                break;
            }
            case 3:
            {
                //电话号码
                _phoneCell = cell;
                _phoneCell.rightLab.text = @"15667676668";
                break;
            }
            case 4:
            {
                //地址
                _addressCell = cell;
                _addressCell.rightLab.text = @"长沙";
                break;
            }
            default:
                break;
        }
    }else {
        switch (indexPath.row) {
            case 0:
            {
                //签名
                _signCell = cell;
                _signCell.rightLab.text = @"用户很懒，还没有个性签名";
                break;
            }
            default:
                break;
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:
            {
                //头像
                [self showActionWith:0];
                break;
            }
            case 1:
            {
                //名称
                FEMsgChangeViewController *vc = [[FEMsgChangeViewController alloc] init];
                vc.mscCell = _nicknameCell;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 2:
            {
                //性别
                [self showActionWith:1];
                break;
            }
            case 3:
            {
                //电话号码
                FEChangePhoneViewController *vc = [[FEChangePhoneViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            case 4:
            {
                //地址
                FESelectCityViewController *vc = [[FESelectCityViewController alloc] init];
                vc.mCell = _addressCell;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
        }
    }else {
        switch (indexPath.row) {
            case 0:
            {
                //签名
                FESignChangeViewController *vc = [[FESignChangeViewController alloc] init];
                vc.mscCell = _signCell;
                [self.navigationController pushViewController:vc animated:YES];
                break;
            }
            default:
                break;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headView = [[UIView alloc] init];
    return headView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getUserData];
}

- (void)getUserData {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(UserNewInfoHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        NSDictionary *data = (NSDictionary *)responseObject;
        if ([data[@"code"] intValue] == KSuccessCode) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf setUserInfo:[FELoginResponseUserInfoModel mj_objectWithKeyValues:responseObject[@"data"][@"userInfo"]]];
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                MTSVPShowInfoText(data[@"msg"]);
            });
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)setUserInfo:(FELoginResponseUserInfoModel *)userInfo {
    _userInfo = userInfo;
    [_avtCell.img sd_setImageWithURL:[NSURL URLWithString:_userInfo.faceImg] placeholderImage:[UIImage imageNamed:kFEDefaultImg]];
    _nicknameCell.rightLab.text = _userInfo.nickName;
    _signCell.rightLab.text = _userInfo.signature;
    _sexCell.rightLab.text = [_userInfo.sex isEqualToString:@"1"]?@"男":@"女";
    _phoneCell.rightLab.text = _userInfo.mobile;
    _addressCell.rightLab.text = _userInfo.area;
}

- (void)upLoadIcon{
    [[NetWorkManger manager] uploadImageToQNFileData:_icon success:^(id  _Nonnull responseObject) {
        NSString *data = (NSString *)responseObject;
        if ([data containsString:@"http"]) {
            [self editInfoFieldName:@"faceImg" fieldValue:data];
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                MTSVPShowInfoText(data);
            });
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
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
                
            });
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                MTSVPShowInfoText(data[@"msg"]);
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
