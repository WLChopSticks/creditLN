//
//  WLLegalPeopleBusinessCell.h
//  CreditChina
//
//  Created by 王磊 on 2019/2/21.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLLegalPeopleBusinessCell : WLBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *signupNo;
@property (weak, nonatomic) IBOutlet UILabel *ASYear;
@property (weak, nonatomic) IBOutlet UILabel *ASResult;

@end

NS_ASSUME_NONNULL_END
