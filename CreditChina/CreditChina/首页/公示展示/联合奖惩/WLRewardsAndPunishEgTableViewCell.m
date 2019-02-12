//
//  WLRewardsAndPunishEgTableViewCell.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/11.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLRewardsAndPunishEgTableViewCell.h"

@implementation WLRewardsAndPunishEgTableViewCell

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
    self.caseName.text = contentDict[@"caseName"];
    self.subTitle.text = contentDict[@"subtitle"];
    self.time.text = contentDict[@"time"];
    if (contentDict[@"symbol"])
    {
        self.symbolLabel.hidden = NO;
        self.symbolLabel.text = contentDict[@"symbol"];
        if ([contentDict[@"symbol"] hasPrefix:@"黑"])
        {
            self.symbolLabel.backgroundColor = [UIColor blackColor];
            self.symbolLabel.textColor = [UIColor whiteColor];
        }else if ([contentDict[@"symbol"] hasPrefix:@"红"])
        {
            self.symbolLabel.backgroundColor = [UIColor redColor];
            self.symbolLabel.textColor = [UIColor whiteColor];
        }
    }
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath withContentDict:(NSDictionary *)dict
{
    return 85;
}

@end
