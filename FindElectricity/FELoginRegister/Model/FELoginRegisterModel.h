//
//  FELoginRegisterModel.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/5.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FELoginRegisterModel : NSObject

@end


@interface FELoginRequestModel : NSObject
@property(nonatomic, copy)NSString *mobile;
@property(nonatomic, copy)NSString *pwd;
@end

@interface FERegisterRequestModel : NSObject

@property(nonatomic, copy)NSString *mobile;
@property(nonatomic, copy)NSString *pwd;
@property(nonatomic, copy)NSString *verifyCode;
@property(nonatomic, copy)NSString *invCode;

@end

@interface FEFindPasswordRequestModel : NSObject
@property(nonatomic, copy)NSString  *mobile;
@property(nonatomic, copy)NSString  *verifyCode;
@property(nonatomic, copy)NSString  *pwd;
@end

@interface FELoginResponseUserInfoModel : NSObject
@property(nonatomic, copy)NSString  *address;
@property(nonatomic, copy)NSString  *area;
@property(nonatomic, copy)NSString  *cTime;
@property(nonatomic, copy)NSString  *contacts;
@property(nonatomic, copy)NSString  *cover;
@property(nonatomic, copy)NSString  *faceImg;
@property(nonatomic, copy)NSString  *fan;
@property(nonatomic, copy)NSString  *follow;
@property(nonatomic, copy)NSString  *grade;
@property(nonatomic, copy)NSString  *integral;
@property(nonatomic, copy)NSString  *invCode;
@property(nonatomic, copy)NSString  *is_admin;
@property(nonatomic, copy)NSString  *is_del;
@property(nonatomic, copy)NSString  *login_time;
@property(nonatomic, copy)NSString  *lottery_number;
@property(nonatomic, copy)NSString  *mobile;
@property(nonatomic, copy)NSString  *nickName;
@property(nonatomic, copy)NSString  *openid;
@property(nonatomic, copy)NSString  *pinvCode;
@property(nonatomic, copy)NSString  *sex;
@property(nonatomic, copy)NSString  *sign_num;
@property(nonatomic, copy)NSString  *signature;
@property(nonatomic, copy)NSString  *telephone;
@property(nonatomic, copy)NSString  *uid;
@end


NS_ASSUME_NONNULL_END
