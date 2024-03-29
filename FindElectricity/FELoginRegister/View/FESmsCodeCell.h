//
//  FESmsCodeCell.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/8.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FESmsCodeCell : UITableViewCell
@property(nonatomic, strong)UITextField *inputTextField;
@property(nonatomic, strong)UIView *lineView;
@property(nonatomic, strong)UIButton *smsBtn;
@end

NS_ASSUME_NONNULL_END
