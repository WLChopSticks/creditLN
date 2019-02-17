//
//  WLNewsDetailViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/2/15.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLNewsDetailViewController.h"
#import <WebKit/WebKit.h>
#import <WLPlatform.h>

@interface WLNewsDetailViewController ()<UITextViewDelegate>

@property (nonatomic, strong) WKWebView *webView;

@end

@implementation WLNewsDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self decorateUI];
}

- (void)decorateUI
{
    
    UIScrollView *backScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60)];
    [self.view addSubview:backScrollView];
    backScrollView.contentSize = CGSizeMake(self.view.frame.size.width, 1000);
    
    UILabel *title = [[UILabel alloc]init];
    title.numberOfLines = 0;
    title.text = self.content[@"title"];
    [backScrollView addSubview:title];
    
    UILabel *subLabel = [[UILabel alloc]init];
    subLabel.textAlignment = NSTextAlignmentCenter;
    subLabel.text = [NSString stringWithFormat:@"%@|%@",self.content[@"type"],self.content[@"time"]];
    [backScrollView addSubview:subLabel];
    
    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
    
    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
    [wkUController addUserScript:wkUScript];
    
    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
    wkWebConfig.userContentController = wkUController;
    WKWebView *contentView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, 100, 100) configuration:wkWebConfig];
    
    [backScrollView addSubview:contentView];
    NSString *showString = [WLCommonTool replaceImageSrcURL:self.content[@"content"] withHost:self.contentBaseURL];
    showString = [NSString stringWithFormat:@"<head></head>%@",showString];
    [contentView loadHTMLString:showString baseURL:[NSURL URLWithString:self.contentBaseURL]];
    
    [backScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [title mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(backScrollView.mas_top);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(title.mas_bottom).offset(10);
        make.right.equalTo(self.view.mas_right);
    }];
    
    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view.mas_left);
        make.top.equalTo(subLabel.mas_bottom).offset(10);
        make.right.equalTo(self.view.mas_right);
        make.bottom.equalTo(self.view.mas_bottom);
    }];
    
}

-(BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange
{
    return YES;
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
