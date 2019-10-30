//
//  FEMapCategView.m
//  FindElectricity
//
//  Created by 李冬强 on 2019/10/8.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import "FEMapCategView.h"
@interface FEMapCategView()
@property (weak, nonatomic) IBOutlet UIImageView *select1;
@property (weak, nonatomic) IBOutlet UIImageView *select2;
@property (weak, nonatomic) IBOutlet UIImageView *select3;
@property (strong, nonatomic) NSMutableArray *serverIds;
@end
@implementation FEMapCategView
- (void)show {
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow addSubview:self];
}

- (void)hidden {
    [self removeFromSuperview];
//    [self setHidden:YES];
}

//拼接serverID
- (void)serverID:(NSString *)sID isAdd:(BOOL)isAdd {
    if (isAdd) {
        [self.serverIds containsObject:sID]? : [self.serverIds addObject:sID];
    }else {
        ![self.serverIds containsObject:sID]? : [self.serverIds removeObject:sID];
    }
}

- (NSMutableArray *)serverIds {
    if (!_serverIds) {
        _serverIds = [NSMutableArray arrayWithArray:@[@"1",@"2",@"3"]];
    }
    return _serverIds;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (IBAction)tapAction:(UIButton *)sender {
    if (sender.tag==4){
        [self hidden];
        if (_comfirm) {
            NSString *status = [self getType];
            _comfirm(self,status);
        }
    }else if (sender.tag == 3){
        sender.selected = !sender.selected;
        _select3.hidden = !_select3.hidden;
        [self serverID:[NSString stringWithFormat:@"%d",sender.tag] isAdd:sender.selected];
    }else if (sender.tag == 1){
        sender.selected = !sender.selected;
        _select1.hidden = !_select1.hidden;
        [self serverID:[NSString stringWithFormat:@"%d",sender.tag] isAdd:sender.selected];
    }else if (sender.tag == 2){
        sender.selected = !sender.selected;
        _select2.hidden = !_select2.hidden;
        [self serverID:[NSString stringWithFormat:@"%d",sender.tag] isAdd:sender.selected];
    }else {
        [self hidden];
    }
}

- (NSString *)getType
{
    if (_serverIds.count!=3) {
        return [NSString stringWithFormat:@"%@|%@",[_serverIds componentsJoinedByString:@"|"],[_serverIds componentsJoinedByString:@","]];
    }else {
        return @"1,2|1,3|2,3|1,2,3|1|2|3";
    }
}

@end
