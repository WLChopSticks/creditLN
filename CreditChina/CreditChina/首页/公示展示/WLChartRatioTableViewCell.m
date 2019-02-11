//
//  WLChartRatioTableViewCell.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/11.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLChartRatioTableViewCell.h"

@interface WLChartRatioTableViewCell ()

@property (nonatomic, assign) float cellHeight;

@end

@implementation WLChartRatioTableViewCell

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
    self.cellHeight = [WLChartRatioTableViewCell getCellHeightWithDict:contentDict andTableView:tableView];
    UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, self.cellHeight)];
    
    UILabel *firstItem = [[UILabel alloc]init];
    firstItem.numberOfLines = 0;
    firstItem.textAlignment =NSTextAlignmentCenter;
    firstItem.text = contentDict[@"firstItem"];
    firstItem.font = [UIFont systemFontOfSize:13];
    
    UILabel *secondItem = [[UILabel alloc]init];
    secondItem.numberOfLines = 0;
    secondItem.text = contentDict[@"secondItem"];
    secondItem.textAlignment =NSTextAlignmentCenter;
    secondItem.font = [UIFont systemFontOfSize:13];
    
    UILabel *thirdItem = [[UILabel alloc]init];
    thirdItem.numberOfLines = 0;
    thirdItem.text = contentDict[@"thirdItem"];
    thirdItem.textAlignment =NSTextAlignmentCenter;
    thirdItem.font = [UIFont systemFontOfSize:13];
    
    [backView addSubview:firstItem];
    [backView addSubview:secondItem];
    [backView addSubview:thirdItem];
    [self.contentView addSubview:backView];
    
    int viewWidth = tableView.frame.size.width;
    NSInteger firstItemRatio = [contentDict[@"firstItemWidth"]integerValue];
    NSInteger secondItemRatio = [contentDict[@"secondItemWidth"]integerValue];
    NSInteger thirdItemRatio = [contentDict[@"thirdItemWidth"]integerValue];
    
    
    NSInteger firstItemWidth = viewWidth * firstItemRatio / (firstItemRatio + secondItemRatio + thirdItemRatio);
    NSInteger secondItemWidth = viewWidth * secondItemRatio / (firstItemRatio + secondItemRatio + thirdItemRatio);
    NSInteger thirdItemWidth = viewWidth * thirdItemRatio / (firstItemRatio + secondItemRatio + thirdItemRatio);
    firstItem.frame = CGRectMake(0, 0, firstItemWidth, backView.frame.size.height);
    secondItem.frame = CGRectMake(CGRectGetMaxX(firstItem.frame), 0, secondItemWidth, backView.frame.size.height);
    thirdItem.frame = CGRectMake(CGRectGetMaxX(secondItem.frame), 0, thirdItemWidth, backView.frame.size.height);
    
    //设置背景颜色
    if (contentDict[@"firstItemBackground"] != nil)
    {
        firstItem.backgroundColor = contentDict[@"firstItemBackground"];
    }
    if (contentDict[@"secondItemBackground"] != nil)
    {
        firstItem.backgroundColor = contentDict[@"secondItemBackground"];
    }
    if (contentDict[@"thirdItemBackground"] != nil)
    {
        firstItem.backgroundColor = contentDict[@"thirdItemBackground"];
    }
    
    UIView *border1 = [self createBorderView];
    border1.frame = CGRectMake(0, 0, 0.5, backView.frame.size.height);
    UIView *border2 = [self createBorderView];
    border2.frame = CGRectMake(CGRectGetMaxX(firstItem.frame), 0, 0.5, backView.frame.size.height);
    UIView *border3 = [self createBorderView];
    border3.frame = CGRectMake(CGRectGetMaxX(secondItem.frame), 0, 0.5, backView.frame.size.height);
    UIView *border4= [self createBorderView];
    border4.frame = CGRectMake(backView.frame.size.width-0.5, 0, 0.5, backView.frame.size.height);
    UIView *border5 = [self createBorderView];
    border5.frame = CGRectMake(0, CGRectGetMaxY(thirdItem.frame), backView.frame.size.width, 0.5);
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath withContentDict:(NSDictionary *)dict
{
    return [WLChartRatioTableViewCell getCellHeightWithDict:dict andTableView:tableView];
}



- (UIView *)createBorderView
{
    UIView *border = [[UIView alloc]init];
    border.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:border];
    return border;
}

+ (float)getCellHeightWithDict: (NSDictionary *)dict andTableView: (UITableView *)tableView
{
    int viewWidth = tableView.frame.size.width;
    NSInteger firstItemRatio = [dict[@"firstItemWidth"]integerValue];
    NSInteger secondItemRatio = [dict[@"secondItemWidth"]integerValue];
    NSInteger thirdItemRatio = [dict[@"thirdItemWidth"]integerValue];
    NSInteger firstItemWidth = viewWidth * firstItemRatio / (firstItemRatio + secondItemRatio + thirdItemRatio);
    NSInteger secondItemWidth = viewWidth * secondItemRatio / (firstItemRatio + secondItemRatio + thirdItemRatio);
    NSInteger thirdItemWidth = viewWidth * thirdItemRatio / (firstItemRatio + secondItemRatio + thirdItemRatio);
    
    
    CGSize size1 = [dict[@"firstItem"] boundingRectWithSize:CGSizeMake(firstItemWidth, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}context:nil].size;
    CGSize size2 = [dict[@"secondItem"] boundingRectWithSize:CGSizeMake(secondItemWidth, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}context:nil].size;
    CGSize size3 = [dict[@"thirdItem"] boundingRectWithSize:CGSizeMake(thirdItemWidth, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}context:nil].size;
    
    int cellHeight = 40;
    if (size1.height > cellHeight)
    {
        cellHeight = size1.height;
    }
    if (size2.height > cellHeight)
    {
        cellHeight = size2.height;
    }
    if (size3.height > cellHeight)
    {
        cellHeight = size3.height;
    }
    
    return cellHeight;
}

@end
