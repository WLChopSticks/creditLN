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
#import "WLLegalPeopleSearchResultCell.h"

@interface WLQueryCreditInfoViewController ()<wlTableViewDelegate, UITextFieldDelegate>

@property (nonatomic, weak) UIView *bigCategoryBackView;
//0为法人信用查询, 1为重点人群信用查询, 2为个人身份核实
@property (nonatomic, assign) NSInteger searchType;
@property (nonatomic, weak) UISegmentedControl *searchCategory;
@property (nonatomic, weak) UIButton *filterBtn;
@property (nonatomic, strong) UITextField *searchField;
@property (nonatomic, weak) WLTableView *tableView;
@property (nonatomic, weak) WLTableView *searchResulTableView;
@property (nonatomic, strong) NSArray *rowsData;
@property (nonatomic, strong) NSArray *searchResultRowsData;
@property (nonatomic, strong) NSString *searchURL;

//不同种类时, 条件tableview的高度
@property (nonatomic, assign) NSInteger legalPersonFilterHeight;
@property (nonatomic, assign) NSInteger focusPeopleFilterHeight;

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
    [self decorateBigCategoryView];
    [self decorateNavigationBarSearchBar];
    [self decorateFilterView];
    [self decorateTopView];
    [self decorateSearchResultTaleView];
  
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
    NSArray *categoryTitles = @[@"法人信用查询",@"重点人群查询",@"个人身份核实"];
    UISegmentedControl *searchCategory = [[UISegmentedControl alloc]initWithItems:categoryTitles];
    searchCategory.alpha = 0;
    self.searchCategory = searchCategory;
    searchCategory.tintColor = [UIColor redColor];
    searchCategory.frame = CGRectMake(10, 5, self.view.frame.size.width - 50, 30);
    searchCategory.selectedSegmentIndex = 0;
    [searchCategory addTarget:self action:@selector(searchCategorySegmentDidClicking:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:searchCategory];
    
    UIButton *filterBtn = [[UIButton alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.searchCategory.frame) + 5, 5, 30, 30)];
    [filterBtn setImage:[UIImage imageNamed:@"filterBtn"] forState:UIControlStateNormal];
    [filterBtn setImage:[UIImage imageNamed:@"filterBtn"] forState:UIControlStateSelected];
    self.filterBtn = filterBtn;
    filterBtn.alpha = 0;
    [self.view addSubview:filterBtn];
//    filterBtn.backgroundColor = [UIColor redColor];
    [filterBtn addTarget:self action:@selector(filterBtnDidClicking:) forControlEvents:UIControlEventTouchUpInside];
    
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
    int width = self.view.frame.size.width - 50;
    int x = self.view.frame.size.width * 0.5 - width * 0.5;
    int y = 40;
    int height = 0;
    tableView.frame = CGRectMake(x, y, width, height);
}

- (void)decorateSearchResultTaleView
{
    WLTableView *resultTableView = [[WLTableView alloc]init];
    self.searchResulTableView = resultTableView;
    resultTableView.clipsToBounds = YES;
    resultTableView.cellClass = [WLLegalPeopleSearchResultCell class];
    [resultTableView registNibForCell:@"WLLegalPeopleSearchResultCell" inBundel:[NSBundle mainBundle] orBundleName:@""];
    resultTableView.wltableView.separatorStyle = UITableViewCellSelectionStyleNone;
    resultTableView.delegate = self;
    [self.view addSubview:resultTableView];
    [WLCommonTool makeViewShowingWithRoundCorner:resultTableView andRadius:10];
    int width = self.view.frame.size.width - 20;
    int x = 10;
    int y = CGRectGetMaxY(self.searchCategory.frame) + 5;
    int height = self.view.frame.size.height - y;
    resultTableView.frame = CGRectMake(x, y, width, height);
    resultTableView.alpha = 0;
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
    
    NSArray *buttonTitles = @[@"法人信用查询",@"重点人群查询",@"个人身份核实"];
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
        self.filterBtn.alpha = 1;
    }];
    self.navigationItem.titleView = self.searchField;

}

- (void)showConditionTableView
{
    self.filterBtn.selected = !self.filterBtn.selected;
    NSInteger height = 100;
    switch (self.searchType)
    {
        case 0:
        {
            height = self.legalPersonFilterHeight;
            break;
        }
        case 1:
        {
            height = self.focusPeopleFilterHeight;
            break;
        }
        case 2:
        {
            height = 0;
            break;
        }

        default:
            break;
    }
    
    
    int width = self.view.frame.size.width - 50;
    int x = self.view.frame.size.width * 0.5 - width * 0.5;
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(x, 40, width, height);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissConditionTableView
{
    self.filterBtn.selected = !self.filterBtn.selected;
    int width = self.view.frame.size.width - 50;
    int x = self.view.frame.size.width * 0.5 - width * 0.5;
    int y = 40;
    int height = 0;
    [UIView animateWithDuration:0.5 animations:^{
        self.tableView.frame = CGRectMake(self.tableView.frame.origin.x, self.tableView.frame.origin.y, self.tableView.frame.size.width, 0);
    } completion:^(BOOL finished) {
        
    }];
}

- (void)filterBtnDidClicking: (UIButton *)sender
{
    NSLog(@"点击了筛选按钮");
    [self.view bringSubviewToFront:self.tableView];
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        if (self.searchType == 0)
        {
            self.rowsData = @[@{@"condition":@"不限", @"parameter":@"querykey"},
                              @{@"condition":@"企业", @"parameter":@"91"},
                              @{@"condition":@"事业单位", @"parameter":@"12"},
                              @{@"condition":@"民政", @"parameter":@"5"},
                              @{@"condition":@"个体商户", @"parameter":@"92"},];
            self.tableView.rowsData = self.rowsData;
            [self.tableView reloadData];
            self.legalPersonFilterHeight = 44*5;
        }else if (self.searchType == 1)
        {
            if (self.rowsData.count <= 0)
            {
                [self queryFocusPeopleSelect:^(NSDictionary *result, NSError *error) {
                    if (error == nil)
                    {
                        [self showConditionTableView];
                    }
                }];
            }
            
        }
        
        [self showConditionTableView];
    }else
    {
        [self dismissConditionTableView];
    }
}

- (void)searchCategorySegmentDidClicking: (UISegmentedControl *)sender
{
    NSLog(@"点击了搜索种类");
    NSLog(@"%ld",(long)sender.selectedSegmentIndex);
    [self dismissConditionTableView];
    self.searchType = sender.selectedSegmentIndex;
    if (self.searchType == 0)
    {
        [self.searchField becomeFirstResponder];
        self.searchField.placeholder = @"请输入法人";
        self.searchURL = [WLNetworkTool sharedNetworkToolManager].queryAPIList[@"getCompanyList"];
    }else if (self.searchType == 1)
    {
        [self.searchField resignFirstResponder];
        [self queryFocusPeopleSelect:nil];
        self.searchField.placeholder = @"重点人群";
        self.searchURL = [WLNetworkTool sharedNetworkToolManager].queryAPIList[@"getFocusPeople"];
    }else if (self.searchType == 2)
    {
        [self.searchField becomeFirstResponder];
        self.searchField.placeholder = @"请输入姓名";
        self.searchURL = [WLNetworkTool sharedNetworkToolManager].queryAPIList[@"getPersonData"];
    }
    

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
    if (self.searchType == 0)
    {
        self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"querytype" withString:para];
    }else if (self.searchType == 1)
    {
        self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"{typecode}" withString:para];
        if ([self.searchURL containsString:@"need_to_push"])
        {
            self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"need_to_push" withString:@""];
            [self dismissConditionTableView];
            [self querySearchData];
        }
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
            //如果没有选择类别, 弹窗强制选择
            if ([self.searchURL containsString:@"{typecode}"])
            {
                self.searchURL = [self.searchURL stringByAppendingString:@"need_to_push"];
                [self showConditionTableView];
                return;
            }
        }
    }else if (self.searchType == 2)
    {
        NSString *inputStr = [self.searchField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        NSArray *fields = [inputStr componentsSeparatedByCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        
        self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"name" withString:fields.firstObject];
        self.searchURL = [self.searchURL stringByReplacingOccurrencesOfString:@"IDCardNo" withString:fields.lastObject];
    }
    
    [self querySearchData];
}

- (void)querySearchData
{
    WLNetworkTool *networkTool = [WLNetworkTool sharedNetworkToolManager];
    self.searchURL = @"http://223.100.2.221:8383/credit-webservice-app/restwebservice/app/dataquery/getcompanylist/91/辽宁立科/1/1";
    self.searchURL = [self.searchURL stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    [networkTool GET_queryWithURL:self.searchURL andParameters:nil success:^(id  _Nullable responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        if (self.searchType == 0)
        {
            self.searchResultRowsData = [self constructLegalPeopleCellContentDict:result];
        }
//        self.searchResultRowsData = [self constructCellContentDict:result];
        self.searchResulTableView.cellClass = [WLLegalPeopleSearchResultCell class];
        self.searchResulTableView.rowsData = self.searchResultRowsData;
        [self.searchResulTableView reloadData];
        
        self.searchResulTableView.alpha = 1;
        
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];
}

- (NSArray *)constructLegalPeopleCellContentDict: (NSDictionary *)dict
{
    NSArray *legalPeople = dict[@"dataList"];
    NSMutableArray *constructingArr = [NSMutableArray array];
    
    //    for (WLDoublePublicityDetailModel *detailModel in model.dataList)
    for (int i = 0; i < 10; i++)
    {
        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
        [constructingDict setObject:legalPeople[0][@"企业名称"] forKey:@"company"];
        [constructingDict setObject:legalPeople[0][@"营业执照注册号"] forKey:@"signupNo"];
        [constructingDict setObject:legalPeople[0][@"法定代表人"] forKey:@"legalPeople"];
        [constructingDict setObject:legalPeople[0][@"机构地址"] forKey:@"address"];
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
}

- (void)queryFocusPeopleSelect:(void (^)(NSDictionary *, NSError *))response
{
    WLNetworkTool *networkTool = [WLNetworkTool sharedNetworkToolManager];
    NSMutableString *URL = [NSMutableString stringWithString:networkTool.queryAPIList[@"getpersonselect"]];
    NSString *urlString = [NSString stringWithString:URL];
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    
    [networkTool GET_queryWithURL:urlString andParameters:nil success:^(id  _Nullable responseObject) {
        NSDictionary *result = (NSDictionary *)responseObject;
        self.rowsData = [self constructCellContentDict:result];
        self.tableView.rowsData = self.rowsData;
        [self.tableView reloadData];
        self.focusPeopleFilterHeight = self.tableView.rowsData.count * 44;
        if (response != nil)
        {
            response(result, nil);
        }
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
        if (response != nil)
        {
            response(nil, error);
        }
        
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
