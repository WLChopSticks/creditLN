//
//  WLNewsViewController.h
//  CreditChina
//
//  Created by 王磊 on 2019/1/31.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLBaseUIViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface WLNewsViewController : WLBaseUIViewController

//1为国内动态, 2为省内动态
@property (nonatomic, strong) NSString *newsSource;

@end

NS_ASSUME_NONNULL_END
