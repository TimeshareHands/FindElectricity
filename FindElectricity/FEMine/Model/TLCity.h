//
//  TLCity.h
//  TLCityPickerDemo
//
//  Created by DongQiangLi on 2017/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - TLCity
@interface TLCity : NSObject

/*
 *  城市ID
 */
@property (nonatomic, strong) NSString *cityID;

/*
 *  城市名称
 */
@property (nonatomic, strong) NSString *cityName;

/*
 *  短名称
 */
@property (nonatomic, strong) NSString *shortName;

/*
 *  城市名称-拼音
 */
@property (nonatomic, strong) NSString *pinyin;

/*
 *  城市名称-拼音首字母
 */
@property (nonatomic, strong) NSString *initials;

@end


#pragma mark - TLCityGroup
@interface TLCityGroup : NSObject

/*
 *  分组标题
 */
@property (nonatomic, strong) NSString *groupName;

/*
 *  城市数组
 */
@property (nonatomic, strong) NSMutableArray *arrayCitys;

@end
