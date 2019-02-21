//
//  WLLegalPeopleDetailDisplayController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/20.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLLegalPeopleDetailDisplayController.h"
#import "WLTableView.h"
#import "WLLegalPeopleBasicInfoCell.h"
#import "WLLegalPeopleBusinessCell.h"

@interface WLLegalPeopleInfoSourceCell ()

@property (nonatomic, weak) UILabel *source;
@property (nonatomic, weak) WLTableView *detailTable;
@property (nonatomic, assign) NSInteger detailCellHeight;
@property (nonatomic, assign) NSString *type;
@property (nonatomic, assign) BOOL isExpand;

@end
@implementation WLLegalPeopleInfoSourceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *source = [[UILabel alloc]init];
        self.source = source;
        [self addSubview:source];
        
        WLTableView *detailTable = [[WLTableView alloc]init];
        self.detailTable = detailTable;
        detailTable.wltableView.scrollEnabled = NO;
        [self addSubview:detailTable];
        
        [source mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(10);
            make.left.equalTo(self).offset(10);
            make.height.mas_equalTo(20);
        }];
        
        [detailTable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(source.mas_bottom).offset(9);
            make.left.right.equalTo(self);
            make.bottom.equalTo(self.mas_bottom);
        }];
        
    }
    
    return self;
}

-(void)fillCellContent:(NSDictionary *)contentDict withTableView:(UITableView *)tableView
{
    self.source.text = contentDict[@"source"];
    self.detailTable.cellClass = contentDict[@"cellClass"];
    if (contentDict[@"nibName"])
    {
        [self.detailTable registNibForCell:contentDict[@"nibName"] inBundel:[NSBundle mainBundle] orBundleName:@""];
    }
    self.detailTable.rowsData = contentDict[@"dataArr"];
    
    self.type = contentDict[@"type"];
    switch ([contentDict[@"type"]integerValue])
    {
        case 1:
            self.detailCellHeight = 140;
            break;
        case 2:
            self.detailCellHeight = 80;
            break;
            
        default:
            break;
    }
}

-(void)setIsExpand:(BOOL)isExpand
{
    _isExpand = isExpand;
    
    NSMutableDictionary *userInfoDict = [NSMutableDictionary dictionary];
    [userInfoDict setObject:[NSNumber numberWithBool:isExpand] forKey:@"isExpand"];
    [userInfoDict setObject:[NSNumber numberWithInteger:self.detailTable.rowsData.count * self.detailCellHeight] forKey:@"heightChanged"];
    [userInfoDict setObject:self.type forKey:@"type"];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"LegalPeopleInfoDetailCellChanged" object:nil userInfo:userInfoDict];
}

+(CGFloat)tableView:(UITableView *)tableView rowHeightAtIndexPath:(NSIndexPath *)indexPath withContentDict:(NSDictionary *)dict
{
    
    WLLegalPeopleInfoSourceCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.isExpand)
    {
        CGFloat detailCellHeight = 0;
        switch ([dict[@"type"]integerValue])
        {
            case 1:
                detailCellHeight = 140;
                break;
            case 2:
                detailCellHeight = 80;
                break;
                
            default:
                break;
        }

        return cell.detailTable.rowsData.count * detailCellHeight + 40;
    }

    return 40;
}

@end

@interface WLLegalPeopleDetailDisplayController ()<wlTableViewDelegate, UITableViewDelegate>

@property (nonatomic, weak) WLTableView *tableView;

@end

@implementation WLLegalPeopleDetailDisplayController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
}

- (void)decorateUI
{
    WLTableView *tableView = [[WLTableView alloc]init];
    tableView.wltableView.scrollEnabled = NO;
    tableView.delegate = self;

    tableView.cellClass = [WLLegalPeopleInfoSourceCell class];
    tableView.rowsData = [self getSourceDepartmentAndTheirData];
    
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

- (NSArray *)getSourceDepartmentAndTheirData
{
    NSMutableArray *sources = [NSMutableArray array];
    for (WLEnterpriseIndexSet *indexSet in self.block.indexedSets)
    {
        NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
        [dictM setObject:indexSet.indexedSetInfo.departmentname forKey:@"source"];
        [dictM setObject:[NSString stringWithFormat:@"%ld",(long)self.block.xytype]forKey:@"type"];
        NSArray *dataArr;
        switch (self.block.xytype)
        {
            case 1:
                dataArr = [self fillBasicInfoCell];
                [dictM setObject:[WLLegalPeopleBasicInfoCell class] forKey:@"cellClass"];
                [dictM setObject:@"WLLegalPeopleBasicInfoCell" forKey:@"nibName"];
                break;
            case 2:
                dataArr = [self fillBusinessInfoCell];
                [dictM setObject:[WLLegalPeopleBusinessCell class] forKey:@"cellClass"];
                [dictM setObject:@"WLLegalPeopleBusinessCell" forKey:@"nibName"];
                break;
                
            default:
                break;
        }
        if (dataArr != nil)
        {
            [dictM setObject:dataArr forKey:@"dataArr"];
        }
        [sources addObject: dictM];
    }
    
    return sources;
}

- (NSArray *)fillBasicInfoCell
{
    NSMutableArray *dataM = [NSMutableArray array];
    NSArray *indexSets = self.block.indexedSets;
    for (WLEnterpriseIndexSet *indexSet in indexSets)
    {
        for (WLEnterpriseIndexSetData *indexSetData in indexSet.indexedSetData)
        {
            NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
            [dictM setObject:indexSetData.organiseName forKey:@"company"];
            [dictM setObject:indexSetData.organiseCode forKey:@"organiseNo"];
            [dictM setObject:indexSetData.gszch forKey:@"certificateNo"];
            [dictM setObject:indexSetData.organiseAddress forKey:@"address"];
            [dictM setObject:indexSetData.legalPeople forKey:@"legalPeople"];
            [dictM setObject:[indexSetData.firstCertificateDate componentsSeparatedByString:@" "].firstObject forKey:@"firstCertificateDate"];
            [dictM setObject:[indexSetData.validStartDate componentsSeparatedByString:@" "].firstObject forKey:@"validStartDate"];
            [dictM setObject:[indexSetData.validEndDate componentsSeparatedByString:@" "].firstObject forKey:@"validEndDate"];
            [dictM setObject:[indexSetData.latestReviewDate componentsSeparatedByString:@" "].firstObject forKey:@"latestReviewDate"];
            [dataM addObject:dictM];
            
        }
    }
    
    return dataM;
}

- (NSArray *)fillBusinessInfoCell
{
    NSMutableArray *dataM = [NSMutableArray array];
    NSArray *indexSets = self.block.indexedSets;
    for (WLEnterpriseIndexSet *indexSet in indexSets)
    {
        for (WLEnterpriseIndexSetData *indexSetData in indexSet.indexedSetData)
        {
            NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
            [dictM setObject:indexSetData.company forKey:@"company"];
            [dictM setObject:indexSetData.signupNo forKey:@"signupNo"];
            [dictM setObject:indexSetData.ASYear forKey:@"ASYear"];
            [dictM setObject:indexSetData.ASResult forKey:@"ASResult"];
            [dataM addObject:dictM];
        }
    }
    
    return dataM;
}

- (void)wlTableView:(UITableView *)tableView didSelectCellAtIndexPath:(NSIndexPath *)indexPath
{
    WLLegalPeopleInfoSourceCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.isExpand = !cell.isExpand;
    

    [tableView beginUpdates];
    [tableView endUpdates];
    
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
