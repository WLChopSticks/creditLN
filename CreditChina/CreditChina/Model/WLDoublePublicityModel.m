//
//  WLDoublePublicityModel.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/3.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLDoublePublicityModel.h"
#import <MJExtension.h>

@implementation WLDoublePublicityDetailModel

@end

@implementation WLDoublePublicityModel

-(instancetype)getModel:(NSDictionary *)dict
{
    WLDoublePublicityModel *model = [[WLDoublePublicityModel alloc]init];
    model = [WLDoublePublicityModel mj_objectWithKeyValues:dict];
    model.dataList = [WLDoublePublicityDetailModel mj_objectArrayWithKeyValuesArray:(NSArray *)dict[@"dataList"]];
    return model;
}

-(WLDoublePublicityDetailModel *)detailGetModel:(NSDictionary *)dict
{
    WLDoublePublicityDetailModel *model = [[WLDoublePublicityDetailModel alloc]init];
    model = [WLDoublePublicityDetailModel mj_objectWithKeyValues:dict];
    return model;
}

@end
