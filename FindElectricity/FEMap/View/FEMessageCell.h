//
//  FEMessageCell.h
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/7.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEMessageModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FEMessageCell : UITableViewCell
@property (weak, nonatomic) FEMessageModel *model;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *detailLab;
@property (weak, nonatomic) IBOutlet UILabel *red;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

NS_ASSUME_NONNULL_END
