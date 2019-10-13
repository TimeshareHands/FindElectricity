//
//  FEMapCollectModel.h
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/12.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FEMapCollectModel : NSObject
@property(nonatomic, copy)NSString  *mapId;
@property(nonatomic, copy)NSString  *uid;
@property(nonatomic, copy)NSString  *brandImage;
@property(nonatomic, copy)NSString  *cTime;
@property(nonatomic, copy)NSString  *merchantsMobile;
@property(nonatomic, copy)NSString  *merchantsName;
@property(nonatomic, copy)NSString  *area;
@end

NS_ASSUME_NONNULL_END
