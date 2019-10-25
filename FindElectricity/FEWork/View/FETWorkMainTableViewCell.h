//
//  FETWorkMainTableViewCell.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/2.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FETWorkMainTableViewCell : UITableViewCell
-(void)setLeftImg:(NSString *)imageLogo topText:(NSString *)topText topCenterText:(NSString *)tpcenterText centerText:(NSString *)centerText bottomText:(NSString *)bottomText buttonColor:(UIColor *)color buttonTitle:(NSString *)buttonTitle;
@end

NS_ASSUME_NONNULL_END
