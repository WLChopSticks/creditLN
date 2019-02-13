//
//  WLFocusPeopleResultCell.h
//  CreditChina
//
//  Created by 王磊 on 2019/2/13.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLFocusPeopleResultCell : WLBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *job;
@property (weak, nonatomic) IBOutlet UILabel *grade;
@property (weak, nonatomic) IBOutlet UILabel *idCard;
@property (weak, nonatomic) IBOutlet UILabel *number;

@end

NS_ASSUME_NONNULL_END
