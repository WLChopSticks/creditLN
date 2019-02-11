//
//  WLDoublePublicityModel.h
//  CreditChina
//
//  Created by 王磊 on 2019/2/3.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLDoublePublicityDetailModel : NSObject

@property (nonatomic, strong) NSString *id;
@property (nonatomic, strong) NSString *xzxdrlb;
@property (nonatomic, strong) NSString *xzxdrmc;
@property (nonatomic, strong) NSString *xzxdrdm1;
@property (nonatomic, strong) NSString *xzxdrdm2;
@property (nonatomic, strong) NSString *xzxdrdm3;
@property (nonatomic, strong) NSString *xzxdrdm4;
@property (nonatomic, strong) NSString *xzxdrdm5;
@property (nonatomic, strong) NSString *xzxdrdm6;
@property (nonatomic, strong) NSString *fddbrxm;
@property (nonatomic, strong) NSString *fddbrzjlx;
@property (nonatomic, strong) NSString *fddbrzjhm;
@property (nonatomic, strong) NSString *zjlx;
@property (nonatomic, strong) NSString *zjhm;
@property (nonatomic, strong) NSString *xzcfjdswh;
@property (nonatomic, strong) NSString *wfxwlx;
@property (nonatomic, strong) NSString *cfsy;
@property (nonatomic, strong) NSString *cfyj;
@property (nonatomic, strong) NSString *cflb;
@property (nonatomic, strong) NSString *cfnr;
@property (nonatomic, strong) NSString *fkje;
@property (nonatomic, strong) NSString *ms;
@property (nonatomic, strong) NSString *zkdx;
@property (nonatomic, strong) NSString *cfjdrq;
@property (nonatomic, strong) NSString *cfycq;
@property (nonatomic, strong) NSString *gsjzrq;
@property (nonatomic, strong) NSString *cfjg;
@property (nonatomic, strong) NSString *cfjgtystydm;
@property (nonatomic, strong) NSString *sjlydw;
@property (nonatomic, strong) NSString *sjlydwtyshxydm;
@property (nonatomic, strong) NSString *bz;
@property (nonatomic, strong) NSString *etablename;
@property (nonatomic, strong) NSString *rowcheck;
@property (nonatomic, strong) NSString *reportstate;
@property (nonatomic, strong) NSString *sourcetype;
@property (nonatomic, strong) NSString *reportusercode;
@property (nonatomic, strong) NSString *reportdeptcode;
@property (nonatomic, strong) NSString *updateusercode;
@property (nonatomic, strong) NSString *updatedeptcode;
@property (nonatomic, strong) NSString *dissenttype;
@property (nonatomic, strong) NSString *isvalid;
@property (nonatomic, strong) NSString *isdelete;
@property (nonatomic, strong) NSString *reporttime;
@property (nonatomic, assign) NSTimeInterval updatetime;
@property (nonatomic, strong) NSString *reportdeptcodes;

@end

@interface WLDoublePublicityModel : NSObject

@property (nonatomic, strong) NSArray *dataList;
@property (nonatomic, strong) NSString *pageCount;
@property (nonatomic, strong) NSString *pageSize;
@property (nonatomic, strong) NSString *itemCount;
@property (nonatomic, strong) NSString *pageNum;

-(instancetype)getModel:(NSDictionary *)dict;

-(WLDoublePublicityDetailModel *)detailGetModel:(NSDictionary *)dict;

@end


