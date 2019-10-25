//
//  FEWorkModel.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FEWorkModel : NSObject

@end


//'myElectrictyVal': 5000,    我的电量值
// 'todayElectricity': 5000,   今日电量值
// 'lottery_number': 0,        抽奖次数
// 'sign_num': 0,              签到天数
// 'inviteInstall': 10,        邀请并安装
// 'kmToElectricity': 100,     千米兑换电量
// 'maxElectricity': 5000,     最大当天骑行电量
// 'readStrategy': 500         阅读赠送
//'is_read' :0                 0 未读 1 读过一次
#pragma mark -任务界面数据展示
@interface FEWorkPanelDataResponseModel : NSObject

@property (nonatomic ,copy) NSString *myElectrictyVal;
@property (nonatomic ,copy) NSString *todayElectricity;
@property (nonatomic ,copy) NSString *lottery_number;
@property (nonatomic ,copy) NSString *sign_num;
@property (nonatomic ,copy) NSString *inviteInstall;
@property (nonatomic ,copy) NSString *kmToElectricity;
@property (nonatomic ,copy) NSString *maxElectricity;
@property (nonatomic ,copy) NSString *readStrategy;
@property (nonatomic ,copy) NSString *is_read;

@end

#pragma mark -电量值列表展示
//num': 500,
//'ctime': '1566554328',
//'type': '阅读攻略'
//'desc': '阅读电量攻略'
@interface FEWorkElectricityListResponseModel : NSObject

@property (nonatomic ,copy) NSString *num;
@property (nonatomic ,copy) NSString *ctime;
@property (nonatomic ,copy) NSString *type;
@property (nonatomic ,copy) NSString *desc;

@end

#pragma mark -电量值商城面板数据
@interface FEWorkShopInfoResponseModel : NSObject

@property(nonatomic, copy)NSString *myElectrictyVal;
@property(nonatomic, copy)NSArray *exchange_lottery_list;

@end

#pragma mark -电量值商城面版列表数据
@interface FEWorkShopInfoResponseListModel :NSObject

@property(nonatomic, copy)NSString *id;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *pic;
@property(nonatomic, copy)NSString *num;
@property(nonatomic, copy)NSString *integral;
@property(nonatomic, copy)NSString *type;

@end
#pragma mark 兑换日志
@interface FEWorkExhcangeGoodRequestModel : NSObject

@property(nonatomic, copy)NSString *goodId;

@end

#pragma mark -领取物品
@interface FEWorkReceivegoodRequestModel : NSObject

@property(nonatomic, copy)NSString *address;
@property(nonatomic, copy)NSString *contacts;
@property(nonatomic, copy)NSString *telephone;
@property(nonatomic, copy)NSString *id;

@end
#pragma mark -中奖商品详情
@interface FEWorkReceiveGoodInfoRequestModel : NSObject
@property(nonatomic, copy)NSString *id;
@end

NS_ASSUME_NONNULL_END
