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


#define ScreenWidth    [UIScreen mainScreen].bounds.size.width
#define KCellSpace    50
#define KCellWidth    ScreenWidth - 50
#define KCellHeight   200

#define newsTabCell @"newsTabCell"

@interface WLNewsAndPolicyShowInExhibitionController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, assign) CGFloat offer;
@property (nonatomic, weak) UICollectionView *newsCollection;

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
    
    [newsCollection registerNib:[UINib nibWithNibName:@"WLNewsTabCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:newsTabCell];
    
    [newsCollection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 50;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WLNewsTabCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:newsTabCell forIndexPath:indexPath];
    
    [cell fillCellContent:@{@"image":@"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",@"title":@"fdjslajfdlsa",@"time":@"2018",@"lookTime":@"123"} withCollectionView:collectionView];
    cell.backgroundColor = [UIColor redColor];
    
    return cell;
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
