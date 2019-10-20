//
//  FEWorkShareBottomView.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/20.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FEWorkShareBottomViewDelegate <NSObject>

-(void)shareLineQ;

-(void)shareWx;

@end
NS_ASSUME_NONNULL_BEGIN

@interface FEWorkShareBottomView : UIView
@property(nonatomic, weak)id<FEWorkShareBottomViewDelegate>localDelagte;
@end

NS_ASSUME_NONNULL_END
