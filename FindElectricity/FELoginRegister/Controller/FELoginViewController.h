//
//  FELoginViewController.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/7.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "DemonViewController.h"
@protocol FELoginViewControllerDelegate <NSObject>

-(void)LoginSuccess;//查找电量

-(void)loginFailed:(NSError *)error;

@end
NS_ASSUME_NONNULL_BEGIN

@interface FELoginViewController : DemonViewController
@property(nonatomic,weak)id<FELoginViewControllerDelegate>localDelegate;
@end

NS_ASSUME_NONNULL_END
