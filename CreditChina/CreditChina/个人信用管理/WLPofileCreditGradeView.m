//
//  WLPofileCreditGradeView.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/23.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLPofileCreditGradeView.h"
#import <Masonry.h>

@implementation WLPofileCreditGradeView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self decorateUI];
    }
    return self;
}

- (void)decorateUI
{
    
    UILabel *gradeLabel = [[UILabel alloc]init];
    self.gradeLabel = gradeLabel;
    gradeLabel.textColor = [UIColor redColor];
    gradeLabel.textAlignment = NSTextAlignmentCenter;
    gradeLabel.font = [UIFont systemFontOfSize:20];
    [self addSubview:gradeLabel];
    UILabel *regionLabel = [[UILabel alloc]init];
    self.regionLabel = regionLabel;
    regionLabel.textAlignment = NSTextAlignmentCenter;
    regionLabel.textColor = [UIColor grayColor];
    regionLabel.font = [UIFont systemFontOfSize:12];
    [self addSubview:regionLabel];
    
    [regionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.mas_bottom).offset(-10);
        make.left.right.equalTo(self);
        make.height.mas_equalTo(20);
    }];
    
    [gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.bottom.equalTo(regionLabel.mas_top);
        make.left.right.equalTo(self);
    }];
    
}

@end
