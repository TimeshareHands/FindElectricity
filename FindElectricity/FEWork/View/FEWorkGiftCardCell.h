//
//  FEWorkGiftCardCell.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/4.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol FEWorkGiftCardCellDelegate <NSObject>

-(void)cellGoDuiAction:(NSString *_Nullable)goodId;

@end
@interface FEWorkGiftCardCell : UITableViewCell
@property(nonatomic, weak)id<FEWorkGiftCardCellDelegate>localDelegete;
-(void)settLeftImg:(NSString *)leftImg topText:(NSString *)topText bottomText:(NSString *)bottomText goodId:(NSString *)goodId;
@end

NS_ASSUME_NONNULL_END
