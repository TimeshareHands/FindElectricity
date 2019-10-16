//
//  FEMapWeather.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/6.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMapWeather.h"
@interface FEMapWeather()
@property (nonatomic, strong) UIImageView *icon;
@property (nonatomic, strong) UILabel *weather;
@property (nonatomic, strong) UILabel *temp;
@end

@implementation FEMapWeather

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
    }
    return self;
}

- (void)addView {
    [self addSubview:self.icon];
    [self addSubview:self.weather];
    [self addSubview:self.temp];
    [self makeUpconstriant];
}

- (void)makeUpconstriant {
    [self.icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(0);
        make.width.mas_equalTo(24);
        make.height.mas_equalTo(24);
        make.centerY.mas_equalTo(self);
    }];
    [self.weather mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.icon.mas_right).offset(10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(self.icon).offset(0);
    }];
    [self.temp mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.weather);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(15);
        make.top.mas_equalTo(self.weather.mas_bottom);
    }];
}

-(UIImageView *) icon {
    if (!_icon) {
        _icon = [[UIImageView alloc] init];
        _icon.image = [UIImage imageNamed:@"map_sunny"];
    }
    return _icon;
}

- (UILabel *)weather {
    if (!_weather) {
        _weather = [[UILabel alloc] init];
        [_weather setText:@"多云"];
        _weather.textColor = UIColorFromHex(0x000);
        [_weather setFont:Demon_12_Font];
    }
    return _weather;
}

- (UILabel *)temp {
    if (!_temp) {
        _temp = [[UILabel alloc] init];
        [_temp setText:@"23°C"];
        _temp.textColor = UIColorFromHex(0x000);
        [_temp setFont:Demon_12_Font];
    }
    return _temp;
}

- (void)setLive:(AMapLocalWeatherLive *)live {
    _live = live;
    _temp.text = [NSString stringWithFormat:@"%@°C",_live.temperature];
    NSString *weather = _live.weather;
    _weather.text = _live.weather;
    if ([weather containsString:@"雪"]) {
        _icon.image = [UIImage imageNamed:@"map_snowy"];
    }else if ([weather containsString:@"晴"]) {
        _icon.image = [UIImage imageNamed:@"map_sunny"];
    }else if ([weather containsString:@"雨"]) {
        _icon.image = [UIImage imageNamed:@"map_rain"];
    }else{
        _icon.image = [UIImage imageNamed:@"map_duoyun"];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
