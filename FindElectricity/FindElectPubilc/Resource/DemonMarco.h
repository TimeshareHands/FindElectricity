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

//主题颜色、副主题颜色
#define kThemeColor UIColorFromHex(0xeb4040)
#define kSubTopicColor UIColorFromHex(0xf23030)
