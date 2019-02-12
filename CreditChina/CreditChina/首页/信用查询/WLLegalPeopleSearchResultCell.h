//
//  WLLegalPeopleSearchResultCell.h
//  CreditChina
//
//  Created by 王磊 on 2019/2/12.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLBaseTableViewCell.h"



@interface WLLegalPeopleSearchResultCell : WLBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *companyName;

@property (weak, nonatomic) IBOutlet UILabel *legalPeopleName;
@property (weak, nonatomic) IBOutlet UILabel *signupNo;
@property (weak, nonatomic) IBOutlet UILabel *address;


@end


