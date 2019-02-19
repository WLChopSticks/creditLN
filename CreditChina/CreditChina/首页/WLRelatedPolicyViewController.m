//
//  WLRelatedPolicyViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/31.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLRelatedPolicyViewController.h"
#import "WLPlatform.h"
#import "WLTableView.h"
#import "WLDoublePublicityCell.h"
#import "WLNewsDetailViewController.h"

@interface WLRelatedPolicyViewController ()<wlTableViewDelegate>

@property (nonatomic, weak) WLTableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSDictionary *responseDict;

@end

@implementation WLRelatedPolicyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
}

- (void)decorateUI
{
    self.title = @"政策法规";
    WLTableView *tableView = [[WLTableView alloc]init];
    self.tableView = tableView;
    tableView.cellClass = [WLDoublePublicityCell class];
    [tableView registNibForCell:@"WLDoublePublicityCell"  inBundel:nil orBundleName:@"WLControls"];
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self queryData];
}

- (void)queryData
{
    [ProgressHUD show];
    WLNetworkTool *networkTool = [WLNetworkTool sharedNetworkToolManager];
    NSMutableString *URL = [NSMutableString stringWithString:networkTool.queryAPIList[@"getdatareportings"]];
    
    NSString *counterpart = @"xzxdrmc";
    NSString *page = @"1";
    NSString *pageSize = @"10";
    [URL appendString:[NSString stringWithFormat:@"/%@",@"1"]];
    [URL appendString:[NSString stringWithFormat:@"/%@",counterpart]];
    [URL appendString:[NSString stringWithFormat:@"/%@",page]];
    [URL appendString:[NSString stringWithFormat:@"/%@",pageSize]];
    NSString *urlString = [NSString stringWithString:URL];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    
    [networkTool GET_queryWithURL:urlString andParameters:nil success:^(id  _Nullable responseObject) {
//        NSDictionary *result = (NSDictionary *)responseObject;
        //        WLDoublePublicityModel *model = [[WLDoublePublicityModel alloc]init];
        //        model = [model getModel:result];
        [ProgressHUD dismiss];
        NSString *fileName = @"";
        switch (self.policyType.integerValue)
        {
            case 1:
            {
                fileName = @"law_nation_20190215";
                break;
            }
            case 2:
            {
                fileName = @"law_province_20190215";
                break;
            }
            case 3:
            {
                fileName = @"law_city_20190215";
                break;
            }
  
            default:
                break;
        }
        NSDictionary *result = [WLCommonTool getLocalJsonFileWithName:fileName];
        self.responseDict = result;
        self.dataArray = [self constructCellContentDict:result];
        self.tableView.rowsData = self.dataArray;
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [ProgressHUD dismiss];
        NSLog(@"%@",error);
        
    }];
}

-(void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell %ld", indexPath.row);
    NSDictionary *content = self.dataArray[indexPath.row];
    WLNewsDetailViewController *vc = [[WLNewsDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.content = content;
    vc.newsType = @"2";
    vc.contentBaseURL = [self getContentBaseURL:self.responseDict];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)constructCellContentDict: (NSDictionary *)model
{
    NSMutableArray *constructingArr = [NSMutableArray array];
    NSArray *news = model[@"news"];
    for (NSDictionary *detailNews in news)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:detailNews[@"title"] forKey:@"publicityType"];
        [constructingDict setObject:detailNews[@"column"] forKey:@"symbolString"];
        [constructingDict setObject:detailNews[@"date"] forKey:@"updateTime"];
        
        [constructingDict setObject:detailNews[@"content"] forKey:@"content"];
        
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
}

- (NSString *)getContentBaseURL: (NSDictionary *)model
{
    NSDictionary *baseDict = model[@"base"];
    NSString *baseURL = baseDict[@"address"];
    return baseURL;
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
