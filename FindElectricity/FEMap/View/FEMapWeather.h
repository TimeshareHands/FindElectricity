//
//  FEMapWeather.h
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/6.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
NS_ASSUME_NONNULL_BEGIN

@interface FEMapWeather : UIView
@property (strong, nonatomic) AMapLocalWeatherLive *live;
@end

NS_ASSUME_NONNULL_END
