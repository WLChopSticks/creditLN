//
//  WLRewardsAndPunishEgTableViewCell.h
//  CreditChina
//
//  Created by 王磊 on 2019/2/11.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLRewardsAndPunishEgTableViewCell : WLBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *caseName;
@property (weak, nonatomic) IBOutlet UILabel *subTitle;
@property (weak, nonatomic) IBOutlet UILabel *symbolLabel;
@property (weak, nonatomic) IBOutlet UILabel *time;

@end

NS_ASSUME_NONNULL_END
