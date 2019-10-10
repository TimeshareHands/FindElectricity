//
//  FEStopProcessBtn.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEStopProcessBtn.h"

static NSString *kLoadButtonStrokeAnimationKey = @"UGCCameraingBtn.stroke";
static NSString *kLoadButtonRotationAnimationKey = @"UGCCameraingBtn.rotation";
#if defined(__IPHONE_10_0) && (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0)
@interface FEStopProcessBtn ()<CAAnimationDelegate>{
#else
@interface FEStopProcessBtn (){
#endif
    CGRect _originalFrame;
    CAShapeLayer *_loadingLayer;
    CGFloat _orginalCornerRadius;
    NSTimer *_timer;
}
@property (nonatomic,assign) NSTimeInterval didloadTime;

@property(nonatomic,assign) BOOL isCancelLoading;
@end

@implementation FEStopProcessBtn
- (void)awakeFromNib {
    [super awakeFromNib];
    [self initConfig];
}

#pragma mark - 初始化方法
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _originalFrame = frame;
        [self initConfig];
    }
    return self;
}
    
#pragma mark - 配置
-(void)initConfig{
    
    self.layer.masksToBounds = YES;
    
    // 是否正在加载
    _isLoading = NO;
    
    // 动画时间
    _duration = 1.5f;
    
    // 线的宽度
    _loadingLineWidth = 2.f;
    
    // 加载颜色
    _loadingTintColor = UIColorFromHex(0x04bb2d);
    
    // 添加图层
    [self.layer insertSublayer:self.loadingLayer atIndex:0];
    
//    _timeLab = [UILabel new];
//    _timeLab.textAlignment  = NSTextAlignmentCenter;
//    _timeLab.textColor = [UIColor whiteColor];
//    _timeLab.font = MTFont(MTBaseFont, 14);
//    [self addSubview:_timeLab];
    
//    [_timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.height.width.equalTo(self);
//    }];
    
    // 添加观察
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(resumeAnimation) name:UIApplicationDidBecomeActiveNotification object:nil];
}
    
-(void)continueAnimation{
    _didloadTime += 0.05;
    CGFloat time = _duration-_didloadTime;
    if (time<= 0)
    {
        time = 0.0;
    }
//    [_timeLab setText:[NSString stringWithFormat:@"%.1f",time]];
}

#pragma mark - dealloc方法
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
    [_timer invalidate];
    _timer = nil;
}

#pragma mark - 恢复动画
-(void)resumeAnimation{
    if (self.isLoading) {
        [self endLoading];
        [self beginLoading];
//        _timeLab.text = @"";
        [_timer invalidate];
        _timer = nil;
    }
}

#pragma mark - 加载图层
-(CAShapeLayer*)loadingLayer{
    if (!_loadingLayer) {
        _loadingLayer = [CAShapeLayer layer];
        _loadingLayer.fillColor = [UIColor clearColor].CGColor;
        _loadingLayer.strokeColor = self.loadingTintColor.CGColor;
        _loadingLayer.strokeEnd = 0;
        _loadingLayer.strokeStart = 0;
    }
    _loadingLayer.lineWidth = self.loadingLineWidth;
    return _loadingLayer;
}


#pragma mark - 切换动画
-(void)toggle{
    _isLoading ? [self endLoading] : [self beginLoading];
}


#pragma mark - 开始加载
-(void)beginLoading{
    self.selected  = YES;
    if (self.isLoading) {
        return;
    }
    
    _orginalCornerRadius = self.layer.cornerRadius;
    _isLoading = !self.isLoading;
    _isCancelLoading = NO;
    if(self.disableWhenLoad){
        self.userInteractionEnabled = NO;
    }
    __weak typeof (self) mySelf = self;
    
    [mySelf addLoadingAnimation];
    
    _didloadTime = 0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(continueAnimation) userInfo:nil repeats:YES];
}

#pragma mark - 重写layoutSubviews方法
-(void)layoutSubviews{
    [super layoutSubviews];
    self.loadingLayer.frame = self.bounds;
    [self updatePath];
}

#pragma mark - 更新路径
- (void)updatePath {
    CGPoint center = CGPointMake(CGRectGetWidth(self.bounds)/2, CGRectGetHeight(self.bounds)/2);
    CGFloat radius = MIN(CGRectGetWidth(self.bounds) / 2, CGRectGetHeight(self.bounds) / 2) - self.loadingLayer.lineWidth / 2;
    CGFloat startAngle = (CGFloat)(-M_PI_2);
    CGFloat endAngle = (CGFloat)(3*M_PI_2);
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:center radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES];
    self.loadingLayer.path = path.CGPath;
    self.loadingLayer.strokeStart = 0.f;
    self.loadingLayer.strokeColor = self.loadingTintColor.CGColor;
    self.loadingLayer.strokeEnd = 0.f;
}

#pragma mark - 结束动画
-(void)endLoading{
    if (!self.isLoading) {
        return;
    }
    _isLoading = !self.isLoading;
    if (self.disableWhenLoad){
        self.userInteractionEnabled = YES;
    }
    [self.loadingLayer removeAnimationForKey:kLoadButtonStrokeAnimationKey];
    self.selected = NO;
//    _timeLab.text = @"";
    [_timer invalidate];
    _timer = nil;
}
    
-(void)cancelLoading
{
    _isCancelLoading = YES;
    [self endLoading];
}

#pragma mark - 添加动画
-(void)addLoadingAnimation{
    
    CABasicAnimation *tailAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    tailAnimation.fromValue = @0;
    tailAnimation.toValue = @1;
    tailAnimation.duration = self.duration;
    tailAnimation.delegate = self;
    tailAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    [self.loadingLayer addAnimation:tailAnimation forKey:kLoadButtonStrokeAnimationKey];
}

#pragma mark - 代理方法
-(void)animationDidStart:(CAAnimation *)anim{
    if(self.beginBlock){
        __weak typeof (self) mySelf = self;
        self.beginBlock(mySelf);
    }
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    __weak typeof (self) mySelf = self;
    [self endLoading];
    if(mySelf.endBlock&&!_isCancelLoading){
        //完成一段录制
        mySelf.endBlock(mySelf);
    }
}
    
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self beginLoading];
}
    
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    if(_didloadTime>=_duration){
        [self endLoading];
    }else{
        [self cancelLoading];
    }
}

@end
