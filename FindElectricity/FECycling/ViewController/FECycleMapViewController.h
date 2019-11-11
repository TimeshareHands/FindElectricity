//
//  FECycleMapViewController.h
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/9.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "DemonViewController.h"
#import "FEMapManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface FECycleMapViewController : DemonViewController
@property (strong, nonatomic) NSMutableArray *points;
@property (assign,nonatomic) CLLocationCoordinate2D startCoord;
@end

NS_ASSUME_NONNULL_END
