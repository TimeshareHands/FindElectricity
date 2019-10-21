//
//  FEWorkEValueDetailHeadView.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/3.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FEWorkEValueDetailHeadViewDelegate <NSObject>

-(void)goDuiFUAction;

@end

NS_ASSUME_NONNULL_BEGIN

@interface FEWorkEValueDetailHeadView : UIView
@property(nonatomic,weak)id <FEWorkEValueDetailHeadViewDelegate>localDelegate;
@property(nonatomic ,copy)NSString *myEvalue;
@property(nonatomic ,copy)NSString *lotterNum;
@end

NS_ASSUME_NONNULL_END
