//
//  FETimeManager.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/14.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FETimeManager.h"
@interface FETimeManager()
{
    
}

@property (nonatomic,assign) NSTimeInterval didStartTime;
@property (nonatomic,strong) NSTimer *timer;
@end
static FETimeManager *shareManager = nil;

@implementation FETimeManager
+ (FETimeManager *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareManager  = [[FETimeManager alloc] init];
        
    });
    return shareManager;
}

- (void)congfig {
    WEAKSELF
    _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
        [weakSelf timeRun];
    }];
}

- (void)timeRun {
    _didStartTime++;
    MYLog(@"time:%f",_didStartTime);
    if (_timeRunBlock) {
        _timeRunBlock(_didStartTime);
    }
}

- (void)startTiming {
    [self endTiming];
    [self congfig];
}

- (void)stopTiming {
    [_timer setFireDate:[NSDate distantFuture]];
}

- (void)goonTiming {
    [_timer setFireDate:[NSDate date]];
}

- (void)endTiming {
    [_timer invalidate];
    _timer = nil;
}

- (void)dealloc {
    [self endTiming];
}

@end
