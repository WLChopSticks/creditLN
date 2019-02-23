//
//  WLProfileCreditGradeBenifitCell.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/23.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLProfileCreditGradeBenifitCell.h"
#import <Masonry.h>

@interface WLProfileCreditGradeBenifitCell()

@property (nonatomic, weak) UIImageView *image;
@property (nonatomic, weak) UILabel *title;

@end

@implementation WLProfileCreditGradeBenifitCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self decorateUI];
    }
    return self;
}

- (void)decorateUI
{
    UIImageView *image = [[UIImageView alloc]init];
    self.image = image;
    image.backgroundColor = [UIColor grayColor];
    [self addSubview:image];
    
    UILabel *title = [[UILabel alloc]init];
    self.title = title;
    [self addSubview:title];
    
    [image mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(10);
        make.left.equalTo(self).offset(10);
        make.width.height.mas_equalTo(50);
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(image);
        make.left.equalTo(image).offset(20);
    }];
}

-(void)fillCellContent:(NSDictionary *)contentDict withTableView:(UITableView *)tableView
{
    self.image.image = [UIImage imageNamed:@""];
    self.title.text = contentDict[@"title"];
    NSArray *contents = contentDict[@"contents"];
    int index = 0;
    for (NSString *content in contents)
    {
        UILabel *contentLabel = [[UILabel alloc]init];
        contentLabel.textColor = [UIColor lightGrayColor];
        contentLabel.font = [UIFont systemFontOfSize:13];
        
        [self addSubview:contentLabel];
        contentLabel.text = content;

        CGFloat x = 30;
        CGFloat y = index * 20 + 35;
        CGFloat width = tableView.frame.size.width - 30;
        CGFloat height = 20;
        contentLabel.frame = CGRectMake(x, y, width, height);
        index++;
    }
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath withContentDict:(NSDictionary *)dict
{
    NSArray *contents = dict[@"contents"];
    return contents.count * 20 + 40;
}


@end
