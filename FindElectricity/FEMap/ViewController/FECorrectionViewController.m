//
//  FECorrectionViewController.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FECorrectionViewController.h"
#import "CSMessageCell.h"
#import "CSMessageModel.h"
#import "CSBigView.h"
#import "EmojiView.h"
#import "CSRecord.h"
#import "FEMapInfoModel.h"
@interface FECorrectionViewController ()<UITextViewDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,CSMessageCellDelegate, EmojiViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *telephone;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIImageView *shopImg;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, assign) CGFloat nowHeight;
@property (nonatomic, strong) UIImageView *photoImageView;
@property (nonatomic, weak) UITextView *textView;
@property (nonatomic, strong) CSBigView *bigImageView;
@property (nonatomic, strong) EmojiView *ev;
@property (nonatomic, strong) UIImage *photoImage;
@property (nonatomic, strong) NSIndexPath *selectIndex;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableBottomConstraint;
@property (strong, nonatomic) FEMapInfoModel *shopInfo;
@end

@implementation FECorrectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"纠错"];
    [self addView];
    [self getData];
}

- (void)getData {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:_mapId forKey:@"mapId"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(CorrectionContentHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf getDataSuccess:responseObject];
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - 请求返回数据
- (void)getDataSuccess:(id)response
{
    //    [SVProgressHUD dismiss];
    NSDictionary *data = (NSDictionary *)response;
    MYLog(@"%@",data);
    if ([data[@"code"] intValue] == KSuccessCode) {
        MTSVPDismiss;
        NSArray *array = data[@"data"][@"list"];
        FEMapInfoModel *info = [FEMapInfoModel mj_objectWithKeyValues:data[@"data"][@"mapInfo"]];
        [self setShopInfo:info];
        CSMessageModel *model;
        for (NSDictionary *cont in array) {
            model = [[CSMessageModel alloc] init];
            model.showMessageTime=YES;
            model.messageSenderType = [cont[@"type"] integerValue];
            NSString *text = cont[@"content"];
            model.messageType = text.length?MessageTypeText:MessageTypeImage;
            model.imageUrl = cont[@"picture"];
            model.messageText = text;
            model.messageTime = cont[@"cTime"];
            [_dataArray addObject:model];
        }
        [_tableView reloadData];
    }else {
        MTSVPShowInfoText(data[@"msg"]);
    }
}

- (void)setShopInfo:(FEMapInfoModel *)shopInfo {
    _shopInfo = shopInfo;
    [_shopImg sd_setImageWithURL:[NSURL URLWithString:_shopInfo.brandImage] placeholderImage:[UIImage imageNamed:kFEDefaultImg]];
    _name.text = _shopInfo.merchantsName;
    _address.text = [NSString stringWithFormat:@"%@",_shopInfo.area];
    _telephone.text = [NSString stringWithFormat:@"%@",_shopInfo.merchantsMobile];
}

- (void)addView {
    _dataArray = [NSMutableArray array];
    _tableView.tableHeaderView = _headView;
    _tableView.backgroundColor = [[UIColor alloc] initWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    
    
    _bigImageView = [[CSBigView alloc] init];
    _bigImageView.frame = [UIScreen mainScreen].bounds;
    
    _ev = [[EmojiView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 180, SCREEN_WIDTH, 180)];
    _ev.hidden = YES;
    _ev.delegate = self;
    [self.view addSubview:_ev];
    
    _tableView.separatorColor = [UIColor clearColor];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}


-(void)keyboardWillShow:(NSNotification *)aNotification
{
    _ev.hidden = YES;
    //获取键盘的高度
    NSDictionary *userInfo = [aNotification userInfo];
    NSValue *aValue = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [aValue CGRectValue];
    int height = keyboardRect.size.height;
    _tableBottomConstraint.constant = -44 - height;
    UIView *vi = [self.view viewWithTag:100];
    CGRect rec = vi.frame ;
    rec.origin.y = _nowHeight - height;
    vi.frame = rec;
}
- (void)keyboardWillHide:(NSNotification *)aNotification
{
    _ev.hidden = YES;
    _tableBottomConstraint.constant = -44;
    UIView *vi = [self.view viewWithTag:100];
    vi.frame = CGRectMake(0, _nowHeight, [UIScreen mainScreen].bounds.size.width, 44);
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    UIView *vi = [self.view viewWithTag:100];
    if (!vi)
    {
        _nowHeight =  _tableView.frame.size.height;
        [self bottomView];
    }
    
}

#pragma mark -
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSMessageCell *cell=[CSMessageCell cellWithTableView:tableView messageModel:_dataArray[indexPath.row]];
    cell.delegate = self;
//    cell
    cell.backgroundColor = [[UIColor alloc] initWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CSMessageModel *model = _dataArray[indexPath.row];
    return [model cellHeight];
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}
- (void)messageCellSingleClickedWith:(CSMessageCell *)cell
{
    
    [self.view endEditing:YES];
    
    
    if (_ev.hidden == NO)
    {
        _ev.hidden = YES;
        _tableBottomConstraint.constant = -44;
        UIView *vi = [self.view viewWithTag:100];
        vi.frame = CGRectMake(0, _nowHeight, [UIScreen mainScreen].bounds.size.width, 44);
    }
    
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    CSMessageModel *model = _dataArray[indexPath.row];
    if (model.messageType == MessageTypeVoice)
    {
        [[CSRecord ShareCSRecord] playRecord];
        
        if ([_selectIndex isEqual: indexPath] == NO)
        {
            
            CSMessageCell *cell1 = [self.tableView cellForRowAtIndexPath:_selectIndex];
            [cell1 stopVoiceAnimation];
            
            _selectIndex = indexPath;
            [cell startVoiceAnimation];
        }
        else
        {
            if (cell.voiceAnimationImageView.isAnimating)
            {
                [cell stopVoiceAnimation];
            }
            else
            {
                [cell startVoiceAnimation];
            }
        }
    }
    else if (model.messageType == MessageTypeImage)
    {
//        _bigImageView.bigImageView.image = model.imageSmall;
//        _bigImageView.show = YES;
        
//        [[UIApplication sharedApplication].keyWindow bringSubviewToFront:_bigImageView];
    }
    
}

-(void)bottomView
{
    UIView *bgView = [[UIView alloc] initWithFrame:CGRectMake(0, _nowHeight, [UIScreen mainScreen].bounds.size.width, 44)];
    bgView.tag = 100;
    bgView.backgroundColor = UIColorFromHex(0xf0f0f0);
    bgView.layer.masksToBounds = YES;
    bgView.layer.borderColor = [[UIColor alloc] initWithRed:235/255.0 green:235/255.0 blue:235/255.0 alpha:1].CGColor;
    bgView.layer.borderWidth = 1;
    [self.view addSubview:bgView];
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(49, 0, bgView.bounds.size.width - 60-49, 44)];
    textView.delegate = self;
    textView.tag = 101;
    textView.textColor = UIColorFromHex(0x404040);
    textView.returnKeyType = UIReturnKeySend;
    textView.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    textView.text = @"";
    [bgView addSubview:textView];
    _textView = textView;


    
//    UIButton *recordBtn = [[UIButton alloc] init];
//    recordBtn.frame = CGRectMake(10, 5, 34, 34);
//    [recordBtn setBackgroundImage:[UIImage imageNamed:@"record"] forState:UIControlStateNormal];
//    [recordBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [recordBtn addTarget:self action:@selector(leaveBtnClicked:) forControlEvents:UIControlEventTouchUpInside | UIControlEventTouchUpOutside];
//    [recordBtn addTarget:self action:@selector(touchDown:)forControlEvents: UIControlEventTouchDragInside];
//    [bgView addSubview:recordBtn];
//
    
    UIButton *imageBtn = [[UIButton alloc] init];
    imageBtn.frame = CGRectMake(10, 5, 34, 34);
    [imageBtn setBackgroundImage:[UIImage imageNamed:@"image"] forState:UIControlStateNormal];
    [imageBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    imageBtn.tag = 13;
    [bgView addSubview:imageBtn];
    
    UIButton *sendBtn = [[UIButton alloc] init];
    sendBtn.frame = CGRectMake(SCREEN_WIDTH - 54-10, 5, 60, 34);
    [sendBtn setTitle:@"发送" forState:UIControlStateNormal];
    [sendBtn setBackgroundColor:UIColorFromHex(0x04bb2d)];
    [sendBtn addTarget:self action:@selector(sendText) forControlEvents:UIControlEventTouchUpInside];
    sendBtn.layer.cornerRadius = 5;
    sendBtn.clipsToBounds = YES;
    sendBtn.tag = 12;
    [bgView addSubview:sendBtn];
}

- (void)sendText{
    if (_textView.text.length == 0)
    {
        return ;
    }
    CSMessageModel *model = [[CSMessageModel alloc] init];
    model.showMessageTime=YES;
    model.messageSenderType = MessageSenderTypeMe;
    model.messageType = MessageTypeText;
    model.messageText = _textView.text;
    model.messageTime = [self currentDateStringWithFormat:@"YYYY-MM-dd"];
    [_dataArray addObject:model];
    [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:_dataArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count - 1 inSection:0]
                                animated:YES
                          scrollPosition:UITableViewScrollPositionMiddle];
   [self sendMsg:model.messageText type:MessageTypeText];
    _textView.text = @"";
}

- (void)sendMsg:(id)msg type:(MessageType) type{
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:_mapId forKey:@"mapId"];
    WEAKSELF;
    if (type == MessageTypeImage) {
        [[NetWorkManger manager] uploadImageToQNFileData:UIImageJPEGRepresentation(_photoImage, 0.4) success:^(id  _Nonnull responseObject) {
            [parameter setValue:@"" forKey:@"content"];
            [parameter setValue:(NSString *)responseObject forKey:@"picture"];
            [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(MapCorrectionHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                });
                
            } failure:^(NSError * _Nonnull error) {
                
            }];
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }else{
        [parameter setValue:(NSString *)msg forKey:@"content"];
        [parameter setValue:@"" forKey:@"picture"];
        [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(MapCorrectionHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSDictionary *data = (NSDictionary *)responseObject;
                    MYLog(@"%@",data);
                    if ([data[@"code"] intValue] == KSuccessCode) {
                        
                    }else {
                        MTSVPShowInfoText(data[@"msg"]);
                    }
            });
            
        } failure:^(NSError * _Nonnull error) {
            
        }];
    }
    
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"])
    {
        if (textView.text.length == 0)
        {
            return NO;
        }
        [self sendText];
        return NO;
    }
    
    return YES;
}
static int iiii = 0;
- (void)touchDown:(UIButton *)btn
{
    if (iiii == 0)
    {
        [[CSRecord ShareCSRecord] beginRecord];
        iiii = 1;
    }
    
}
- (void)leaveBtnClicked:(UIButton *)btn
{
    iiii = 0;
    NSLog(@"松开了");
    [[CSRecord ShareCSRecord] endRecord];
}
- (void)btnClicked:(UIButton *)btn
{
    [self.view endEditing:YES];
    _ev.hidden = YES;
    _tableBottomConstraint.constant = -44;
    UIView *vi = [self.view viewWithTag:100];
    vi.frame = CGRectMake(0, _nowHeight, [UIScreen mainScreen].bounds.size.width, 44);
    switch (btn.tag)
    {
        case 11:
            
            break;
        case 12:
            
        {
            
            _ev.hidden = NO;
            _tableBottomConstraint.constant = -44 - 180;
            UIView *vi = [self.view viewWithTag:100];
            CGRect rec = vi.frame ;
            rec.origin.y = _nowHeight - 180;
            vi.frame = rec;

        }
            
            break;
        case 13:
            {
                
                
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"请选择" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
                [alertController addAction:[UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
                    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                        
                        //图片选择是相册（图片来源自相册）
                        
                        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
                        
                        //设置代理
                        
                        picker.delegate=self;
                        
                        //模态显示界面
                        
                        [self presentViewController:picker animated:YES completion:nil];
                        
                    }
                    
                    else {
                        
                        NSLog(@"不支持相机");
                        
                    }
                    

                    NSLog(@"点击确认");
                    
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    
                    UIImagePickerController * picker = [[UIImagePickerController alloc]init];
                    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                        
                        //图片选择是相册（图片来源自相册）
                        
                        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                        
                        //设置代理
                        
                        picker.delegate=self;
                        
                        //模态显示界面
                        
                        [self presentViewController:picker animated:YES completion:nil];
                        
                        
                        
                    }
                    
                    NSLog(@"点击确认");
                    
                }]];
                [alertController addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
                    
                    [self dismissViewControllerAnimated:YES completion:nil];
                    NSLog(@"点击取消");
                    
                }]];
                
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            break;
        default:
            break;
    }
    NSLog(@"呀！我这个按钮别点击了！");
}
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
     if (picker.sourceType == UIImagePickerControllerSourceTypePhotoLibrary)
     {
        UIImage * image = info[UIImagePickerControllerOriginalImage];
         _photoImage = image;
        CSMessageModel * model = [[CSMessageModel alloc] init];
         model.showMessageTime=YES;
         model.messageSenderType = MessageSenderTypeMe;
         model.messageType = MessageTypeImage;
         model.imageSmall = image;
         model.messageTime = [self currentDateStringWithFormat:@"YYYY-MM-dd"];
         [_dataArray addObject:model];
         
         [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:_dataArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
         [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count - 1 inSection:0]
                                     animated:YES
                               scrollPosition:UITableViewScrollPositionMiddle];
         
        [self dismissViewControllerAnimated:YES completion:nil];
     }
   else if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImage * image =info[UIImagePickerControllerOriginalImage];
        _photoImage = image;
        CSMessageModel * model = [[CSMessageModel alloc] init];
        model.showMessageTime=YES;
        model.messageSenderType = MessageSenderTypeMe;
        model.messageType = MessageTypeImage;
        model.imageSmall = image;
        model.messageTime = [self currentDateStringWithFormat:@"YYYY-MM-dd"];
        [_dataArray addObject:model];
        
        [_tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForItem:_dataArray.count - 1 inSection:0]] withRowAnimation:UITableViewRowAnimationNone];
        [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:_dataArray.count - 1 inSection:0]
                                    animated:YES
                              scrollPosition:UITableViewScrollPositionMiddle];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    [self sendMsg:_photoImage type:MessageTypeImage];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSString *)currentDateStringWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter stringFromDate:[NSDate date]];
}

- (void)showBigImage
{
    
}

#pragma mark - EmojiViewDelegate
- (void)emojiClicked:(NSString *)strEmoji {
    UITextView *tv = [self.view viewWithTag:101];
    tv.text = [tv.text stringByAppendingString:strEmoji];
    
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
