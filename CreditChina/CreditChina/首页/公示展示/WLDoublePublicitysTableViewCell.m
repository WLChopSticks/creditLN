//
//  WLDoublePublicitysTableViewCell.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/11.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLDoublePublicitysTableViewCell.h"

@implementation WLDoublePublicitysTableViewCell

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
    self.content.text = contentDict[@"content"];
    self.time.text = contentDict[@"time"];
    self.shuwenhao.text = contentDict[@"shuwenhao"];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath withContentDict:(NSDictionary *)dict
{
    return 90;
}

@end
