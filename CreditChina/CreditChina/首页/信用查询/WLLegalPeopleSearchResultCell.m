//
//  WLLegalPeopleSearchResultCell.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/12.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLLegalPeopleSearchResultCell.h"

@implementation WLLegalPeopleSearchResultCell

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
    self.companyName.text = contentDict[@"company"];
    self.legalPeopleName.text = contentDict[@"legalPeople"];
    self.signupNo.text = contentDict[@"signupNo"];
    self.address.text = contentDict[@"address"];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath withContentDict:(NSDictionary *)dict
{
    return 85;
}

@end
