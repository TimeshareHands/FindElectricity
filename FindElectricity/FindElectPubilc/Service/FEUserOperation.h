//
//  FEUserOperation.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/5.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FELoginRegisterModel.h"
NS_ASSUME_NONNULL_BEGIN

@interface FEUserOperation : NSObject
/**
 单例模式
 */
+ (FEUserOperation *)manager;


@property(nonatomic,strong)FELoginResponseUserInfoModel *userModel;
/**
 *登录token
 */
@property(nonatomic,copy)NSString *token;

@property(nonatomic, assign)BOOL isEnterLogin;
/**
是否登录
 
@return YES 表示登录
*/
- (BOOL)didLogin;

/**
 退出登录
 */
- (void)logoutUser;

@end




NS_ASSUME_NONNULL_END
