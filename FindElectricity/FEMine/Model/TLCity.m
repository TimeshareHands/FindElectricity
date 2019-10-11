//
//  TLCity.m
//  TLCityPickerDemo
//
//  Created by DongQiangLi on 2017/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "TLCity.h"

@implementation TLCity

@end

#pragma mark - TLCityGroup
@implementation TLCityGroup

- (NSMutableArray *) arrayCitys
{
    if (_arrayCitys == nil) {
        _arrayCitys = [[NSMutableArray alloc] init];
    }
    return _arrayCitys;
}

@end
