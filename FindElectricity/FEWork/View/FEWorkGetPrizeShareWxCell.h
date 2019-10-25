//
//  FEWorkGetPrizeShareWxCell.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/12.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FEWorkGetPrizeShareWxCellDelegate <NSObject>

-(void)generateShareImgAction;

@end
NS_ASSUME_NONNULL_BEGIN

@interface FEWorkGetPrizeShareWxCell : UITableViewCell
@property(nonatomic, weak)id<FEWorkGetPrizeShareWxCellDelegate>localDelegate;
@end

NS_ASSUME_NONNULL_END
