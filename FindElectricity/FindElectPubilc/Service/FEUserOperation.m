//
//  FEUserOperation.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/5.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEUserOperation.h"
#import "AppDelegate.h"
static FEUserOperation *manager = nil;
static dispatch_once_t onceToken;
@implementation FEUserOperation
//单例
+ (FEUserOperation *)manager {
    
    dispatch_once(&onceToken, ^{
        manager = [[FEUserOperation alloc] init];
    });
    return manager;
}

- (BOOL)didLogin
{
    if (self.token.length)
    {
        return YES;
    }
    return NO;
}

- (void)logoutUser
{
    self.token = @"";
    [self setToken:@""];
    dispatch_async(dispatch_get_main_queue(), ^{
        AppDelegate *appdele = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdele.tabBarController.navigationController popToRootViewControllerAnimated:YES];
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:1];
        [appdele.tabBarController switchTab:indexPath];
    });
}

-(void)setToken:(NSString *)token {
    //我先简单处理，缓存
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:@"FEToken"];
}

-(NSString *)token {
    return [[NSUserDefaults standardUserDefaults] objectForKey:@"FEToken"];
}
@end
