//
//  WLPersonResultCell.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/13.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLPersonResultCell.h"

@implementation WLPersonResultCell

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
    self.receiveTime.text = contentDict[@"receiveTime"];
    self.idCard.text = contentDict[@"idCard"];
    self.tableName.text = contentDict[@"tableName"];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath withContentDict:(NSDictionary *)dict
{
    return 85;
}

@end
