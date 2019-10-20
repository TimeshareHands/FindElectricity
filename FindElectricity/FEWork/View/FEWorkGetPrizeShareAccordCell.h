//
//  FEWorkGetPrizeShareAccordCell.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/12.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FEWorkGetPrizeShareAccordCellDelegate <NSObject>

-(void)findRecord;

@end
NS_ASSUME_NONNULL_BEGIN

@interface FEWorkGetPrizeShareAccordCell : UITableViewCell
@property(nonatomic, weak)id<FEWorkGetPrizeShareAccordCellDelegate>localDelegate;
@end

NS_ASSUME_NONNULL_END
