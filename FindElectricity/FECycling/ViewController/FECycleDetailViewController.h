//
//  FECycleDetailViewController.h
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/9.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "DemonViewController.h"
#import "FEMapManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface FECycleDetailViewController : DemonViewController
@property (assign,nonatomic) CLLocationCoordinate2D startCoord;
@property (assign,nonatomic) CLLocationCoordinate2D currentCoord;
@end

NS_ASSUME_NONNULL_END
