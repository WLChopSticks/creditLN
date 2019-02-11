//
//  WLQueryCreditInfoViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/31.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLQueryCreditInfoViewController.h"
#import "WLPlatform.h"
#import "WLSearchConditionCell.h"
#import "WLTableView.h"

@interface WLQueryCreditInfoViewController ()<wlTableViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) UIView *bigCategoryBackView;
//0为法人信用查询, 1为重点人群信用查询, 2为个人身份核实
@property (nonatomic, assign) NSInteger searchType;
@property (nonatomic, weak) UISegmentedControl *searchCategory;
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, weak) WLTableView *tableView;
@property (nonatomic, strong) NSArray *rowsData;
@property (nonatomic, strong) NSString *searchURL;

@end

@implementation WLQueryCreditInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
}

- (void)decorateUI
{
    self.title = @"信用信息查询";
    [self decorateNavigationBarSearchBar];
    [self decorateTopView];
    [self decorateBigCategoryView];
    [self decorateFilterView];
    
}

- (void)decorateNavigationBarSearchBar
{
    UITextField *searchField = [[UITextField alloc]initWithFrame:CGRectMake(0, 0, 300, 30)];
    self.searchField = searchField;
    searchField.delegate = self;
    searchField.borderStyle = UITextBorderStyleRoundedRect;
    NSString *holderText = @"请输入企业法人/法人名称";
    NSMutableAttributedString *placeholder = [[NSMutableAttributedString alloc] initWithString:holderText];
    [placeholder addAttribute:NSFontAttributeName
                        value:[UIFont boldSystemFontOfSize:14]
                        range:NSMakeRange(0, holderText.length)];
    searchField.attributedPlaceholder = placeholder;
    UIView *leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 30, 20)];
    UIImageView *searchLeftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 0, 20, 20)];
    searchLeftImageView.image = [UIImage imageNamed:@"search"];
    [leftView addSubview:searchLeftImageView];
    searchField.leftViewMode = UITextFieldViewModeAlways;
    
    searchField.leftView = leftView;
//    self.navigationItem.titleView = searchField;
}

- (void)decorateTopView
{
    int width = self.view.frame.size.width - 30;
    int height = 30;
    int x = self.view.frame.size.width * 0.5 - width * 0.5;
    int y = 5;
    NSArray *categoryTitles = @[@"法人信用查询",@"重点人群信用查询",@"个人身份核实"];
    UISegmentedControl *searchCategory = [[UISegmentedControl alloc]initWithItems:categoryTitles];
    searchCategory.alpha = 0;
    self.searchCategory = searchCategory;
    searchCategory.tintColor = [UIColor redColor];
    searchCategory.frame = CGRectMake(x, y, width, height);
    searchCategory.selectedSegmentIndex = 0;
    [searchCategory addTarget:self action:@selector(searchCategorySegmentDidClicking:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:searchCategory];
    
}

- (void)decorateBigCategoryView
{
    UIView *bigCategoryBackView = [[UIView alloc]init];
    self.bigCategoryBackView = bigCategoryBackView;
    [self.view addSubview:bigCategoryBackView];
    int width = self.view.frame.size.width - 50;
    int height = 300;
    int x = self.view.frame.size.width * 0.5 - width * 0.5;
    int y = self.view.frame.size.height * 0.5 - height * 0.6;
    bigCategoryBackView.frame = CGRectMake(x, y, width, height);
    
    NSArray *buttonTitles = @[@"法人信用查询",@"重点人群信用查询",@"个人身份核实"];
    for (int i = 0; i < 3; i++)
    {
        UIButton *button = [[UIButton alloc]init];
        button.tag = i;
        [WLCommonTool makeViewShowingWithRoundCorner:button andRadius:10];
        [button setTitle:buttonTitles[i] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:@"red_background"] forState:UIControlStateNormal];
        [bigCategoryBackView addSubview:button];
        [button addTarget:self action:@selector(bigSearchCategoryDidClicking:) forControlEvents:UIControlEventTouchUpInside];
        
        int width = bigCategoryBackView.frame.size.width;
        int height = 50;
        int x = 0;
        int y = 0 + i * (height + 20);
        button.frame = CGRectMake(x, y, width, height);
        
    }
    
}

- (void)bigSearchCategoryDidClicking: (UIButton *)sender
{
    NSLog(@"选择了大搜索种类");
    self.searchType = sender.tag;
    self.searchCategory.selectedSegmentIndex = sender.tag;
    [self searchCategorySegmentDidClicking:self.searchCategory];
    [UIView animateWithDuration:0.5 animations:^{
        self.bigCategoryBackView.alpha = 0;
        self.searchCategory.alpha = 1;
    }];
    self.navigationItem.titleView = self.searchField;

}

- (void)showConditionTableViewHeight: (NSInteger)height
{
    if (height <= 0)
    {
        height = 100;
    }
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissConditionTableView
{
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 0);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)searchCategorySegmentDidClicking: (UISegmentedControl *)sender
{
    NSLog(@"点击了搜索种类");
    NSLog(@"%ld",(long)sender.selectedSegmentIndex);
    [self dismissConditionTableView];
    self.searchType = sender.selectedSegmentIndex;
    if (self.searchType == 0)
    {
        self.rowsData = @[@{@"condition":@"不限", @"parameter":@"querykey"},
                          @{@"condition":@"企业", @"parameter":@"91"},
                          @{@"condition":@"事业单位", @"parameter":@"12"},
                          @{@"condition":@"民政", @"parameter":@"5"},
                          @{@"condition":@"个体商户", @"parameter":@"92"},];
        self.tableView.rowsData = self.rowsData;
        
        [self.tableView reloadData];
        [self showConditionTableViewHeight:44*5];
    }else if (self.searchType == 1)
    {
        WLNetworkTool *networkTool = [WLNetworkTool sharedNetworkToolManager];
        NSMutableString *URL = [NSMutableString stringWithString:networkTool.queryAPIList[@"getpersonselet"]];
        NSString *urlString = [NSString stringWithString:URL];
        urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        
        [networkTool GET_queryWithURL:urlString andParameters:nil success:^(id  _Nullable responseObject) {
            NSDictionary *result = (NSDictionary *)responseObject;
            self.rowsData = [self constructCellContentDict:result];
            self.tableView.rowsData = self.rowsData;
            [self.tableView reloadData];
            [self showConditionTableViewHeight:self.tableView.rowsData.count * 44];
            
        } failure:^(NSError *error) {
            NSLog(@"%@",error);
            
        }];
    }else if (self.searchType == 2)
    {
        [self.searchField becomeFirstResponder];
    }
}

- (void)decorateFilterView
{
    WLTableView *tableView = [[WLTableView alloc]init];
    self.tableView = tableView;
    tableView.clipsToBounds = YES;
    tableView.cellClass = [WLSearchConditionCell class];
    tableView.wltableView.separatorStyle = UITableViewCellSelectionStyleNone;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [WLCommonTool makeViewShowingWithRoundCorner:tableView andRadius:10];
    int x = self.searchCategory.frame.origin.x;
    int y = CGRectGetMaxY(self.searchCategory.frame);
    int width = self.searchCategory.frame.size.width;
    int height = 0;
    tableView.frame = CGRectMake(x, y, width, height);
}

- (NSArray *)constructCellContentDict: (NSDictionary *)dict
{
    NSArray *peoplename = dict[@"personlist"];
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    //    for (WLDoublePublicityDetailModel *detailModel in model.dataList)
    for (int i = 0; i < peoplename.count; i++)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:peoplename[i][@"peoplename"] forKey:@"condition"];
        [constructingDict setObject:peoplename[i][@"datapeoplequerycode"] forKey:@"parameter"];
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
}

-(void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    [self dismissConditionTableView];
    
    NSString *para = self.rowsData[indexPath.row][@"parameter"];
    WLNetworkTool *networkTool = [WLNetworkTool sharedNetworkToolManager];
    if (self.searchType == 0)
    {
        NSString *urlString = networkTool.queryAPIList[@"getCompanyList"];
        urlString = [urlString stringByReplacingOccurrencesOfString:@"{querytype}" withString:para];
        self.searchURL = urlString;
    }else if (self.searchType == 1)
    {
        NSString *urlString = networkTool.queryAPIList[@"getFocusPeople"];
        urlString = [urlString stringByReplacingOccurrencesOfString:@"{typecode}" withString:para];
        self.searchURL = urlString;
    }
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField endEditing:YES];
    return YES;
}

-(void)textFieldDidEndEditing:(UITextField *)textField 
{
    NSLog(@"开始搜索");
    if (self.searchType == 0)
    {
        self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"{querykey}" withString:textField.text];
    }else if (self.searchType == 1)
    {
        self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"{querykey}" withString:textField.text];
        
        NSString *searchString = textField.text;
        if (searchString.length > 0)
        {
            if ([searchString integerValue])
            {
                self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"zczsbh" withString:searchString];
            }else
            {
                self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"zgrxm" withString:searchString];
            }
        }
    }else if (self.searchType == 2)
    {
        
    }
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
