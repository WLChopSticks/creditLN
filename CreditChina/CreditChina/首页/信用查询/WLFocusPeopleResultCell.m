//
//  WLFocusPeopleResultCell.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/13.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLFocusPeopleResultCell.h"

@implementation WLFocusPeopleResultCell

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
    self.name.text = contentDict[@"name"];
    self.job.text = contentDict[@"job"];
    self.grade.text = contentDict[@"grade"];
    self.idCard.text = contentDict[@"idCard"];
    self.number.text = contentDict[@"number"];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath withContentDict:(NSDictionary *)dict
{
    return 90;
}

@end
