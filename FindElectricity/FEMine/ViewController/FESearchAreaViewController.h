//
//  FESearchAreaViewController.h
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/30.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "DemonViewController.h"
#import "FEMapManager.h"
NS_ASSUME_NONNULL_BEGIN

@interface FESearchAreaViewController : DemonViewController
@property (strong, nonatomic) AMapGeoPoint *loc;
@property (copy, nonatomic) void(^selectArea)(AMapPOI *poi);
@end

NS_ASSUME_NONNULL_END
