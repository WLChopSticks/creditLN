//
//  WLRewardsAndPunishListViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/31.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLRewardsAndPunishListViewController.h"
#import "WLTableView.h"
#import "WLFourItemsCell.h"
#import <Masonry.h>
#import "WLRedAndBlackListViewController.h"

@interface WLRewardsAndPunishListViewController ()<wlTableViewDelegate>

@end

@implementation WLRewardsAndPunishListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
}

- (void)decorateUI
{
    self.title = @"联合奖惩名单";
    WLTableView *tableView = [[WLTableView alloc]init];
    tableView.cellClass = [WLFourItemsCell class];
    tableView.rowsData = @[@{@"公司名":@"西安华为技术有限公司",@"接收时间":@"02/01/2008",@"接收内容":@"许可经营项目:信息与通信设备.软件及相关产品研发"},@{@"公司名":@"西安华为技术有限公司",@"接收时间":@"02/01/2008",@"接收内容":@"许可经营项目:信息与通信设备.软件及相关产品研发"},@{@"公司名":@"西安华为技术有限公司",@"接收时间":@"02/01/2008",@"接收内容":@"许可经营项目:信息与通信设备.软件及相关产品研发"},@{@"公司名":@"西安华为技术有限公司",@"接收时间":@"02/01/2008",@"接收内容":@"许可经营项目:信息与通信设备.软件及相关产品研发"},@{@"公司名":@"西安华为技术有限公司",@"接收时间":@"02/01/2008",@"接收内容":@"许可经营项目:信息与通信设备.软件及相关产品研发"},@{@"公司名":@"西安华为技术有限公司",@"接收时间":@"02/01/2008",@"接收内容":@"许可经营项目:信息与通信设备.软件及相关产品研发"},@{@"公司名":@"西安华为技术有限公司",@"接收时间":@"02/01/2008",@"接收内容":@"许可经营项目:信息与通信设备.软件及相关产品研发"},@{@"公司名":@"西安华为技术有限公司",@"接收时间":@"02/01/2008",@"接收内容":@"许可经营项目:信息与通信设备.软件及相关产品研发"},];
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell %ld", indexPath.row);
    WLRedAndBlackListViewController *vc = [[WLRedAndBlackListViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
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
