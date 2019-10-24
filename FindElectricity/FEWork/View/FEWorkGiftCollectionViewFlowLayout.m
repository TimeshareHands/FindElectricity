//
//  MagMainCollectionViewFlowLayout.m
//  picsmagicartae
//
//  Created by 豪锅锅 on 2019/10/15.
//  Copyright © 2019 zn. All rights reserved.
//

#import "FEWorkGiftCollectionViewFlowLayout.h"


@implementation FEWorkGiftCollectionViewFlowLayout
- (id)init{
    if (self =[super init]) {
        self.itemSize =CGSizeMake(WIDTH_LY(40), HEIGHT_LY(50));
        self.sectionInset =UIEdgeInsetsMake(WIDTH_LY(20),  WIDTH_LY(10), 0,  WIDTH_LY(10));
        self.minimumLineSpacing = WIDTH_LY(10);
        self.minimumInteritemSpacing = WIDTH_LY(10);
    }
    return self;
}
@end
