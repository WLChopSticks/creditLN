//
//  WLNewsTabCell.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/17.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLNewsTabCell.h"
#import <UIImageView+WebCache.h>

@implementation WLNewsTabCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)fillCellContent:(NSDictionary *)contentDict withCollectionView:(UICollectionView *)collectionView
{
    [self.image sd_setImageWithURL:[NSURL URLWithString:contentDict[@"image"]]];
    self.title.text = contentDict[@"title"];
    [self.time setTitle:contentDict[@"time"] forState:UIControlStateNormal];
    [self.lookTime setTitle:contentDict[@"lookTime"] forState:UIControlStateNormal];
}

- (IBAction)remarkBtnDidClicking:(UIButton *)sender
{
    NSLog(@"评论按钮点击了");
}

@end
