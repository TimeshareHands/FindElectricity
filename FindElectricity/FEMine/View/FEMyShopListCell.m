//
//  FEMyShopListCell.m
//  FindElectricity
//
//  Created by DongQiangLi on 2019/10/10.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMyShopListCell.h"

@implementation FEMyShopListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setModel:(FEMySHopListMode *)model {
    _model = model;
    _titleLab.text = [NSString stringWithFormat:@"%@",_model.merchantsName];
    _phoneLab.text = [NSString stringWithFormat:@"联系电话：%@",_model.merchantsMobile];
    _timeLab.text = [NSString stringWithFormat:@"营业时间：%@-%@",_model.openTime,_model.closeTime];
    _addressLab.text = [NSString stringWithFormat:@"%@",_model.area];
    NSInteger isPass = [_model.isPass integerValue];
    if (isPass == 0) {
        _stateLab.text = @"未通过";
    }else if (isPass == 1) {
        _stateLab.text = @"通过";
    }else {
        _stateLab.text = @"待审核";
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
