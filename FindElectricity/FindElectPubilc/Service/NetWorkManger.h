//
//  NetWorkManger.h
//  picturerafulive
//
//  Created by Mills on 2019/8/14.
//  Copyright © 2019 picliveon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@class NetWorkManger;

NS_ASSUME_NONNULL_BEGIN

typedef void(^Success)(id responseObject);
typedef void(^Failure)(NSError *error);

@interface NetWorkManger : NSObject


/**
 单例模式
 */
+ (NetWorkManger *)manager;

@property(nonatomic, strong)id senderVC;
/**
 GET请求

 @param url 请求url
 @param paramters 参数
 @param success void(^Success)(id json)回调
 @param failure void(^Failure)(NSError *error)回调
 */
- (void)getDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramters needToken:(BOOL )needToken success:(Success)success failure:(Failure)failure;

/**
 POST请求

 @param url 请求url
 @param paramters 参数
 @param timeoutInterval 超时时间
 @param success void(^Success)(id json)回调
 @param failure void(^Failure)(NSError *error)回调
 */
- (void)postDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramters
                needToken:(BOOL )needToken timeout:(NSTimeInterval)timeoutInterval success:(Success)success failure:(Failure)failure;



/**
上传图片请求

@param data 参数
@param success void(^Success)(id imgUlr)回调
@param failure void(^Failure)(id error)回调
*/
- (void)uploadImageToQNFileData:(NSData *)data  success:(Success)success failure:(Failure)failure;

- (void)cancelRequest;//取消网络请求
@end

NS_ASSUME_NONNULL_END
