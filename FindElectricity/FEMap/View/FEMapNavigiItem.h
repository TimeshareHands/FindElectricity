//
//  FEMapNavigiItem.h
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/4.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FEMapNavigiItem : UIView
@property (copy, nonatomic) void(^didTap)(NSInteger tag);
- (void)notReadNum:(NSInteger)num;
@end

NS_ASSUME_NONNULL_END
