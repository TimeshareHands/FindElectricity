//
//  FEMapManager.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMapManager.h"


@interface FEMapManager()<AMapSearchDelegate>
@property (strong,nonatomic) AMapSearchAPI *search;
@property (copy,nonatomic) AMapSearchFinishBlock responseBlock;
@end

static FEMapManager *manager = nil;
@implementation FEMapManager
+ (FEMapManager *)manager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[FEMapManager alloc] init];
    });
    return manager;
}

- (AMapSearchAPI *)search {
    if(!_search){
        _search = [[AMapSearchAPI alloc] init];
        _search.delegate = self;
    }
    return _search;
}

//获取逆地理位置信息
- (void)regSearchFromCoord:(CLLocationCoordinate2D)point finishBlock:(AMapSearchFinishBlock)block{
    _responseBlock = block;
    AMapReGeocodeSearchRequest *regReq = [[AMapReGeocodeSearchRequest alloc] init];

    regReq.location = [AMapGeoPoint locationWithLatitude:point.latitude longitude:point.longitude];
    regReq.requireExtension = YES;
    [self.search AMapReGoecodeSearch:regReq];
}

//获取2点直线距离
- (void)getDistanceFromCoord:(CLLocationCoordinate2D)from toCoord:(CLLocationCoordinate2D)toCoord finishBlock:(AMapSearchFinishBlock)block{
    _responseBlock = block;
    AMapDistanceSearchRequest *distanReq = [[AMapDistanceSearchRequest alloc] init];
    distanReq.origins = @[[AMapGeoPoint locationWithLatitude:from.latitude longitude:from.longitude]];
    distanReq.destination = [AMapGeoPoint locationWithLatitude:toCoord.latitude longitude:toCoord.longitude];
    distanReq.type = 0;
    [self.search AMapDistanceSearch:distanReq];
}

//获取天气信息
- (void)weatherSearchCity:(NSString *)city finishBlock:(AMapSearchFinishBlock)block{
    _responseBlock = block;
    AMapWeatherSearchRequest *regReq = [[AMapWeatherSearchRequest alloc] init];

    regReq.city = city;
    [self.search AMapWeatherSearch:regReq];
}

#pragma mark AMapSearchAPI delegete
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        if (_responseBlock) {
            _responseBlock(response,FEAMapSearchTypeReGeocode,NULL);
        }
    }
    else{
        
    }
}

- (void)onDistanceSearchDone:(AMapDistanceSearchRequest *)request response:(AMapDistanceSearchResponse *)response {
    if(response.results != nil)
    {
        if (_responseBlock) {
            _responseBlock(response,FEAMapSearchTypeDistance,NULL);
        }
    }
    else{
        
    }
}

- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response{
    if(response.lives != nil)
    {
        if (_responseBlock) {
            _responseBlock(response,FEAMapSearchTypeWeather,NULL);
        }
    }
    else{
        
    }
}

- (void)dealloc
{
    MYLog(@"----")
}
@end
