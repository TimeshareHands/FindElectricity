//
//  FEMessageModel.h
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/12.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FEMessageModel : NSObject
@property (nonatomic, strong) NSString *ctime;
@property (nonatomic, strong) NSString *is_read;
@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *msg;
@property (nonatomic, strong) NSString *title;
@end

NS_ASSUME_NONNULL_END
