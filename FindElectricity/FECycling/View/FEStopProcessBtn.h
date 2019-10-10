//
//  FEStopProcessBtn.h
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FEStopProcessBtn;
NS_ASSUME_NONNULL_BEGIN
typedef void(^LoadingBegin)(FEStopProcessBtn *btn);
typedef void(^LoadingEnd)(FEStopProcessBtn *btn);
@interface FEStopProcessBtn : UIButton
#pragma mark - 是否正在加载
@property(nonatomic,assign,readonly)BOOL isLoading;

#pragma mark - 每次动画运行的时间
@property(nonatomic,assign)NSTimeInterval duration;

#pragma mark - 线宽度
@property(nonatomic,assign)CGFloat loadingLineWidth;

#pragma mark - 加载线的颜色
@property(nonatomic,strong)UIColor *loadingTintColor;

#pragma mark - 加载层
@property(nonatomic,strong,readonly)CAShapeLayer *loadingLayer;

#pragma mark - 动画开始回调
@property(nonatomic,strong)LoadingBegin beginBlock;

#pragma mark - 动画结束回调
@property(nonatomic,strong)LoadingEnd endBlock;

#pragma mark - 加载时是否disable按钮
@property(nonatomic,assign)BOOL disableWhenLoad;

//#pragma mark - 倒计时lab
//@property (nonatomic,strong) UILabel *timeLab;

#pragma mark - 开始加载
-(void)beginLoading;

#pragma mark - 停止加载
-(void)endLoading;

#pragma mark - cancel
-(void)cancelLoading;
@end

NS_ASSUME_NONNULL_END
