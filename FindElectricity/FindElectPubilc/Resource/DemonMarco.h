//
//  DemonMarco.h
//
//
//
//  Copyright (c) 2015年 . All rights reserved.
//

/*!
 *
 *
 *  @brief  Demon 全局宏定义
 *
 *  @since 1.0
 */

#ifndef CSDirectBank_DemonMarco_h
#define CSDirectBank_DemonMarco_h

#define MyDefaults [NSUserDefaults standardUserDefaults]
/**<获取类实例*/
#define GetClassInstance(cls_name) [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:cls_name]

/**<屏幕宽度*/
#define SCREEN_WIDTH    [UIScreen mainScreen].bounds.size.width

/**<屏幕高度*/
#define SCREEN_HEIGHT   [UIScreen mainScreen].bounds.size.height

#define WIDTH_LY(x) SCREEN_WIDTH / 414.0 * (x)
#define HEIGHT_LY(x) SCREEN_HEIGHT / 896.0 * (x)

/**< 根据UI设计师给的UI图iPhone 6屏幕尺寸来做比例适配 */
#define AUTO_SIZE_SCALE_X SCREEN_WIDTH / 375
#define AUTO_SIZE_SCALE_Y SCREEN_HEIGHT / 667

/**<获取应用当前版本号*/
#define PCReleaseVersion [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]
#define PCReleaseVersionString [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]

//============== 工具 =======================

/**<操作系统iOS7*/
#define iOS7 (([[UIDevice currentDevice].systemVersion floatValue] >= 7.0) ? YES : NO)
/**<操作系统iOS8*/
#define iOS8 (([[UIDevice currentDevice].systemVersion floatValue] >= 8.0) ? YES : NO)
/**<操作系统iOS8.3*/
#define iOS8_3 (([[UIDevice currentDevice].systemVersion floatValue] >= 8.3) ? YES : NO)
//操作系统iOS9
#define iOS9 (([[UIDevice currentDevice].systemVersion floatValue] >= 9.0) ? YES : NO)
//操作系统iOS9.1
#define iOS9_1 (([[UIDevice currentDevice].systemVersion floatValue] >= 9.1) ? YES : NO)
//操作系统iOS10
#define iOS10 (([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) ? YES : NO)
//操作系统iOS11
#define iOS11 (([[UIDevice currentDevice].systemVersion floatValue] >= 11.0) ? YES : NO)

#define iPhone4        (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)480) < DBL_EPSILON)

#define iPhone5        (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)568) < DBL_EPSILON)
#define iPhone6        (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)667) < DBL_EPSILON)
#define iPhone6Plus    (fabs((double)[[UIScreen mainScreen]bounds].size.height - (double)736) < DBL_EPSILON)

//用于判断iPhone机型有刘海系列
//https://www.innerfence.com/howto/apple-ios-devices-dates-versions-instruction-sets
#define iPhoneX_Series (fabs(SCREEN_HEIGHT) == 812 || fabs(SCREEN_HEIGHT) == 896)

/**<适配顶部高度*/
#define SafeAreaTopHeight (iPhoneX_Series ? 88.0 : 64.0)

/**<适配底部tabbar高度*/
#define SafeAreaBottomHeight (iPhoneX_Series ? (49.0 + 34.0) : 49.0)

#define isZero(a)         (fabs((double)a - (double)0) < DBL_EPSILON)

/**<判断字符串是否为空*/
#define STRINGHASVALUE(str)		(str && [[str componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] componentsJoinedByString:@""].length > 0)

/**<快速定义weakSelf*/
#define WEAKSELF typeof(self) __weak weakSelf = self;
#define STRONGSELF typeof(weakSelf) __strong strongSelf = weakSelf;

/**<主要是客户端测试用 是否输出日志*/
#ifndef DEBUG
#define NSLog(...);
#else
#define BUGSHOT
#endif



/**<判断字符串是否为nil，否则设置为空，为程序健壮性考虑*/
#define N(x) (x && x.length > 0) ? x : @""
#endif

/**<微信SDK APPID 和 secret*/
#ifdef DEBUG
//#define kWXAPPID @"wx24fc8158b7a9441a"      //微信测试环境开发账号下注册的APPID
//#define kWXAPPSECRET @"74625fdd273d22047b340edd4d4c434b"
#define kWXAPPID @"wxa2075ddeb612efab"
#define kWXAPPSECRET @"54bce541b21b7f11a569a97306cb3519"
#else
#define kWXAPPID @"wxa2075ddeb612efab"
#define kWXAPPSECRET @"54bce541b21b7f11a569a97306cb3519"
#endif



/** 使用高德地图API，请注册Key，注册地址：http://lbs.amap.com/console/key */
const static NSString *FEAMapKey = @"b38728b38131c13a24e8454f6a5dc233";

typedef NS_ENUM(NSInteger,FEPointAnnotType){
    FEPointAnnotLoc = 0,
    FEPointAnnotSlowlyChong = 1,
    FEPointAnnotQuickChong = 2,
    FEPointAnnotFix = 3,
    
    FEPointAnnotAll = 4,
    FEPointAnnotRiding = 10,
    FEPointAnnotDrive = 11,
    FEPointAnnotWalking = 12,
    FEPointAnnotBus = 13,
    FEPointAnnotRailway = 14,
};

//主题颜色、副主题颜色
#define kThemeColor UIColorFromHex(0x000000)
#define kSubTopicColor UIColorFromHex(0xf23030)

/*日志打印*/
#ifdef DEBUG
#define MYLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define MYLog(FORMAT, ...) nil
#endif

//SVP
#define MTSVPShowWithText(obj) {[SVProgressHUD showWithStatus:obj];\
[SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];}
#define MTSVPShowWithTextMask(obj) {[SVProgressHUD showWithStatus:obj];\
[SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];}
#define MTSVPShowInfoText(obj) {[SVProgressHUD showInfoWithStatus:obj];\
[SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeNone];}

#define MTSVPShowSuccessWithText(obj) {[SVProgressHUD showSuccessWithStatus:obj];}

#define MTSVPDismiss  [SVProgressHUD dismiss]

//
#define MTUUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]


/*字体*/
//字体
/*方正 Font: FZLTCHJW--GB1-0 粗黑
 Font: FZLTHJW--GB1-0 黑
 Font: FZLTXHJW--GB1-0 细黑
 */
#define MTBaseFontBold @"STHeitiSC-Medium" //基本字体
#define MTBaseFont @"STHeitiSC-Light"
#define MTFont(fontName, s) [UIFont fontWithName:fontName size:(s)]

/*判断空对象*/
#define ObjIsNotNull(a)                 a != nil && a != [NSNull null]
#define NullObjToString(a)              ObjIsNotNull(a) ? a : @""

#define WeakSelf(weakSelf)  __weak __typeof(&*self) weakSelf = self;

/*属性*/
#define COPY_NONATOMIC_PROPERTY @property (nonatomic, copy)
#define STRONG_NONATOMIC_PROPERTY @property (nonatomic, strong)
#define ASSIGN_NONATOMIC_PROPERTY @property (nonatomic, assign)
#define WEAK_NONATOMIC_PROPERTY   @property (nonatomic, weak)

/*调用函数*/
#define MTLogFun  MTLog(@"%s",__func__);

/*KeyWindow*/
#define MTKeyWindow [UIApplication sharedApplication].keyWindow


/*输出视图的frame边界*/
#define MTLogFrame(view)  MTLog(@"current Frame = %@",NSStringFromCGRect(view.frame) );

/*输出所有子视图*/
#define MTLogSubviews(view)  MTLog(@"%@",view.subviews);

/*获取UIStoryboard*/
#define MTStoryboards(name) [UIStoryboard storyboardWithName:name bundle:nil]
/*根据UIStoryboard的identifier获取ViewController*/
#define MTStoryboardsController(storyboards, identifier) [MTStoryboards(storyboards) instantiateViewControllerWithIdentifier:identifier]

/*获取Xib*/
#define MTXib(name) [UINib nibWithNibName:name bundle:nil]

/*消息发送*/
#import <objc/message.h>
#define MTMessageSend(target, action, ...) ((void(*)(id, SEL, ...))objc_msgSend)(target, action, ## __VA_ARGS__)

/*添加KVO观察者*/
#define MTAddKVOObserver(object, target, keyPath) [object addObserver:target forKeyPath:keyPath options:NSKeyValueObservingOptionInitial | NSKeyValueObservingOptionNew context:NULL]

/*移除KVO观察者*/
#define MTRemoveKVOObserver(object, target, keyPath) [object removeObserver:target forKeyPath:keyPath]

/*发送通知*/
#define MTPostNotification(name, obj, info) [[NSNotificationCenter defaultCenter] postNotificationName:name object:obj userInfo:info]

/*接收通知*/
#define MTAddNotificationObserver(observer, action, names, obj) [[NSNotificationCenter defaultCenter] addObserver:observer selector:action name:names object:obj]

/*移除通知*/
#define MTRemoveNotificationObserver(observer, names, obj) [[NSNotificationCenter defaultCenter] removeObserver:observer name:names object:obj]

//屏幕比例尺寸
#define MTGetHeightScale(w,scale) ((w)/(scale))
#define MTGetWidthScale(h,scale) ((h)*(scale))


#define kCurrentCity @"currentCity"//当前城市
#define kFEDefaultImg @"logo.png"  //defaultImg
#define kFECycleKM @"FECycleKM"  //本次骑行公里
#define kFECycleTime @"FECycleTime"  //本次骑行时间
#define kFEKMToElecNum @"FEKMToElecNum"  //公里转换电量的转换值
