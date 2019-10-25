//
//  FETWorkGetPrizeIntroduceCell.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FETWorkGetPrizeIntroduceCellDelegate <NSObject>

-(void)getChoujiangchange;

-(void)duihuanEvalue;

@end
NS_ASSUME_NONNULL_BEGIN

@interface FETWorkGetPrizeIntroduceCell : UITableViewCell
@property(nonatomic,weak)id<FETWorkGetPrizeIntroduceCellDelegate>localDelegate;
-(void)setChoujiangCount:(NSString *)choujiangCount myEvalue:(NSString *)myEvalue;
@end

NS_ASSUME_NONNULL_END
