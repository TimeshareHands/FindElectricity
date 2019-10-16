//
//  FEMapInfoModel.h
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FEMapInfoModel : NSObject
@property (copy,nonatomic) NSString *mapId;
@property (assign,nonatomic) CGFloat longitude;
@property (assign,nonatomic) CGFloat latitude;
@property (copy,nonatomic) NSString *serviceId;
@property (copy,nonatomic) NSString *merchantsName;
@property (copy,nonatomic) NSString *merchantsMobile;
@property (copy,nonatomic) NSString *contact;
@property (copy,nonatomic) NSString *brandImage;
@property (copy,nonatomic) NSString *area;
@property (copy,nonatomic) NSString *openTime;
@property (copy,nonatomic) NSString *closeTime;
@property (copy,nonatomic) NSString *is_collection;
@end

NS_ASSUME_NONNULL_END
