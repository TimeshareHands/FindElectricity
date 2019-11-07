//
//  FEUserProtocalVC.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/11/7.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEUserProtocalVC.h"
#import <WebKit/WebKit.h>

@interface FEUserProtocalVC ()
@property (retain, nonatomic) WKWebView *myWebView;
@end

@implementation FEUserProtocalVC

- (void)viewDidLoad {
    [super viewDidLoad];
      [self addView];
      [self.view setBackgroundColor:[UIColor whiteColor]];
      NSURL *url = [NSURL URLWithString:self.urlStr];
      [self.myWebView loadRequest:[NSURLRequest requestWithURL:url]];
}

#pragma mark -添加视图
-(void)addView{
    [self.view addSubview:self.myWebView];
    [self makeUpconstriant];
}
#pragma mark -约束适配
-(void)makeUpconstriant{
    [self.myWebView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view);
        make.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
}

#pragma mark -getter
-(WKWebView *)myWebView{
    if (!_myWebView) {
        _myWebView =[[WKWebView alloc]init];
    }
    return _myWebView;
}



@end
