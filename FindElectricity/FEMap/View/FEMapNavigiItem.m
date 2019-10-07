//
//  FEMapNavigiItem.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/4.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMapNavigiItem.h"
@interface FEMapNavigiItem()
@property (nonatomic, strong) UIImageView *redTip;
@property (nonatomic, strong) UIButton *taskBtn;
@property (nonatomic, strong) UIButton *messageBtn;
@end

@implementation FEMapNavigiItem

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self addView];
//        self.userInteractionEnabled = YES;
//        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (id)init{
    if (self = [super init]) {
        [self addView];
    }
    return self;
}

- (void)addView {
    [self addSubview:self.taskBtn];
    [self addSubview:self.messageBtn];
    [self.messageBtn addSubview:self.redTip];
    [self makeUpconstriant];
}

- (void)makeUpconstriant {
    [self.taskBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.messageBtn).offset(-40);
        make.width.mas_equalTo(21);
        make.height.mas_equalTo(21);
        make.centerY.mas_equalTo(self);
    }];
    [self.messageBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(0);
        make.width.mas_equalTo(21);
        make.height.mas_equalTo(21);
        make.centerY.mas_equalTo(self.taskBtn);
    }];
    [self.redTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.mas_equalTo(self.messageBtn);
        make.width.mas_equalTo(4);
        make.height.mas_equalTo(4);
    }];
}

- (UIButton *)taskBtn {
    if (!_taskBtn) {
        _taskBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _taskBtn.tag = 0;
        [_taskBtn setImage:[UIImage imageNamed:@"map_qiand"] forState:UIControlStateNormal];
        [_taskBtn bk_addEventHandler:^(UIButton *sender) {
            if (self.didTap) {
                self.didTap(sender.tag);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _taskBtn;
}

- (UIButton *)messageBtn {
    if (!_messageBtn) {
        _messageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_messageBtn setImage:[UIImage imageNamed:@"map_message"] forState:UIControlStateNormal];
        _messageBtn.tag = 1;
        [_messageBtn bk_addEventHandler:^(UIButton * sender) {
            if (self.didTap) {
                self.didTap(sender.tag);
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _messageBtn;
}

-(UIImageView *) redTip {
    if (!_redTip) {
        _redTip = [[UIImageView alloc] init];
        _redTip.backgroundColor = [UIColor redColor];
        _redTip.layer.cornerRadius = 2;
        _redTip.clipsToBounds = YES;
    }
    return _redTip;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
