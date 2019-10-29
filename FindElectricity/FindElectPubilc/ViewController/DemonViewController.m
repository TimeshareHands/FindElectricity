//
//  DemonViewController.m
//  CSDirectBank
//
//  Created by 彭小坚 on 15/8/14.
//  Copyright (c) 2015年 彭小坚. All rights reserved.
//

#import "DemonViewController.h"
#import "UIBarButtonItem+MTAdditions.h"
#import "MTResourceManager.h"
#import "FELoginViewController.h"
@interface DemonViewController()

@property(nonatomic, strong)FELoginViewController *loginVC;
@property(nonatomic, assign)BOOL isEnterLogin;
@end
@implementation DemonViewController

#pragma mark -
#pragma mark life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromHex(0xf3f6f9);
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"map_back.png" highlightIcon:nil imageScale:1.0 target:self action:@selector(back)];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(doLogin) name:@"doLoginNotification" object:nil];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (@available(iOS 11.0, *)) {
        
        
    } else {
        // Fallback on earlier versions
    }
}
-(void)doLogin{
    WEAKSELF;
    for (UIViewController *sender in self.navigationController.viewControllers ) {
        if ([sender isKindOfClass:[FELoginViewController class]]) {
            weakSelf.isEnterLogin =YES;
            return ;
        }
     }
    if (weakSelf.isEnterLogin) {
        return ;
    }
    self.loginVC =[[FELoginViewController alloc]init];
    [self.navigationController pushViewController:self.loginVC animated:YES];
}
//item字体颜色
- (void)setNavgaBarItemColor:(UIColor *)color
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.translucent = NO;
    // 设置背景
    navBar.tintColor = color;
    //    [self.navigationController.navigationBar setTintColor:color];
    //    [self.navigationItem.rightBarButtonItem setTintColor:color];
}

//导航栏背景颜色
- (void)setNavgaBarTintColor:(UIColor *)color
{
    UINavigationBar *navBar = [UINavigationBar appearance];
    navBar.translucent = YES;
    navBar.opaque = NO;
    // 设置背景
    //    navBar.barTintColor = color;
    MTResourceManager *manager = [[MTResourceManager alloc]init];
    [self.navigationController.navigationBar setBackgroundImage:[manager imageFromColor:color]
                                                  forBarMetrics:UIBarMetricsDefault];
    
    
    
    self.navigationController.navigationBar.shadowImage = [UIImage new];
}

- (void)setNavgaTitleColor:(UIColor *)color
{
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:[UIFont systemFontOfSize:19.0]}];
}

- (void)setNavgaTitle:(NSString *)title
{
    [self.navigationItem setTitle:title];
}

- (void)leftBtnWithIcon:(NSString *)icon target:(id)target action:(SEL)action
{
    if ([icon isEqualToString:@""]) {
        self.navigationItem.leftBarButtonItem = nil;
        return;
    }
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:icon highlightIcon:nil imageScale:1 target:target action:action];
}

- (void)rightBtnWithIcon:(NSString *)icon target:(id)target action:(SEL)action
{
    if ([icon isEqualToString:@""]) {
        
        return;
    }
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithIcon:icon highlightIcon:nil imageScale:1 target:target action:action];
}

- (void)rightBtnWithTitle:(NSString *)title target:(id)target action:(SEL)action color:(UIColor *)color
{
    if ([title isEqualToString:@""]) {
        
        return;
    }
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithTitle:title target:target action:action color:(UIColor *)color];
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)actionBack /**<返回方法*/
{
    [self.navigationController setCanGestureBack:NO];
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = YES;
}

@end
