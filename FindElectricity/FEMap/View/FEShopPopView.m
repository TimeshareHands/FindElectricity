//
//  FEShopPop.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/7.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEShopPopView.h"
@interface FEShopPopView()
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@end
@implementation FEShopPopView
- (void)setModel:(FEMapInfoModel *)model {
    _model = model;
    [_shopImg sd_setImageWithURL:[NSURL URLWithString:_model.brandImage] placeholderImage:[UIImage imageNamed:kFEDefaultImg]];
    _name.text = _model.merchantsName;
    _timeLab.text = [NSString stringWithFormat:@"营业时间：%@-%@",_model.openTime,_model.closeTime];
    _address.text = [NSString stringWithFormat:@"地址：%@",_model.area];
    _collectBtn.selected = ![_model.is_collection intValue];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)btnAct:(UIButton *)sender {
    if (sender.tag == 1) {
        //收藏
        [self collectRequest];
    }else if (sender.tag == 4){
        //打电话
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",_model.merchantsMobile]]];

    }
    if (_didClick&&_model.mapId) {
        _didClick(sender.tag,_model.mapId);
    }
}

- (void)collectRequest {
    NSMutableDictionary *parameter = [NSMutableDictionary dictionary];
    [parameter setValue:_model.mapId forKey:@"mapId"];
    WEAKSELF;
    [[NetWorkManger manager] postDataWithUrl:BASE_URLWith(MapCollectionHttp)  parameters:parameter needToken:YES timeout:25 success:^(id  _Nonnull responseObject) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakSelf.collectBtn setSelected:!weakSelf.collectBtn.selected];
        });
        
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
@end
