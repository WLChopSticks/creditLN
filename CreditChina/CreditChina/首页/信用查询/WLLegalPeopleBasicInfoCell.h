//
//  WLLegalPeopleBasicInfoCell.h
//  CreditChina
//
//  Created by 王磊 on 2019/2/20.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLBaseTableViewCell.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLLegalPeopleBasicInfoCell : WLBaseTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *organiseNo;
@property (weak, nonatomic) IBOutlet UILabel *certificateNo;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *legalPeople;
@property (weak, nonatomic) IBOutlet UILabel *firstCertificateDate;
@property (weak, nonatomic) IBOutlet UILabel *validStartDate;
@property (weak, nonatomic) IBOutlet UILabel *validEndDate;
@property (weak, nonatomic) IBOutlet UILabel *latestReviewDate;

@end

NS_ASSUME_NONNULL_END
