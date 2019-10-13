//
//  CSTabBarController.m
//  CSDirectBank
//
//  Created by 彭小坚 on 15/8/14.
//  Copyright (c) 2015年 彭小坚. All rights reserved.
//

#import "FindTabBarController.h"
#import "DemonTabbarItem.h"
#import "FEMapViewController.h"
#import "FECycleViewController.h"
#import "FEMineViewController.h"
#import "FEWorkMainVC.h"
#import "FELoginViewController.h"
NSString *const kSwitchTabNotification = @"SwitchTabNotification";

@interface FindTabBarController()

@property(nonatomic,copy) NSArray *normalImageArray;
@property(nonatomic,copy) NSArray *selectedImageArray;
@property(nonatomic,copy) DemonTabbarItem *selectedItem;


@property(nonatomic,strong) UILabel *mapLabel;
@property(nonatomic,strong) UILabel *mineLabel;
@property(nonatomic,strong) UILabel *rideLabel;
@property(nonatomic,strong) UILabel *workLabel;


@property(nonatomic,strong)DemonViewController *mapManageVC;

@property(nonatomic,strong) DemonViewController *rideManageVC;


@property(nonatomic,strong) DemonViewController *mineManageVC;

@property(nonatomic,strong)DemonViewController *workManageVC;

@end

@implementation FindTabBarController

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self getOldViewControllers];
        [self setUp];
    }
    return self;
}

#pragma mark -
#pragma mark life Cycle
-(void)viewDidLoad
{
    [super viewDidLoad];
    //写了init方法，在init方法里面对属性赋值，会调用一次viewDidLoad方法，所以最好在init做初始化
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];

    NSArray *subViews = self.tabBar.subviews;
    for (UIView *view in subViews) {
        //此函数能获取该字符串指代的类
        Class cla = NSClassFromString(@"UITabBarButton");
        //判断该视图的类型是否属于cla所指的类型
        if ([view isKindOfClass:cla]) {
            [view removeFromSuperview];
        }

    }
}


- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}


#pragma mark -
#pragma mark Private Method
- (void)setUp
{
    [self createTabbar];
}


///去掉tabbar顶部线条
- (void)changeTabbarBackgroundImg
{
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.tabBar setBackgroundImage:img];
    [self.tabBar setShadowImage:img];
}

///添加阴影
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    // Creating shadow path for better performance
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.tabBar.bounds);
    self.tabBar.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.tabBar.layer.shadowColor = color.CGColor;
    self.tabBar.layer.shadowOffset = offset;
//    self.tabBar.layer.shadowRadius = radius;
    self.tabBar.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.tabBar.clipsToBounds = NO;
}

-(void)getOldViewControllers
{
    DemonNavigationController *mapNav = [[DemonNavigationController alloc]initWithRootViewController:self.mapManageVC];
    [self addChildViewController:mapNav];
    DemonNavigationController *rideNav = [[DemonNavigationController alloc]initWithRootViewController:self.rideManageVC];
     [self addChildViewController:rideNav];
    DemonNavigationController *workNav = [[DemonNavigationController alloc]initWithRootViewController:self.workManageVC];
       [self addChildViewController:workNav];
    DemonNavigationController *mineNav = [[DemonNavigationController alloc]initWithRootViewController:self.mineManageVC];
    [self addChildViewController:mineNav];
   
 
    
}


- (void)createTabbar
{

    _normalImageArray = @[@"tabb_map_norm.png", @"tabb_cycling_norm.png",@"tabb_task_norm.png", @"tabb_me_norm.png"];
    _selectedImageArray = @[@"tabb_map_select.png", @"tabb_cycling_select.png",@"tabb_task_select.png", @"tabb_me_select.png"];
   
    

    // 按钮的标题数组
    NSArray *titleArray = @[@"地图", @"骑行", @"任务", @"我的"];
    
    UIColor *normalFontColor = [UIColor colorWithHex:0x666666];
    UIColor *selectedFontColor = [UIColor colorWithHex:0x404040];// [UIColor colorWithHex:0xEF3D3D];


    // 按钮的宽、高
    CGFloat width = SCREEN_WIDTH / (float)titleArray.count;
    CGFloat height = self.tabBar.frame.size.height;
    for (int i = 0; i < titleArray.count; i++) {

        CGRect frame = CGRectMake(width * i, 0, width, height);
        //使用自定义的按钮样式
        DemonTabbarItem *item = [[DemonTabbarItem alloc] initWithFrame:frame
                                                       normalImageName:_normalImageArray[i]
                                                     selectedImageNemd:_selectedImageArray[i]
                                                       normalFontColor:normalFontColor
                                                     selectedFontColor:selectedFontColor
                                                                 title:titleArray[i]];
        item.tag = i+1;
        item.isSelected = NO;

        // 设置选中效果
        if (i == 0) {
            item.isSelected = YES;
            _selectedItem = item;
        }
        [item addTarget:self action:@selector(itemTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.tabBar addSubview:item];
    }
  
}


#pragma mark -
#pragma mark 切换页面

- (void)notifySwitchTab:(NSNotification *)notification
{
    NSIndexPath *indexPath = [notification object];
    [self switchTab:indexPath];
}

- (void)itemTapped:(DemonTabbarItem *)item
{
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:item.tag];
    [self switchTab:indexPath];
    
    if (![[FEUserOperation manager] didLogin]&&item.tag>1) {
          FELoginViewController *loginVC =[[FELoginViewController alloc]init];
          [self presentViewController:loginVC animated:YES completion:nil];
    }
}

- (void)switchTab:(NSIndexPath *)indexPath
{
  
    DemonTabbarItem *item = [self.tabBar viewWithTag:indexPath.section];
    if (item == _selectedItem) return;
    
    item.isSelected = YES;
    _selectedItem.isSelected = NO;
    _selectedItem = item;
    
    self.selectedIndex = item.tag - 1;
}

#pragma mark -
#pragma mark getter & setter
- (DemonViewController *)mapManageVC
{
    if (!_mapManageVC) {
        _mapManageVC = [[FEMapViewController alloc] init];
        _mapManageVC.title = @"";
    }
    return _mapManageVC;
}
- (DemonViewController *)mineManageVC
{
    if (!_mineManageVC) {
        _mineManageVC = [[FEMineViewController alloc] init];
        _mineManageVC.title = @"";
    }
    return _mineManageVC;
}

- (DemonViewController *)rideManageVC
{
    if (!_rideManageVC) {
        _rideManageVC = [[FECycleViewController alloc] init];
        _rideManageVC.title = @"骑行";
    }
    return _rideManageVC;
}


- (DemonViewController *)workManageVC
{
    if (!_workManageVC) {
        _workManageVC = [[FEWorkMainVC alloc]init];
        _workManageVC.title = @"";
    }
    return _workManageVC;
}


- (UILabel *)rideLabel
{
    if (!_rideLabel)
    {
        _rideLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        _rideLabel.text = @"骑行";
        [_rideLabel setBackgroundColor:[UIColor blackColor]];
        _rideLabel.textColor = UIColorFromHex(0xE4BD5A);
    }
    return _rideLabel;
}
- (UILabel *)mapLabel
{
    if (!_mapLabel)
    {
        _mapLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        _mapLabel.text = @"地图";
        _mapLabel.textColor = UIColorFromHex(0xE4BD5A);
    }
    return _mapLabel;
}
- (UILabel *)mineLabel
{
    if (!_mineLabel)
    {
        _mineLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        _mineLabel.text = @"我的";
        _mineLabel.textColor = UIColorFromHex(0xE4BD5A);
    }
    return _mineLabel;
}
- (UILabel *)workLabel
{
    if (!_workLabel)
    {
        _workLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
        _workLabel.text = @"任务";
        _workLabel.textColor = UIColorFromHex(0xE4BD5A);
    }
    return _workLabel;
}


@end
