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
@property (copy,nonatomic) AMapSearchFinishBlock distanceBlock;
@property (copy,nonatomic) AMapSearchFinishBlock regBlock;
@property (copy,nonatomic) AMapSearchFinishBlock weatherBlock;
@property (copy,nonatomic) AMapSearchFinishBlock poiBlock;
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
    _regBlock = block;
    AMapReGeocodeSearchRequest *regReq = [[AMapReGeocodeSearchRequest alloc] init];

    regReq.location = [AMapGeoPoint locationWithLatitude:point.latitude longitude:point.longitude];
    regReq.requireExtension = YES;
    [self.search AMapReGoecodeSearch:regReq];
}

//获取2点直线距离
- (void)getDistanceFromCoord:(CLLocationCoordinate2D)from toCoord:(CLLocationCoordinate2D)toCoord finishBlock:(AMapSearchFinishBlock)block{
    _distanceBlock = block;
    AMapDistanceSearchRequest *distanReq = [[AMapDistanceSearchRequest alloc] init];
    distanReq.origins = @[[AMapGeoPoint locationWithLatitude:from.latitude longitude:from.longitude]];
    distanReq.destination = [AMapGeoPoint locationWithLatitude:toCoord.latitude longitude:toCoord.longitude];
    distanReq.type = 0;
    [self.search AMapDistanceSearch:distanReq];
}

//获取天气信息
- (void)weatherSearchCity:(NSString *)city finishBlock:(AMapSearchFinishBlock)block{
    _weatherBlock = block;
    AMapWeatherSearchRequest *regReq = [[AMapWeatherSearchRequest alloc] init];

    regReq.city = city;
    [self.search AMapWeatherSearch:regReq];
}

//获取POI信息
- (void)poiSearchKeywords:(NSString *)keywords finishBlock:(AMapSearchFinishBlock)block{
    _poiBlock = block;
    AMapPOIKeywordsSearchRequest *regReq = [[AMapPOIKeywordsSearchRequest alloc] init];

    regReq.keywords = keywords;
    [self.search AMapPOIKeywordsSearch:regReq];
}

#pragma mark AMapSearchAPI delegete
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        if (_regBlock) {
            _regBlock(response,FEAMapSearchTypeReGeocode,NULL);
        }
    }
    else{
        
    }
}

- (void)onDistanceSearchDone:(AMapDistanceSearchRequest *)request response:(AMapDistanceSearchResponse *)response {
    if(response.results != nil)
    {
        if (_distanceBlock) {
            _distanceBlock(response,FEAMapSearchTypeDistance,NULL);
        }
    }
    else{
        
    }
}

- (void)onWeatherSearchDone:(AMapWeatherSearchRequest *)request response:(AMapWeatherSearchResponse *)response{
    if(response.lives != nil)
    {
        if (_weatherBlock) {
            _weatherBlock(response,FEAMapSearchTypeWeather,NULL);
        }
    }
    else{
        
    }
}

- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response{
    if(response.count)
    {
        if (_poiBlock) {
            _poiBlock(response,FEAMapSearchTypePOI,NULL);
        }
    }
}

- (void)dealloc
{
    _distanceBlock = nil;
    _weatherBlock = nil;
    _regBlock = nil;
    _poiBlock = nil;
//    MYLog(@"--FEMapManager dealloc--")
}
@end
