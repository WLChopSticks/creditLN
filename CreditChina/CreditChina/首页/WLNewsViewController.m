//
//  WLNewsViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/31.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLNewsViewController.h"
#import "WLTableView.h"
#import "WLTitleContentTimeCell.h"
#import <WLPlatform.h>
#import "WLNewsDetailViewController.h"
#import "WLImageTitleContentTimeCell.h"

@interface WLNewsViewController ()<wlTableViewDelegate>

@property (nonatomic, weak) WLTableView *tableView;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSDictionary *responseDict;

@end

@implementation WLNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
}

- (void)decorateUI
{
    self.title = @"新闻资讯";
    WLTableView *tableView = [[WLTableView alloc]init];
    self.tableView = tableView;
    tableView.cellClass = [WLTitleContentTimeCell class];
    [tableView registNibForCell:@"WLTitleContentTimeCell"  inBundel:nil orBundleName:@"WLControls"];
    [tableView registNibForCell:@"WLImageTitleContentTimeCell"  inBundel:nil orBundleName:@"WLControls"];
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [self queryData];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(UITableViewCell *)wltableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WLBaseTableViewCell *cell;
    NSDictionary *dataDict = self.dataArray[indexPath.row];
    NSString *image = dataDict[@"image"];
    if (image.length > 0)
    {
        Class class = [WLImageTitleContentTimeCell class];
        
        NSString *className = [NSString stringWithUTF8String:class_getName(class)];
        
        cell = [tableView dequeueReusableCellWithIdentifier:className forIndexPath:indexPath];
        self.tableView.cellClass = class;
        [cell fillCellContent:self.dataArray[indexPath.row] withTableView:tableView];
    }else
    {
        Class class = [WLTitleContentTimeCell class];
        self.tableView.cellClass = class;
        NSString *className = [NSString stringWithUTF8String:class_getName(class)];
        
        cell = [tableView dequeueReusableCellWithIdentifier:className forIndexPath:indexPath];
        
        [cell fillCellContent:self.dataArray[indexPath.row] withTableView:tableView];
    }


    return cell;
}

-(void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"点击了cell %ld", indexPath.row);
    NSDictionary *content = self.dataArray[indexPath.row];
    WLNewsDetailViewController *vc = [[WLNewsDetailViewController alloc]init];
    vc.hidesBottomBarWhenPushed = YES;
    vc.content = content;
    vc.newsType = @"1";
    vc.contentBaseURL = [self getContentBaseURL:self.responseDict];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)queryData
{
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
        NSString *fileName = @"";
        switch (self.newsSource.integerValue)
        {
            case 1:
            {
                fileName = @"news_nation_20190215";
                break;
            }
            case 2:
            {
                fileName = @"news_province_20190215";
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
        NSLog(@"%@",error);
        
    }];
}

- (NSArray *)constructCellContentDict: (NSDictionary *)model
{
    NSMutableArray *constructingArr = [NSMutableArray array];
    NSArray *news = model[@"news"];
    for (NSDictionary *detailNews in news)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:detailNews[@"title"] forKey:@"title"];
        NSString *content = detailNews[@"content"];
        if (content.length > 0)
        {
            NSArray *paragrphs = [WLCommonTool getHtmlTagContent:content withXpath:@"//p"];
            content = paragrphs.firstObject;
        }
        [constructingDict setObject:content == nil ? @"" : content forKey:@"abstract"];
        [constructingDict setObject:detailNews[@"content"] forKey:@"content"];
        [constructingDict setObject:detailNews[@"date"] forKey:@"time"];
        [constructingDict setObject:detailNews[@"column"]forKey:@"type"];
        NSString *picString = detailNews[@"pictures"];
        if (picString.length > 0)
        {
            picString = [WLCommonTool replaceImageSrcURL:picString withHost:@"http://www.xyln.net"];
        }
        [constructingDict setObject:picString forKey:@"image"];
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
