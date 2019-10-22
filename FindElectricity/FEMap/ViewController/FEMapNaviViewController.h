//
//  FEMapNaviViewController.h
//  FindElectricity
//
//  Created by DongQiangLi on 2019/9/26.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "DemonViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
@protocol RideNaviViewControllerDelegate;
NS_ASSUME_NONNULL_BEGIN

@interface FEMapNaviViewController : DemonViewController
@property (weak,nonatomic) id<RideNaviViewControllerDelegate> delegate;
@property (nonatomic, strong) AMapNaviRideView *rideView;
@end

NS_ASSUME_NONNULL_END

@protocol RideNaviViewControllerDelegate <NSObject>

- (void)rideNaviViewCloseButtonClicked;

@end
