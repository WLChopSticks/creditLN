//
//  WLRedAndBlackListViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/2.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLRedAndBlackListViewController.h"
#import <Masonry.h>
#import "WLTableView.h"
#import "WLTFourItemsWithTitleCell.h"

@interface WLRedAndBlackListViewController ()<wlTableViewDelegate>

@end

@implementation WLRedAndBlackListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
}

- (void)decorateUI
{
    self.title = @"守信红名单";
    WLTableView *tableView = [[WLTableView alloc]init];
    tableView.cellClass = [WLTFourItemsWithTitleCell class];
    tableView.rowsData = @[@{@"title":@"A级纳税人",@"数据来源":@"税务局",@"纳税人名称":@"西安华为有限公司",@"评价年度":@"2019",@"更新日期":@"2019/01/01"},@{@"title":@"A级纳税人",@"数据来源":@"税务局",@"纳税人名称":@"西安华为有限公司",@"评价年度":@"2019",@"更新日期":@"2019/01/01"},@{@"title":@"A级纳税人",@"数据来源":@"税务局",@"纳税人名称":@"西安华为有限公司",@"评价年度":@"2019",@"更新日期":@"2019/01/01"},@{@"title":@"A级纳税人",@"数据来源":@"税务局",@"纳税人名称":@"西安华为有限公司",@"评价年度":@"2019",@"更新日期":@"2019/01/01"},@{@"title":@"A级纳税人",@"数据来源":@"税务局",@"纳税人名称":@"西安华为有限公司",@"评价年度":@"2019",@"更新日期":@"2019/01/01"},@{@"title":@"A级纳税人",@"数据来源":@"税务局",@"纳税人名称":@"西安华为有限公司",@"评价年度":@"2019",@"更新日期":@"2019/01/01"},@{@"title":@"A级纳税人",@"数据来源":@"税务局",@"纳税人名称":@"西安华为有限公司",@"评价年度":@"2019",@"更新日期":@"2019/01/01"},@{@"title":@"A级纳税人",@"数据来源":@"税务局",@"纳税人名称":@"西安华为有限公司",@"评价年度":@"2019",@"更新日期":@"2019/01/01"},];
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell %ld", indexPath.row);
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
