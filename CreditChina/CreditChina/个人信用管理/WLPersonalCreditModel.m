//
//  WLPersonalCreditModel.m
//  CreditChina
//
//  Created by 王磊 on 2019/3/3.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLPersonalCreditModel.h"
#import "MJExtension.h"

@interface WLPersonalCreditPersonModel()
@end
@implementation WLPersonalCreditPersonModel
@end
@interface WLPersonalCreditSocialDetailModel()
@end
@implementation WLPersonalCreditSocialDetailModel
@end
@interface WLPersonalCreditCategoryMapModel()
@end
@implementation WLPersonalCreditCategoryMapModel
+(NSDictionary *)mj_objectClassInArray
{
    return @{@"socialRegion":@"WLPersonalCreditSocialDetailModel"};
}

+(NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"socialRegion":@"社会管理领域",
             @"businessRegion":@"商务领域",
             @"judicialRegion":@"司法领域",
             @"additionRegion":@"加分信息",
             };
}
@end

@implementation WLPersonalCreditModel


+(instancetype)getModel:(NSDictionary *)dict
{
    WLPersonalCreditModel *model = [WLPersonalCreditModel mj_objectWithKeyValues:dict];
    return model;
}

@end
