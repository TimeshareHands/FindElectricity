//
//  DemonViewController.m
//  CSDirectBank
//
//  Created by 彭小坚 on 15/8/14.
//  Copyright (c) 2015年 彭小坚. All rights reserved.
//

#import "DemonViewController.h"

@implementation DemonViewController

#pragma mark -
#pragma mark life Cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = CS_Color_BackGroundGray;
    self.edgesForExtendedLayout = UIRectEdgeNone;
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
