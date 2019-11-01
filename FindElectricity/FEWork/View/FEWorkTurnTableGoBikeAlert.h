//
//  FEWorkTurnTableGoBikeAlert.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/11/1.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FEWorkTurnTableGoBikeAlertDelegate <NSObject>

-(void)goBike;


@end

@interface FEWorkTurnTableGoBikeAlert : UIView

@property(nonatomic, weak)id<FEWorkTurnTableGoBikeAlertDelegate>localDelegate;
- (void)show;
- (void)hidden;

@end

NS_ASSUME_NONNULL_END
