//
//  FEWorkInviteFriendRecordCell.h
//  FindElectricity
//
//  Created by 豪锅锅 on 2019/10/13.
//  Copyright © 2019 LiDongQiang. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FEWorkInviteFriendRecordCell : UITableViewCell
-(void)fillLeftImage:(NSString*)imgUrl num:(NSString *)num nickName:(NSString *)nickName type:(NSString *)type  ctime:(NSString *)ctime;
@end

NS_ASSUME_NONNULL_END
