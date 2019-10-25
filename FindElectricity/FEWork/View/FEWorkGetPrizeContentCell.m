//
//  FEWorkGetPrizeContentCell.m
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEWorkGetPrizeContentCell.h"
#import "FEWorkGiftCollectionViewCell.h"
#import "FEWorkGiftCollectionViewFlowLayout.h"
static NSString *ItemIdentifier = @"ItemIdentifier";
@interface FEWorkGetPrizeContentCell()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic, strong)UIView *whiteView;
@property(nonatomic, strong)UICollectionView *myCollectionView;
@property(nonatomic, strong)UIImageView *rightImageView;
@property(nonatomic, strong)UILabel *bottomLeftLabel;
@property(nonatomic, strong)UIButton *bottomRightBtn;
@property(nonatomic, assign)NSInteger winNum;
@property(nonatomic, assign)NSInteger num;
@end

@implementation FEWorkGetPrizeContentCell
-(id)init{
    if (self =[super init]) {
        [self addView];
    }
    return self;
}

#pragma mark -添加视图
-(void)addView{
    [self addSubview:self.whiteView];
    [self.whiteView addSubview:self.myCollectionView];
    [self.whiteView addSubview:self.rightImageView];
    [self.whiteView addSubview:self.bottomRightBtn];
    [self.whiteView addSubview:self.bottomLeftLabel];
    [self makeUpConstraint];
}

#pragma mark -约束适配
-(void)makeUpConstraint{
    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_LY(10));
        make.right.mas_equalTo(WIDTH_LY(-10));
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(WIDTH_LY(-5));
    }];
    [self.myCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_LY(10));
        make.width.mas_equalTo(200);
        make.top.mas_equalTo(WIDTH_LY(20));
        make.height.mas_equalTo(200);
    }];
    [self.rightImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(WIDTH_LY(130));
        make.right.mas_equalTo(WIDTH_LY(-10));
        make.centerY.mas_equalTo(self.myCollectionView);
        make.height.mas_equalTo(WIDTH_LY(160));
    }];
    [self.bottomLeftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(WIDTH_LY(5));
        make.top.mas_equalTo(self.myCollectionView.mas_bottom).offset((20));
    }];
    [self.bottomRightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.rightImageView);
        make.width.mas_equalTo(WIDTH_LY(60));
        make.height.mas_equalTo(WIDTH_LY(25));
        make.centerY.mas_equalTo(self.bottomLeftLabel);
    }];
    
}
#pragma mark -getter
-(UIView *)whiteView{
    if (!_whiteView) {
        _whiteView =[[UIView alloc]init];
        [_whiteView setBackgroundColor:[UIColor whiteColor]];
    }
    return _whiteView;
}
-(UICollectionView *)myCollectionView{
    if (!_myCollectionView) {
        FEWorkGiftCollectionViewFlowLayout *flowLayout =[[FEWorkGiftCollectionViewFlowLayout alloc]init];
        _myCollectionView =[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        [_myCollectionView setDelegate:self];
        [_myCollectionView setDataSource:self];
        [_myCollectionView setBackgroundColor:[UIColor clearColor]];
        _myCollectionView.indicatorStyle =UIScrollViewIndicatorStyleWhite;
        [_myCollectionView registerClass:[FEWorkGiftCollectionViewCell class] forCellWithReuseIdentifier:ItemIdentifier];
    }
    return _myCollectionView;
}
-(UIImageView *)rightImageView{
    if (!_rightImageView) {
        _rightImageView =[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"wkm_DetergentCard"]];
    }
    return _rightImageView;
}
-(UIButton *)bottomRightBtn{
    if (!_bottomRightBtn) {
        _bottomRightBtn =[UIButton buttonWithType:UIButtonTypeCustom];
        [_bottomRightBtn setTitle:@"领取" forState:UIControlStateNormal];
        [_bottomRightBtn setBackgroundColor:UIColorFromHex(0xD34E46)];
        [_bottomRightBtn.titleLabel setFont:Demon_15_Font];
        [_bottomRightBtn.layer setCornerRadius:12.5];
      
        WEAKSELF;
        [_bottomRightBtn bk_addEventHandler:^(id sender) {
            if ([weakSelf.localDelegate respondsToSelector:@selector(confirmToLinqu)]) {
                [weakSelf.localDelegate confirmToLinqu];
            }
        } forControlEvents:UIControlEventTouchUpInside];
    }
    return _bottomRightBtn;
}
-(UILabel *)bottomLeftLabel{
    if (!_bottomLeftLabel) {
        _bottomLeftLabel =[[UILabel alloc]init];
        [_bottomLeftLabel setText:@"再抽6张卫生纸卡，就可领取卫生纸1提"];
        [_bottomLeftLabel setFont:Demon_13_Font];
    }
    return _bottomLeftLabel;
}
-(void)setUnitText:(NSString *)unitText num:(NSString *)num title:(NSString *)title winNum:(NSString *)winNum pic:(NSString *)pic{
  
    [self.rightImageView setImageWithURL:[NSURL URLWithString:pic]];
    self.num =num.integerValue;
    self.winNum =winNum.integerValue;
     [self.bottomLeftLabel setText:[NSString stringWithFormat:@"再抽%zd张%@,就可领%@",self.num,title,unitText]];
    if (self.num>=self.winNum) {
         [self.bottomLeftLabel setText:[NSString stringWithFormat:@"再抽%@张%@,就可领%@",@"0",title,unitText]];
    }
   
    if (self.num <self.winNum) {
        [self.bottomRightBtn setBackgroundColor:CS_Color_MidGray];
        [self.bottomRightBtn setUserInteractionEnabled:NO];
    }else{
        [self.bottomRightBtn setBackgroundColor:UIColorFromHex(0xD34E46)];
        [self.bottomRightBtn setUserInteractionEnabled:YES];
    }
    [self.myCollectionView reloadData];
}
#pragma mark - UICollectionView DataSource & Delegate methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.winNum;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    FEWorkGiftCollectionViewCell *cell = (FEWorkGiftCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:ItemIdentifier forIndexPath:indexPath];
     if(indexPath.row<self.num){
        [cell setImage:[UIImage imageNamed:@"wkc_giftCard"]];
    }
    return cell;
}
@end
