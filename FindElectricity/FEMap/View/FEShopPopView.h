//
//  FEShopPop.h
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/7.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEViewXib.h"
#import "FEMapInfoModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FEShopPopView : FEViewXib
@property (weak,nonatomic) FEMapInfoModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *shopImg;
@property (copy, nonatomic) void(^didClick)(NSInteger,NSString *mapId);
- (IBAction)btnAct:(UIButton *)sender;

@end

NS_ASSUME_NONNULL_END
