//
//  FEAnnotationView.h
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/7.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSInteger,FEPointAnnotType){
    FEPointAnnotLoc = 0,
    FEPointAnnotFix = 1,
    FEPointAnnotQuickChong = 2,
    FEPointAnnotSlowlyChong = 3,
};
@interface FEPointAnnotation : MAPointAnnotation
@property (assign, nonatomic) FEPointAnnotType type; 
@end

NS_ASSUME_NONNULL_END
