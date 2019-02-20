//
//  WLLegalDetailModel.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/20.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLLegalDetailModel.h"
#import "MJExtension.h"

@interface WLEnterpriseInfo ()
@end
@implementation WLEnterpriseInfo
@end
@interface WLEnterpriseIndexSetInfo()
@end
@implementation WLEnterpriseIndexSetInfo
@end
@interface WLEnterpriseIndexSetData()
@end
@implementation WLEnterpriseIndexSetData
+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"note":@"无备注",
             @"organiseName":@"组织机构名称",
             @"organiseCode":@"组织机构代码",
             @"organiseAddress":@"组织机构地址",
             @"legalPeople":@"法定代表人",
             @"gszch":@"工商注册号",
             @"firstCertificateDate":@"初始办证日期",
             @"validStartDate":@"有效起始日期",
             @"validEndDate":@"有效作废日期",
             @"latestReviewDate":@"最新复审日期",
             };
}
@end
@interface WLEnterpriseIndexSet()
@end
@implementation WLEnterpriseIndexSet
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"indexedSetData":@"WLEnterpriseIndexSetData"};
}
@end
@interface WLEnterpriseDetailBlock()
@end
@implementation WLEnterpriseDetailBlock
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"indexedSets":@"WLEnterpriseIndexSet"};
}
@end
@interface WLEnterpriseXzDetail()
@end
@implementation WLEnterpriseXzDetail
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"enterpriseXzDetail":@"WLEnterpriseDetailBlock"};
}
@end

@implementation WLLegalDetailModel

+ (instancetype)getEnterproseDetailModel:(NSDictionary *)dict
{
    WLLegalDetailModel *model = [[WLLegalDetailModel alloc]init];
    NSDictionary *enterproseInfoDict = [dict objectForKey:@"enterpriseInfo"];
    if (enterproseInfoDict)
    {
        [WLEnterpriseInfo mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{
                     @"company":@"企业名称",
                     @"creditNo":@"信用标识码",
                     @"uniqueCreditNo":@"统一社会信用代码",
                     @"legalPeople":@"法人（负责人）",
                     @"IDCardNo":@"法定代表人证件号码",
                     @"foundDate":@"成立日期",
                     @"money":@"注册资本（金）",
                     @"address":@"住所",
                     @"business":@"经营（业务）范围",
                     };

        }];
        WLEnterpriseInfo *enterproseInfo = [WLEnterpriseInfo mj_objectWithKeyValues:enterproseInfoDict];
        model.enterpriseInfo = enterproseInfo;

    }
    WLEnterpriseXzDetail *enterpriseXzDetail = [WLEnterpriseXzDetail mj_objectWithKeyValues:dict];
    model.enterpriseXzDetail = enterpriseXzDetail;
    

    return model;
}

@end
