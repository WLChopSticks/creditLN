//
//  WLNewsDetailViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/15.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLNewsDetailViewController.h"

@implementation WLNewsDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self decorateUI];
}

- (void)decorateUI
{
    UIWebView *contentView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60)];
    [self.view addSubview:contentView];
    NSString *showString = [self replaceImageSrcURL:self.content[@"content"]];
    [contentView loadHTMLString:showString baseURL:[NSURL URLWithString:self.contentBaseURL]];
    contentView.scalesPageToFit = YES;
}

- (NSString *)replaceImageSrcURL: (NSString *)originString
{
    BOOL flag = YES;
    do {
        NSRange range = [originString rangeOfString:@"src='/site"];
        if (range.length != 0)
        {
            NSString *subString = [originString substringWithRange:NSMakeRange(range.location + 6, 10)];
            NSArray *components = [subString componentsSeparatedByString:@"/"];
            NSString *needReplaceString = [NSString stringWithFormat:@"/%@",components.firstObject];
            originString = [originString stringByReplacingOccurrencesOfString:needReplaceString withString:@""];
        }else
        {
            flag = NO;
        }
    } while (flag);
    
    return originString;
    
}

@end
