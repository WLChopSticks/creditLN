//
//  WLRewardAndPunishListCell.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/19.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLRewardAndPunishListCell.h"

@implementation WLRewardAndPunishListCell

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
    self.title.text = contentDict[@"title"];
    self.company.text = contentDict[@"company"];
    self.time.text = contentDict[@"time"];
    self.xybsm.text = contentDict[@"xybsm"];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath withContentDict:(NSDictionary *)dict
{
    return 85;
}

@end
