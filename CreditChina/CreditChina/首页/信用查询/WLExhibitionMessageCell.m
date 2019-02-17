//
//  WLExhibitionMessageCell.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/17.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLExhibitionMessageCell.h"

@implementation WLExhibitionMessageCell

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
    self.infoLabel.text = contentDict[@"content"];
    self.detailBtn.hidden = ![contentDict[@"showDetailBtn"]boolValue];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath withContentDict:(NSDictionary *)dict
{
    BOOL showDetailBtn = [dict[@"showDetailBtn"]boolValue];
    if (showDetailBtn)
    {
        return 40;
    }
    return 25;
}

@end
