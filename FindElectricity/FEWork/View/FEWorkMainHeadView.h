//
//  FEWorkMainHeadView.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/2.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FEWorkMainHeadViewDelegate <NSObject>

-(void)findElectricityAction;//查找电量

-(void)choujiangAction;//点击抽奖

-(void)signInAction:(NSInteger)num;//签到

-(void)enterEvalueShop;//进入电量值商城

@end

@interface FEWorkMainHeadView : UIView
@property(nonatomic,weak)id<FEWorkMainHeadViewDelegate>localDelegate;
@end

NS_ASSUME_NONNULL_END
