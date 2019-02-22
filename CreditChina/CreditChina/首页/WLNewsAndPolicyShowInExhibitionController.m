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
#import "WLNewsTabCell.h"
#import <WLPlatform.h>
#import "WLNewsDetailViewController.h"


#define ScreenWidth    [UIScreen mainScreen].bounds.size.width
#define KCellSpace    50
#define KCellWidth    ScreenWidth - 50
#define KCellHeight   200

#define newsTabCell @"newsTabCell"

@interface WLNewsAndPolicyShowInExhibitionController ()<UICollectionViewDelegate, UICollectionViewDataSource, wlTableViewDelegate>

@property (nonatomic, assign) CGFloat offer;
@property (nonatomic, weak) UICollectionView *newsCollection;
@property (nonatomic, weak) WLTableView *messageTable;
@property (nonatomic, strong) NSArray *dataArray;
@property (nonatomic, strong) NSDictionary *responseDict;

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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)decorateNewsPart
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(KCellWidth, KCellHeight);
    layout.minimumLineSpacing = 10;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    UICollectionView *newsCollection = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.newsCollection = newsCollection;
    newsCollection.backgroundColor = [UIColor whiteColor];
    newsCollection.delegate = self;
    newsCollection.dataSource = self;
    newsCollection.pagingEnabled = YES;
    [self.view addSubview:newsCollection];
    
    [newsCollection registerNib:[UINib nibWithNibName:@"WLNewsTabCell" bundle:[WLCommonTool getBundleWithBundleName:@"WLNews"]] forCellWithReuseIdentifier:newsTabCell];
    
    [newsCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self queryNewsData];
    
}

- (void)queryNewsData
{
    [WLApiManager queryDataNewsDataType:self.newsType onlyImageNews:YES success:^(id  _Nullable response) {
        self.responseDict = response;
        self.dataArray = [self constructNewsCellContentDict:response];
        [self.newsCollection reloadData];
    } failure:^(NSError *error) {
        
    }];
}

- (NSArray *)constructNewsCellContentDict: (NSDictionary *)model
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
    
    
//    NSMutableArray *constructingArr = [NSMutableArray array];
//    NSArray *news = model[@"news"];
//    for (NSDictionary *detailNews in news)
//    {
//        NSMutableDictionary * constructingDict = [NSMutableDictionary dictionary];
//        [constructingDict setObject:detailNews[@"pictures"] forKey:@"image"];
//        [constructingDict setObject:detailNews[@"title"] forKey:@"title"];
//        [constructingDict setObject:detailNews[@"date"] forKey:@"time"];
//        [constructingDict setObject:detailNews[@"date"] forKey:@"lookTime"];
//        [constructingDict setObject:[NSNumber numberWithBool:NO] forKey:@"showDetailBtn"];
//        [constructingArr addObject:constructingDict];
//    }
    return constructingArr;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSInteger itemCount = 5;
    if (itemCount > self.dataArray.count)
    {
        itemCount = self.dataArray.count;
    }
    return itemCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WLNewsTabCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:newsTabCell forIndexPath:indexPath];
    
    [cell fillCellContent:self.dataArray[indexPath.item] withCollectionView:collectionView];
    
//    [cell fillCellContent:@{@"image":@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",@"title":@"fdjslajfdlsa",@"time":@"2018",@"lookTime":@"123"} withCollectionView:collectionView];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.dataArray[indexPath.row];
    WLNewsDetailViewController *vc = [[WLNewsDetailViewController alloc]init];
    vc.newsType = @"1";
    vc.content = dict;
    vc.contentBaseURL = [self getContentBaseURL:self.responseDict];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    self.offer = scrollView.contentOffset.x;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    
    if (fabs(scrollView.contentOffset.x -self.offer) > 10)
    {
        if (scrollView.contentOffset.x > self.offer)
        {
            int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - KCellSpace/2)+1;
            NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
            [self.newsCollection scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }else
        {
            int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - KCellSpace/2)+1;
            NSIndexPath * index =  [NSIndexPath indexPathForRow:i-1 inSection:0];
            [self.newsCollection scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    if (fabs(scrollView.contentOffset.x -self.offer) > 20)
    {
        if (scrollView.contentOffset.x > self.offer)
        {
            int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - KCellSpace/2)+1;
            NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
            [self.newsCollection scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }else
        {
            int i = scrollView.contentOffset.x/([UIScreen mainScreen].bounds.size.width - KCellSpace/2)+1;
            i = (i - 1)<0?0:(i - 1);
            NSIndexPath * index =  [NSIndexPath indexPathForRow:i inSection:0];
            [self.newsCollection scrollToItemAtIndexPath:index atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        }
    }
}



- (void)decoratePolicyPart
{
    WLTableView *messageTable = [[WLTableView alloc]init];
    self.messageTable = messageTable;
    messageTable.wltableView.scrollEnabled = NO;
    messageTable.delegate = self;
    [self.view addSubview:messageTable];
    messageTable.cellClass = [WLExhibitionMessageCell class];
    messageTable.wltableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [messageTable registNibForCell:@"WLExhibitionMessageCell" inBundel:[NSBundle mainBundle] orBundleName:@""];
    [messageTable mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self queryPolicyData];
}

- (void)queryPolicyData
{
    [WLApiManager queryDataPolicyDataType:self.policyType success:^(id  _Nullable response) {
        NSDictionary *result = (NSDictionary *)response;
        self.responseDict = result;
        self.dataArray = [self constructCellContentDict:result];
        self.messageTable.rowsData = self.dataArray;
        [self.messageTable reloadData];
    } failure:^(NSError *error) {
        
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
        [constructingDict setObject:detailNews[@"content"] forKey:@"content"];
        [constructingDict setObject:detailNews[@"date"] forKey:@"updateTime"];
        [constructingDict setObject:[NSNumber numberWithBool:NO] forKey:@"showDetailBtn"];
        [constructingArr addObject:constructingDict];
    }
    return constructingArr;
}

-(void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dict = self.dataArray[indexPath.row];
    WLNewsDetailViewController *vc = [[WLNewsDetailViewController alloc]init];
    vc.newsType = @"2";
    vc.content = dict;
    vc.contentBaseURL = [self getContentBaseURL:self.responseDict];
    [self.navigationController pushViewController:vc animated:YES];
    
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
