//
//  FEWorkReceiveAddressAlert.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/23.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FEWorkReceiveAddressAlertDelegate <NSObject>

-(void)gotoAddress;

-(void)confirmlinqu:(NSString *_Nullable)goodsId;

@end
NS_ASSUME_NONNULL_BEGIN

@interface FEWorkReceiveAddressAlert : UIView
@property(nonatomic,weak)id<FEWorkReceiveAddressAlertDelegate>localDelegate;
- (void)show;
- (void)hidden;
- (void)setId:(NSString *)goodsId;
@end

NS_ASSUME_NONNULL_END
