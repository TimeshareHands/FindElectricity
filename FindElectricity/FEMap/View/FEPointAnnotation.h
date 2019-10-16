//
//  FEAnnotationView.h
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/7.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FEPointAnnotation : MAPointAnnotation
@property (assign, nonatomic) FEPointAnnotType type;
@property (copy, nonatomic) NSString *mapId;
@end

NS_ASSUME_NONNULL_END
