//
//  FEMapsModel.h
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FEMapsModel : NSObject
@property (copy,nonatomic) NSString *mapId;
@property (assign,nonatomic) CGFloat longitude;
@property (assign,nonatomic) CGFloat latitude;
@property (copy,nonatomic) NSString *serviceId;
@end

NS_ASSUME_NONNULL_END
