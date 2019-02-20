//
//  WLLegalPeopleBasicInfoCell.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/20.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLLegalPeopleBasicInfoCell.h"

@implementation WLLegalPeopleBasicInfoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)fillCellContent:(NSDictionary *)contentDict withTableView:(UITableView *)tableView
{
    self.company.text = contentDict[@"company"];
    self.organiseNo.text = contentDict[@"organiseNo"];
    self.certificateNo.text = contentDict[@"certificateNo"];
    self.address.text = contentDict[@"address"];
    self.legalPeople.text = contentDict[@"legalPeople"];
    self.firstCertificateDate.text = contentDict[@"firstCertificateDate"];
    self.validStartDate.text = contentDict[@"validStartDate"];
    self.validEndDate.text = contentDict[@"validEndDate"];
    self.latestReviewDate.text = contentDict[@"latestReviewDate"];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath withContentDict:(NSDictionary *)dict
{
    return 140;
}

@end
