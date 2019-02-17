//
//  WLNewsAndPolicyShowInExhibitionController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/17.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLNewsAndPolicyShowInExhibitionController.h"
#import <WLTableView.h>
#import "WLExhibitionMessageCell.h"
#import <WLPlatform.h>

@interface WLNewsAndPolicyShowInExhibitionController ()

@end

@implementation WLNewsAndPolicyShowInExhibitionController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if(self.showType.integerValue == 1)
    {
        [self decorateNewsPart];
    }else if (self.showType.integerValue == 2)
    {
        [self decoratePolicyPart];
    }
}

- (void)decorateNewsPart
{
    
}

- (void)decoratePolicyPart
{
    WLTableView *messageTable = [[WLTableView alloc]init];
    messageTable.wltableView.scrollEnabled = NO;
    [self.view addSubview:messageTable];
    messageTable.cellClass = [WLExhibitionMessageCell class];
    messageTable.wltableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [messageTable registNibForCell:@"WLExhibitionMessageCell" inBundel:[NSBundle mainBundle] orBundleName:@""];
    messageTable.rowsData = @[@{@"content":@"关于对违法失信上市公司相关责任主体实施联合惩罚的合作备忘",@"showDetailBtn":@"0"},@{@"content":@"关于对违法失信上市公司相关责任主体实施联合惩罚的合作备忘",@"showDetailBtn":@"0"},@{@"content":@"关于对违法失信上市公司相关责任主体实施联合惩罚的合作备忘",@"showDetailBtn":@"0"},@{@"content":@"关于对违法失信上市公司相关责任主体实施联合惩罚的合作备忘",@"showDetailBtn":@"0"},@{@"content":@"关于对违法失信上市公司相关责任主体实施联合惩罚的合作备忘",@"showDetailBtn":@"0"},@{@"content":@"关于对违法失信上市公司相关责任主体实施联合惩罚的合作备忘",@"showDetailBtn":@"0"},];
    
    [messageTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
