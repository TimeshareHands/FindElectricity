//
//  FEMessageCell.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/7.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMessageCell.h"

@implementation FEMessageCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setModel:(FEMessageModel *)model {
    _model = model;
    _timeLab.text = model.ctime;
    _titleLab.text = model.title;
    _detailLab.text = model.msg;
    _red.hidden = [_model.is_read boolValue];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
