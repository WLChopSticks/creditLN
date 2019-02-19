//
//  WLRewardAndPunishListCell.h
//  CreditChina
//
//  Created by 王磊 on 2019/2/19.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLBaseTableViewCell.h"


@interface WLRewardAndPunishListCell : WLBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *title;
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *xybsm;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

