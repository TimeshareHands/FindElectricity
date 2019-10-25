//
//  MagMainCollectionViewCell.m
//  picsmagicartae
//
//  Created by 豪锅锅 on 2019/10/15.
//  Copyright © 2019 zn. All rights reserved.
//

#import "FEWorkGiftCollectionViewCell.h"
@interface FEWorkGiftCollectionViewCell()
@property (nonatomic, strong)UIImageView *imgLogoV;
@end

@implementation FEWorkGiftCollectionViewCell
-(id)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:frame]) {
        self.imgLogoV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.imgLogoV.autoresizingMask =UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        [self.contentView addSubview:self.imgLogoV];
        [self.imgLogoV setClipsToBounds:YES];
        [self.imgLogoV setImage:[UIImage imageNamed:@"wkc_unWin"]];
        self.backgroundColor =[UIColor whiteColor];
//        self.layer.cornerRadius =12;
    }
    return self;
}

-(void)prepareForReuse{
    [self.imgLogoV setImage:[UIImage imageNamed:@"wkc_unWin"]];
}

-(void)setImage:(UIImage *)imgLogo{
    [self.imgLogoV setImage:imgLogo];
    
}
@end
