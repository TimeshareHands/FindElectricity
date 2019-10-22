//
//  FEWorkEvalueGetPrizeChanceCell.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/3.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FEWorkEvalueGetPrizeChanceCellDelegate <NSObject>

-(void)goDuiAction:(NSString *_Nullable)goodId;

@end
NS_ASSUME_NONNULL_BEGIN

@interface FEWorkEvalueGetPrizeChanceCell : UITableViewCell
@property(nonatomic, weak)id<FEWorkEvalueGetPrizeChanceCellDelegate>localDelegate;

@end

NS_ASSUME_NONNULL_END
