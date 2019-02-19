//
//  WLDoublePublicityViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/30.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLDoublePublicityViewController.h"
#import <WLPlatform.h>
#import "WLTableView.h"
#import "WLDoublePublicitysTableViewCell.h"
#import "WLDoublePublicityModel.h"
#import "WLDoublePolicyDetailViewController.h"

@interface WLDoublePublicityViewController ()<wlTableViewDelegate>

@property (nonatomic, weak) WLTableView *tableView;

@end

@implementation WLDoublePublicityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)decorateUI
{
    WLTableView *tableView = [[WLTableView alloc]init];
    self.tableView = tableView;
    tableView.wltableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.cellClass = [WLDoublePublicitysTableViewCell class];
    [tableView registNibForCell:@"WLDoublePublicitysTableViewCell"  inBundel:[NSBundle mainBundle] orBundleName:@"WLControls"];
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
       make.edges.equalTo(self.view);
    }];
    
    [self queryData];
}

- (void)queryData
{
//    WLNetworkTool *networkTool = [WLNetworkTool sharedNetworkToolManager];
//    NSMutableString *URL = [NSMutableString stringWithString:networkTool.queryAPIList[@"getdatareportings"]];
//
//    NSString *counterpart = @"xzxdrmc";
//    NSString *page = @"1";
//    NSString *pageSize = @"10";
//    [URL appendString:[NSString stringWithFormat:@"/%@",self.doublePubliciryType]];
//    [URL appendString:[NSString stringWithFormat:@"/%@",counterpart]];
//    [URL appendString:[NSString stringWithFormat:@"/%@",page]];
//    [URL appendString:[NSString stringWithFormat:@"/%@",pageSize]];
//    NSString *urlString = [NSString stringWithString:URL];
//    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
//
//
//    [networkTool GET_queryWithURL:urlString andParameters:nil success:^(id  _Nullable responseObject) {
//        NSDictionary *result = (NSDictionary *)responseObject;
//        WLDoublePublicityModel *model = [[WLDoublePublicityModel alloc]init];
//        model = [model getModel:result];
//        if ([self.doublePubliciryType isEqualToString:@"1"])
//        {
//            self.tableView.rowsData = [self constructPunishCellContentDict:model];
//        }else if ([self.doublePubliciryType isEqualToString:@"2"])
//        {
//            self.tableView.rowsData = [self constructPermissionCellContentDict:model];
//        }
//        [self.tableView reloadData];
//    } failure:^(NSError *error) {
//        NSLog(@"%@",error);
//
//    }];
    [ProgressHUD show];
    [WLApiManager queryDoublePublicityDataType:self.doublePubliciryType andName:nil page:1 success:^(id  _Nullable response) {
        [ProgressHUD dismiss];
        NSDictionary *result = (NSDictionary *)response;
        WLDoublePublicityModel *model = [[WLDoublePublicityModel alloc]init];
        model = [model getModel:result];
        if ([self.doublePubliciryType isEqualToString:@"1"])
        {
            self.tableView.rowsData = [self constructPunishCellContentDict:result];
        }else if ([self.doublePubliciryType isEqualToString:@"2"])
        {
            self.tableView.rowsData = [self constructPermissionCellContentDict:result];
        }
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [ProgressHUD dismiss];
    }];
}

- (NSArray *)constructPunishCellContentDict: (NSDictionary *)result
{
    NSMutableArray *constructingArr = [NSMutableArray array];
    NSArray *items = result[@"dataList"];
    
    for (NSDictionary *model in items)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        
        [constructingDict setObject:model[@"xzxdrmc"] forKey:@"company"];
        [constructingDict setObject:model[@"wfxwlx"] forKey:@"content"];
        NSTimeInterval time = [model[@"updatetime"]integerValue];
        [constructingDict setObject:[WLCommonTool transferTimeFormatWIthTime:time]  forKey:@"time"];
        [constructingDict setObject:model[@"xzcfjdswh"] forKey:@"shuwenhao"];
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
    
    return constructingArr;
}

- (NSArray *)constructPermissionCellContentDict: (NSDictionary *)result
{
    NSMutableArray *constructingArr = [NSMutableArray array];
    NSArray *items = result[@"dataList"];

    for (NSDictionary *model in items)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        
        [constructingDict setObject:model[@"xzxdrmc"] forKey:@"company"];
        [constructingDict setObject:model[@"xzxkjdsmc"] forKey:@"content"];
        NSTimeInterval time = [model[@"updatetime"]integerValue];
        [constructingDict setObject:[WLCommonTool transferTimeFormatWIthTime:time]  forKey:@"time"];
        [constructingDict setObject:model[@"xzxkjdswh"] forKey:@"shuwenhao"];
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
}

-(void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell %ld", indexPath.row);
    WLDoublePolicyDetailViewController *vc = [[WLDoublePolicyDetailViewController alloc]init];
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
