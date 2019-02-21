//
//  WLLegalPeopleDetailController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/20.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLLegalPeopleDetailController.h"
#import <WLPlatform.h>
#import "WLLegalDetailModel.h"
#import <WLSegmentTableViewController.h>
#import "WLLegalPeopleDetailDisplayController.h"

@interface WLLegalPeopleDetailController ()<HGSegmentedPageViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *company;
@property (weak, nonatomic) IBOutlet UILabel *uniqueCreditNo;
@property (weak, nonatomic) IBOutlet UILabel *address;
@property (weak, nonatomic) IBOutlet UILabel *creditNo;
@property (weak, nonatomic) IBOutlet UILabel *business;
@property (weak, nonatomic) IBOutlet UILabel *legalPeople;
@property (weak, nonatomic) IBOutlet UILabel *money;
@property (weak, nonatomic) IBOutlet UILabel *createTime;

@property (nonatomic, strong) WLLegalDetailModel *model;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (nonatomic, weak) WLSegmentTableViewController *categoryTable;
@property (nonatomic, weak) UIView *scrollBackView;

@end

@implementation WLLegalPeopleDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self decorateUI];
    [self queryData];
}

- (void)decorateUI
{
    [self.topView removeFromSuperview];
    UIScrollView *backScroll = [[UIScrollView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:backScroll];
    
    UIView *bgView = [[UIView alloc]init];
    self.scrollBackView = bgView;
//    bgView.backgroundColor = [UIColor colorWithRed:236.0/250 green:236.0/250 blue:236.0/250 alpha:1];
    [backScroll addSubview:bgView];
    
    [backScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(backScroll);
//        make.top.equalTo(backScroll.mas_top).offset(-20);
//        make.left.equalTo(backScroll.mas_left);
//        make.right.equalTo(backScroll.mas_right);
//        make.bottom.equalTo(backScroll.mas_bottom);
        make.width.equalTo(backScroll);
    }];
    
    [bgView addSubview:self.topView];
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(bgView);
        make.height.mas_equalTo(200);
    }];
}

- (void)queryData
{
    [ProgressHUD show];
    [WLApiManager queryCompanyDetailUserCode:self.usercode andCreditNumber:self.creditcode success:^(id  _Nullable response) {
        [ProgressHUD dismiss];
        NSDictionary *result = (NSDictionary *)response;
        WLLegalDetailModel *model = [WLLegalDetailModel getEnterproseDetailModel:result];
        if (model.enterpriseInfo != nil)
        {
            self.model = model;
            [self fillTopViewContent];
            [self fillCategoryTableContent];
        }else
        {
            [self showEmptyView];
        }
        
    } failure:^(NSError *error) {
        [ProgressHUD dismiss];
        [self showEmptyView];
    }];
}

- (void)fillTopViewContent
{
    WLEnterpriseInfo *enterpriseInfo = self.model.enterpriseInfo;
    self.company.text = enterpriseInfo.company;
    self.creditNo.text = enterpriseInfo.creditNo;
    self.uniqueCreditNo.text = enterpriseInfo.uniqueCreditNo;
    self.legalPeople.text = enterpriseInfo.legalPeople;
    self.money.text = enterpriseInfo.money;
    self.address.text = enterpriseInfo.address;
    self.business.text = enterpriseInfo.business;
    NSString *foundDate = enterpriseInfo.foundDate;
    self.createTime.text = [[foundDate componentsSeparatedByString:@" "]firstObject];
}

- (void)fillCategoryTableContent
{
    WLSegmentTableViewController *categoryTable = [[WLSegmentTableViewController alloc]init];
    self.categoryTable = categoryTable;
    categoryTable.categoryWidth = Screen_Width;
    categoryTable.isTitlesEqualWidth = NO;

    //基本信息
    WLEnterpriseXzDetail *enterpriseDetail = self.model.enterpriseXzDetail;
    
    NSMutableArray *titles = [NSMutableArray array];
    for (WLEnterpriseDetailBlock *block in enterpriseDetail.enterpriseXzDetail)
    {
        if (block.typedepartmentname.length > 0)
        {
            [titles addObject:block.typedepartmentname];
        }
    }
    self.categoryTable.titles = titles;
    
    NSMutableArray *vcs = [NSMutableArray array];
    for (int i = 0; i < titles.count; i++)
    {
        WLLegalPeopleDetailDisplayController *vc = [[WLLegalPeopleDetailDisplayController alloc]init];
        WLEnterpriseDetailBlock *block = enterpriseDetail.enterpriseXzDetail[i];
        vc.block = block;
        [vcs addObject:vc];
    }
    self.categoryTable.controllers = vcs;
    
    [self.scrollBackView addSubview:categoryTable.view];
    [self addChildViewController:categoryTable];
    categoryTable.segmentedPageViewController.delegate = self;
    
    WLEnterpriseDetailBlock *firstBlock = enterpriseDetail.enterpriseXzDetail.firstObject;
    CGFloat vcHeight = [self getVCHeightWithBlock:firstBlock];
    [categoryTable.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView.mas_bottom);
        make.height.mas_equalTo(vcHeight);
        make.left.right.bottom.equalTo(self.scrollBackView);
        
    }];
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(updateCategoryTableHeight:) name:@"LegalPeopleInfoDetailCellChanged" object:nil];
}

-(void)segmentedPageViewControllerDidEndDeceleratingWithPageIndex:(NSInteger)index
{
    WLLegalPeopleDetailDisplayController *currentVC =(WLLegalPeopleDetailDisplayController *) self.categoryTable.segmentedPageViewController.currentPageViewController;
    CGFloat vcHeight = 0;
    if (currentVC.lastHeight > 0)
    {
        vcHeight = currentVC.lastHeight;
    }else
    {
        vcHeight = [self getVCHeightWithBlock:currentVC.block];
    }

    // 修改下边距约束
    [self.categoryTable.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(vcHeight);
    }];

    // 更新约束
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];

}

- (void)updateCategoryTableHeight: (NSNotification *)notice
{
    //LegalPeopleInfoDetailCellChanged
    NSDictionary *userInfo = notice.userInfo;
    CGFloat cellHeight = [userInfo[@"heightChanged"] floatValue];
    WLLegalPeopleDetailDisplayController *currentVC =(WLLegalPeopleDetailDisplayController *) self.categoryTable.segmentedPageViewController.currentPageViewController;
    
    CGFloat categoryHeight;
    if (currentVC.actualHeight < currentVC.lastHeight)
    {
        categoryHeight = currentVC.actualHeight;
    }else
    {
        categoryHeight = currentVC.lastHeight;
    }
    
    if ([userInfo[@"isExpand"]boolValue])
    {
        categoryHeight += cellHeight;
    }else
    {
        categoryHeight -= cellHeight;
    }
    
    currentVC.actualHeight = categoryHeight;
    
    if (categoryHeight < Screen_Height - 200)
    {
        
        categoryHeight = Screen_Height - 200;
    }
    
    currentVC.lastHeight = categoryHeight;
    
    categoryHeight += 40;//categoryview height
    
    // 修改下边距约束
    [self.categoryTable.view mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(categoryHeight);
    }];
    
    // 更新约束
    [UIView animateWithDuration:0.25 animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (CGFloat)getVCHeightWithBlock: (WLEnterpriseDetailBlock *)block
{
    NSInteger type = block.xytype;
    NSInteger cellCount = 0;
    NSInteger cellHeight = 0;
    cellHeight = block.indexedSets.count * 40;
    WLLegalPeopleDetailDisplayController *currentVC =(WLLegalPeopleDetailDisplayController *) self.categoryTable.segmentedPageViewController.currentPageViewController;
    currentVC.actualHeight = cellHeight;
//    for (WLEnterpriseIndexSet *indexSet in block.indexedSets)
//    {
//        cellCount += indexSet.indexedSetDataCount;
//    }
//    switch (type)
//    {
//        case 1:
//            cellHeight = cellCount * 140;
//            break;
//        case 2:
//            cellHeight = cellCount * 80;
//            break;
//
//        default:
//            break;
//    }
    if (cellHeight < Screen_Height - 200)
    {
        cellHeight = Screen_Height - 200;
    }
    currentVC.lastHeight = cellHeight;
    
    return cellHeight + 40;
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
