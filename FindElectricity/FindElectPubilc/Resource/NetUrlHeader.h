//
//  NetUrlHeader.h
//  OrderApp
//
//  Created by zhangfan on 2019/7/2.
//  Copyright © 2019 豪锅锅. All rights reserved.
//

#ifndef NetUrlHeader_h
#define NetUrlHeader_h


#define BASE_URLWith(str) [NSString stringWithFormat:@"%@%@",BASE_URL,str]
#define KImg_URLWith(str)  [NSURL URLWithString:str]
#define BASE_URL @"http://zhaodianapi.csjiayu.com/zhaodian/v2"

#define KSuccessCode 2000
#define KTokenFailCode 4010

//骑行
#define CirclingSubHttp  @"/circlingSub" //骑行数据提交
#define CirclingPanelDataHttp     @"/circlingPanelData" //骑行面板数据展示

//任务
#define  TaskPanelDataHttp  @"/taskPanelData" //任务界面数据展示
#define  SignHttp @"/sign" //签到
#define  ReadStrategyHttp @"/readStrategy" //阅读
#define  ShareFriendsHttp @"/shareFriends" //分享给朋友
#define  EletricityListHttp @"/electricityList" //电量值列表
#define  ShopInfoHttp @"/shopInfo" //电量值商城面板数据
#define  ExhcangegoodHttp  @"/exhcangegood" //兑换商品
#define  ExhcangegoodlogHttp @"/exhcangegoodlog"  //兑换日志
#define  InvFriendLogHttp  @"/invFriendLog" //邀请好友记录

//系统消息
#define SystemMsgHttp  @"/systemMsg" //系统消息

//首页消息
#define IndexInfoHttp  @"/indexInfo"  //首页信息

//抽奖
#define LuckyDrawHttp  @"/luckydraw" //抽奖商品
#define LuckydrawdateHttp @"/luckydrawdate" //抽奖页面数据
#define LuckydrawlistHttp @"/luckydrawlist" //抽奖商品数据列表
#define ReceiveGoodHttp @"/receivegood" //领取物品
#define WelFare @"/welfare" //天天送

//七牛云
#define  QNTokenHttp  @"/qntoken" //七牛云上传token

//用户登录
#define MobileLoginHttp             @"/mobileLogin"     //手机号登录*************
#define WXLoginHttp     @"/wxLogin"         //微信授权登录*************
#define MemTokenLoginHttp     @"/tokenLogin"         //token登录????
#define WxLoginHttp     @"/wxLogin"         //微信授权登录*************
#define WxBindMobileHttp     @"/wxBindMobile"        //微信手机捆绑*********
#define MobileRegisterHttp     @"/mobileRegister"         //手机号注册*********
#define FindPwdHttp     @"/findPwd"       //找回密码*********
#define  SendCodeHttp    @"/sendCode" //发送短信
//公告
#define AnouncementHttp  @"/announcement"  //公告
#define InvInfoHttp @"/invInfo"  //推荐界面接口
#define TiXianReqHttp    @"/tixianReq"  //申请提现接口

//地图
#define TenantsHttp @"/tenants"  //商家入驻
#define EditMapHttp @"/editMap"  //地图点修改
#define ServiceTypeHttp @"serviceType"  //服务类型列表
#define TenantsLogHttp @"/tenantsLog"  //入驻申请记录列表
#define DelTenantsHttp @"/delTenants"  //删除未处理的入驻申请
#define MapListHttp @"/mapList"  //地图列表
#define MapInfoHttp @"/mapInfo"  //地图点信息
#define MapCollectionHttp @"/mapCollection"  //地图点收藏
#define CollectionListHttp @"/collectionList"  //地图收藏列表
#define MapCorrectionHttp @"/mapCorrection"  //地图点（商家位置）纠错
#define CorrectionListHttp @"/correctionList"  //地图点（商家位置）纠错列表
#define CorrectionContentHttp @"/correctionContent"  //纠错内容详情

//用户
#define EditInfoHttp  @"/editInfo"  //编辑用户***********
#define AddressSetHttp @"/addressSet"  //个人中心收货地址完善***********
#define AddressInfoHttp    @"/addressInfo"  //个人中心收货地址获取详情***********
#define ChangeMobileHttp  @"/changeMobile"  //电话号码变更接口***********
#define UserNewInfoHttp  @"/userNewInfo"  //获取用户相关信息***********
#define AddAdviceHttp  @"/addAdvice"  //平台建议提交***********
#define ClearTokenHttp  @"/clearToken"  //退出登录***********
#define WeChatDisplayHttp  @"/weChatDisplay"  //判断是否显示三方登录***********


#endif /* NetUrlHeader_h */
