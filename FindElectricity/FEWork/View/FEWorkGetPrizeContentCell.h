//
//  FEWorkGetPrizeContentCell.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FEWorkGetPrizeContentCellDelegate <NSObject>

-(void)confirmToLinqu:(NSString *_Nullable)goodsId;

@end
NS_ASSUME_NONNULL_BEGIN

@interface FEWorkGetPrizeContentCell : UITableViewCell
@property(nonatomic,weak)id<FEWorkGetPrizeContentCellDelegate>localDelegate;
-(void)setUnitText:(NSString *)unitText num:(NSString *)num title:(NSString *)title winNum:(NSString *)winNum pic:(NSString *)pic goodsId:(NSString *)goodsid;
@end

NS_ASSUME_NONNULL_END
