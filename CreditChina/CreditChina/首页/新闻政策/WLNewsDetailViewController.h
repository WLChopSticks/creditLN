//
//  WLNewsDetailViewController.h
//  CreditChina
//
//  Created by 王磊 on 2019/2/15.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLBaseUIViewController.h"



@interface WLNewsDetailViewController : WLBaseUIViewController

@property (nonatomic, strong) NSDictionary *content;
@property (nonatomic, strong) NSString *contentBaseURL;
//1为新闻详情页, 2为国家政策详情页
@property (nonatomic, strong) NSString *newsType;


@end


