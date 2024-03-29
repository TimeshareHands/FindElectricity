//
//  NetWorkManger.m
//  picturerafulive
//
//  Created by Mills on 2019/8/14.
//  Copyright © 2019 picliveon. All rights reserved.
//

#import "NetWorkManger.h"
#import <UIKit+AFNetworking.h>
#import "QiniuSDK.h"
#import "FEUserOperation.h"
#import "FELoginViewController.h"
#import "AppDelegate.h"
#define kTimeOut 60.0

static NetWorkManger *manager = nil;
static AFHTTPSessionManager *afnManager = nil;
 static dispatch_once_t onceToken;
@implementation NetWorkManger

//单例
+ (NetWorkManger *)manager {
    
    dispatch_once(&onceToken, ^{
        manager = [[NetWorkManger alloc] init];
        afnManager = [AFHTTPSessionManager manager];
        afnManager.requestSerializer = [AFJSONRequestSerializer serializer];
        afnManager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/plain",@"text/html",@"application/json",nil];
        afnManager.requestSerializer.timeoutInterval = kTimeOut;
    });
    
    return manager;
}

//GET请求
- (void)getDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramters needToken:(BOOL )needToken success:(Success)success failure:(Failure)failure {
    afnManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [afnManager GET:url parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
            success(responseObject);
        }else {
            NSLog(@"No Data");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
    
}

//POST请求
- (void)postDataWithUrl:(NSString *)url parameters:(NSDictionary *)paramters needToken:(BOOL )needToken timeout:(NSTimeInterval)timeoutInterval success:(Success)success failure:(Failure)failure {
    afnManager.requestSerializer.timeoutInterval = timeoutInterval;
    afnManager.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (needToken == YES) {
        if([[FEUserOperation manager] didLogin]){
            [afnManager.requestSerializer setValue:[FEUserOperation manager].token forHTTPHeaderField:@"token"];
        }else{
            [self doLogin];
            return;
        }
    }
    WEAKSELF
    [afnManager POST:url parameters:paramters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (responseObject) {
           NSString *str =  [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
           NSString *decodeStr = [str decodeBase64StringToString] ;
           decodeStr =[[decodeStr substringWithRange:NSMakeRange(6, decodeStr.length-6)] decodeBase64StringToString];
            NSDictionary *dic = [self dictionaryWithJsonString:decodeStr];
            //判断登录是否失效
            if ([dic[@"code"] intValue] == 4010) {
                [weakSelf doLogin];
            }
            success(dic);
        }else {
            NSLog(@"No Data");
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error) {
            MTSVPShowInfoText(@"请求出错！");
            failure(error);
        }
    }];
}
- (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                         
                                                        options:NSJSONReadingMutableContainers
                         
                                                          error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    
    return dic;
    
}
- (void)cancelRequest
{
     if ([afnManager.tasks count] > 0) {
          manager =nil;
          onceToken =0l;
          NSLog(@"返回时取消网络请求");
          [afnManager.tasks makeObjectsPerformSelector:@selector(cancel)];
     }
}
#pragma mark 获取七牛token
- (void)getQiNiuTokenSuccess:(Success)success failure:(Failure)failure{
    [self postDataWithUrl:BASE_URLWith(QNTokenHttp) parameters:@{} needToken:NO timeout:20 success:^(id  _Nonnull responseObject) {
        if (responseObject) {
             success(responseObject);
        }
    } failure:^(NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
}

#pragma 七牛上传图片数据
- (void)uploadImageToQNFileData:(NSData *)data  success:(Success)success failure:(Failure)failure{
    
    QNUploadManager *upManager = [[QNUploadManager alloc] init];
    QNUploadOption *uploadOption = [[QNUploadOption alloc] initWithMime:nil progressHandler:^(NSString *key, float percent) {

    }
                 params:nil
               checkCrc:NO
     cancellationSignal:nil];
    
    [self getQiNiuTokenSuccess:^(id  _Nonnull responseObject) {
        NSString  *codeStr = [NSString stringWithFormat:@"%@",responseObject[@"code"]];
        if ([@"2000" isEqualToString:codeStr]) {
            NSString * qiNiuToken = [NSString stringWithFormat:@"%@",responseObject[@"data"]];
             [upManager putData:data key:nil token:qiNiuToken complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
                     NSString *imgUrl = [NSString stringWithFormat:@"http://qiniuzhaodian.csjiayu.com/%@",resp[@"hash"]];
                     success(imgUrl);
            }
            option:uploadOption];

           } else {
               success(responseObject[@"msg"]);
           }
         
    } failure:^(NSError * _Nonnull error) {
        if (error) {
            failure(error);
        }
    }];
 
}


-(void)doLogin{
    WEAKSELF;
    //同时发送几次，请求就好调很多次
//    for (UIViewController *sender in self.senderVC. navigationController.viewControllers ) {
//        if ([sender isKindOfClass:[FELoginViewController class]]) {
//            weakSelf.isPushLogin =YES;
//            return ;
//        }
//     }
//    if (weakSelf.isPushLogin) {
//        return ;
//    }
    
    if ([FEUserOperation manager].isEnterLogin) {
        return;
    }
    [FEUserOperation manager].isEnterLogin = YES;
    FELoginViewController *loginVC =[[FELoginViewController alloc]init];
    [self.senderVC.navigationController pushViewController:loginVC animated:YES];
}
@end
