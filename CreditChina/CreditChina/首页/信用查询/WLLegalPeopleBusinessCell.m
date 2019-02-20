//
//  WLLegalPeopleBusinessCell.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/21.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLLegalPeopleBusinessCell.h"

@implementation WLLegalPeopleBusinessCell

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
    self.signupNo = contentDict[@"signupNo"];
    self.ASYear = contentDict[@"ASYear"];
    self.ASResult = contentDict[@"ASResult"];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath withContentDict:(NSDictionary *)dict
{
    return 80;
}

@end
