//
//  FEWorkGetPrizeShareCell.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/11.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FEWorkGetPrizeShareCellDelegate <NSObject>

-(void)shareToIntroduceAction;

-(void)readStandard;
@end
NS_ASSUME_NONNULL_BEGIN

@interface FEWorkGetPrizeShareCell : UITableViewCell
@property(nonatomic,weak)id<FEWorkGetPrizeShareCellDelegate>localDelegate;
@end

NS_ASSUME_NONNULL_END
