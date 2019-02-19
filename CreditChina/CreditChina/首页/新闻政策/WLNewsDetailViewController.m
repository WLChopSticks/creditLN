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
#import <UIImageView+WebCache.h>

#define NewsTitleCell @"NewsTitleCell"
#define NewsContentCell @"NewsContentCell"
#define NewsRemarkCell @"NewsRemarkCell"

@interface WLNewsDetailTitleCell ()

@property (nonatomic, strong) NSDictionary *data;
@property (nonatomic, weak) UILabel *title;
@property (nonatomic, weak) UILabel *source;
@property (nonatomic, weak) UILabel *time;


@end

@implementation WLNewsDetailTitleCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UILabel *titleLabel = [[UILabel alloc]init];
        self.title = titleLabel;
        titleLabel.font = [UIFont systemFontOfSize:20];
        titleLabel.numberOfLines = 0;
        [self.contentView addSubview:titleLabel];
        
        UILabel *source = [[UILabel alloc]init];
        self.source = source;
        source.font = [UIFont systemFontOfSize:14];
        source.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:source];
        
        UILabel *time = [[UILabel alloc]init];
        self.time = time;
        time.font = [UIFont systemFontOfSize:14];
        time.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:time];
        
        [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
        }];
        
        [source mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(titleLabel.mas_bottom);
            make.left.equalTo(titleLabel.mas_left);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
        
        [time mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(source.mas_top);
            make.left.equalTo(source.mas_right).offset(10);
        }];
    }
    
    return self;
}

-(void)setData:(NSDictionary *)data
{
    _data = data;
    
    self.title.text = data[@"title"];
    self.source.text = data[@"source"];
    self.time.text = data[@"time"];
}

@end

@interface WLNewsDetailContentCell ()

@property (nonatomic, weak) WKWebView *webView;
@property (nonatomic, strong) NSString *detail;
@property (nonatomic, strong) NSString *baseURL;

@end

@implementation WLNewsDetailContentCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
        config.selectionGranularity = WKSelectionGranularityCharacter;
        WKWebView *webView = [[WKWebView alloc]initWithFrame:CGRectZero configuration:config];
        self.webView = webView;
        [self.contentView addSubview:webView];
        webView.scrollView.scrollEnabled=NO;
        webView.backgroundColor = [UIColor redColor];
        [webView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.right.equalTo(self.contentView.mas_right).offset(-10);

            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    
    return self;
}

-(void)setDetail:(NSString *)detail
{
    _detail = detail;
    
    if (_detail.length >0)
    {
        [_webView loadHTMLString:[NSString stringWithFormat:@"<meta content=\"width=device-width, initial-scale=1.0, maximum-scale=3.0, user-scalable=0;\" name=\"viewport\" />%@<div id=\"testDiv\" style = \"height:100px; width:100px\"></div>",detail] baseURL:[NSURL URLWithString:self.baseURL]];
    }
}

@end

@interface WLNewsDetailRemarkCell ()

@property (nonatomic, strong) NSDictionary *content;
@property (nonatomic, weak) UIImageView *image;
@property (nonatomic, weak) UILabel *username;
@property (nonatomic, weak) UILabel *remarkContent;

@end

@implementation WLNewsDetailRemarkCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        UIImageView *image = [[UIImageView alloc]init];
        self.image = image;
        image.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:image];
        UILabel *username = [[UILabel alloc]init];
        self.username = username;
        [self.contentView addSubview:username];
        UILabel *remarkContent = [[UILabel alloc]init];
        remarkContent.numberOfLines = 0;
        remarkContent.font = [UIFont systemFontOfSize:14];
        self.remarkContent = remarkContent;
        [self.contentView addSubview:remarkContent];
        
        [image mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView.mas_top).offset(10);
            make.left.equalTo(self.contentView.mas_left).offset(10);
            make.width.height.mas_equalTo(30);
        }];
        
        [username mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(image.mas_top);
            make.left.equalTo(image.mas_right).offset(10);
            make.width.mas_equalTo(100);
            make.height.mas_equalTo(25);
        }];
        
        [remarkContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(username.mas_bottom);
            make.left.equalTo(username.mas_left);
            make.right.equalTo(self.contentView.mas_right).offset(-10);
            make.bottom.equalTo(self.contentView.mas_bottom);
        }];
    }
    
    return self;
}

-(void)setContent:(NSDictionary *)content
{
    _content = content;
    
    [self.image sd_setImageWithURL:[NSURL URLWithString:content[@"image"]]];
    self.username.text = content[@"username"];
    self.remarkContent.text = content[@"remark"];
}

@end

@interface WLNewsDetailViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) WKWebView *webView;

@end

@interface WLNewsDetailViewController ()<WKUIDelegate, WKNavigationDelegate>

@property (nonatomic, strong) UITableView *backScroll;
@property (nonatomic, assign) CGFloat webHeight;
@property (nonatomic, weak) UIView *remarkWirttenView;

@property (nonatomic, strong) NSDictionary *titleDict;

@end

@implementation WLNewsDetailViewController

-(void)viewDidLoad
{
    [super viewDidLoad];
    [self decorateUI];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [ProgressHUD show];
}

- (void)decorateUI
{
    self.title = @"新闻资讯";
    UITableView *backScroll = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 60)];
    self.backScroll = backScroll;
    [self.view addSubview:backScroll];
    backScroll.delegate = self;
    backScroll.dataSource = self;
    backScroll.rowHeight = UITableViewAutomaticDimension;
    backScroll.estimatedRowHeight = 100;
    
    [backScroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [backScroll registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [backScroll registerClass:[WLNewsDetailTitleCell class] forCellReuseIdentifier:NewsTitleCell];
    [backScroll registerClass:[WLNewsDetailContentCell class] forCellReuseIdentifier:NewsContentCell];
    [backScroll registerClass:[WLNewsDetailRemarkCell class] forCellReuseIdentifier:NewsRemarkCell];
    
    [self constructTitleDict:self.content];
    
    if (self.newsType.integerValue == 1)
    {
        [self decorateRemarkView];
    }
    
    
//    UILabel *title = [[UILabel alloc]init];
//    title.numberOfLines = 0;
//    title.text = self.content[@"title"];
//    [backScrollView addSubview:title];
//
//    UILabel *subLabel = [[UILabel alloc]init];
//    subLabel.textAlignment = NSTextAlignmentCenter;
//    subLabel.text = [NSString stringWithFormat:@"%@|%@",self.content[@"type"],self.content[@"time"]];
//    [backScrollView addSubview:subLabel];
//
//    NSString *jScript = @"var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);";
//
//    WKUserScript *wkUScript = [[WKUserScript alloc] initWithSource:jScript injectionTime:WKUserScriptInjectionTimeAtDocumentEnd forMainFrameOnly:YES];
//    WKUserContentController *wkUController = [[WKUserContentController alloc] init];
//    [wkUController addUserScript:wkUScript];
//
//    WKWebViewConfiguration *wkWebConfig = [[WKWebViewConfiguration alloc] init];
//    wkWebConfig.userContentController = wkUController;
//    WKWebView *contentView = [[WKWebView alloc]initWithFrame:CGRectMake(0, 0, 100, 100) configuration:wkWebConfig];
//
//    [backScrollView addSubview:contentView];
//    NSString *showString = [WLCommonTool replaceImageSrcURL:self.content[@"content"] withHost:self.contentBaseURL];
//    showString = [NSString stringWithFormat:@"<head></head>%@",showString];
//    [contentView loadHTMLString:showString baseURL:[NSURL URLWithString:self.contentBaseURL]];
//
//
//
//    [title mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left);
//        make.top.equalTo(backScrollView.mas_top);
//        make.right.equalTo(self.view.mas_right);
//    }];
//
//    [subLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left);
//        make.top.equalTo(title.mas_bottom).offset(10);
//        make.right.equalTo(self.view.mas_right);
//    }];
//
//    [contentView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view.mas_left);
//        make.top.equalTo(subLabel.mas_bottom).offset(10);
//        make.right.equalTo(self.view.mas_right);
//        make.bottom.equalTo(self.view.mas_bottom);
//    }];
    
}

- (void)decorateRemarkView
{
    UIView *remarkWrittenView = [[UIView alloc]init];
    remarkWrittenView.backgroundColor = [UIColor whiteColor];
    self.remarkWirttenView = remarkWrittenView;
    [self.view addSubview:remarkWrittenView];
    
    [remarkWrittenView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.mas_equalTo(40);
    }];
    
    UIView *seperateLine = [[UIView alloc]init];
    seperateLine.backgroundColor = [UIColor lightGrayColor];
    [remarkWrittenView addSubview:seperateLine];
    [seperateLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(remarkWrittenView);
        make.height.mas_equalTo(0.5);
    }];
    
    UITextField *remarkField = [[UITextField alloc]init];
    [remarkWrittenView addSubview:remarkField];
    remarkField.placeholder = @"请填写评论";
    remarkField.borderStyle = UITextBorderStyleRoundedRect;
    
    [remarkField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(remarkWrittenView.mas_left).offset(10);
        make.top.equalTo(remarkWrittenView.mas_top).offset(5);
        make.right.equalTo(remarkWrittenView.mas_right).offset(-70);
        make.height.mas_equalTo(30);
    }];
    
    UIButton *collectBtn = [[UIButton alloc]init];
    [collectBtn setImage:[UIImage imageNamed:@"collect"] forState:UIControlStateNormal];
    [remarkWrittenView addSubview:collectBtn];
    [collectBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(remarkField);
        make.left.equalTo(remarkField.mas_right).offset(10);
        make.height.mas_equalTo(30);
        make.right.equalTo(remarkWrittenView.mas_right).offset(-10);
    }];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrameNotification:) name:UIKeyboardWillChangeFrameNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)constructTitleDict: (NSDictionary *)content
{
    NSMutableDictionary *dictM = [NSMutableDictionary dictionary];
    [dictM setObject:content[@"title"] forKey:@"title"];
    if (content[@"type"])
    {
        [dictM setObject:content[@"type"] forKey:@"source"];
    }
    if (content[@"time"])
    {
        [dictM setObject:content[@"time"] forKey:@"time"];
    }
    if (content[@"updateTime"])
    {
        [dictM setObject:content[@"updateTime"] forKey:@"time"];
    }
    
    self.titleDict = dictM;
}

- (void)keyboardWillChangeFrameNotification:(NSNotification *)notification {
    
    // 获取键盘基本信息（动画时长与键盘高度）
    NSDictionary *userInfo = [notification userInfo];
    CGRect rect = [userInfo[UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    CGFloat keyboardHeight   = CGRectGetHeight(rect);
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    // 修改下边距约束
    [self.remarkWirttenView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-keyboardHeight);
    }];
    
    // 更新约束
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)keyboardWillHideNotification:(NSNotification *)notification
{
    NSDictionary *userInfo   = [notification userInfo];
    CGFloat keyboardDuration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [self.remarkWirttenView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(0);
    }];
    [UIView animateWithDuration:keyboardDuration animations:^{
        [self.view layoutIfNeeded];
    }];
}

-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    [ProgressHUD dismiss];
    [webView evaluateJavaScript:@"document.getElementById(\"testDiv\").offsetTop"completionHandler:^(id _Nullable result,NSError * _Nullable error) {
        //获取页面高度，并重置webview的frame
        CGFloat lastHeight = [result doubleValue];
        webView.frame = CGRectMake(14, 0, Screen_Width - 28, lastHeight);
        self.webHeight = lastHeight;
        [self.backScroll beginUpdates];
        [self.backScroll endUpdates]; }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0)
    {
        WLNewsDetailTitleCell *titleCell = [tableView dequeueReusableCellWithIdentifier:NewsTitleCell forIndexPath:indexPath];
        titleCell.data = self.titleDict;
//        titleCell.title.text = @"发动机拉萨辅导教师;富家大室奥拉夫时间的分类的时间发牢骚分局领导说烦死啦放假的冯老师发;了发的卡萨了;圣诞节啦发生的浪费结束啦睡了拉萨烦死了开发;撒";
        cell = titleCell;
        
    }else if (indexPath.row == 1)
    {
        WLNewsDetailContentCell *webCell = [tableView dequeueReusableCellWithIdentifier:NewsContentCell forIndexPath:indexPath];
        webCell.webView.navigationDelegate = self;
        webCell.webView.UIDelegate = self;
        webCell.selectionStyle = 0;
        webCell.baseURL = self.contentBaseURL;
        webCell.detail = [WLCommonTool replaceImageSrcURL:self.content[@"content"] withHost:self.contentBaseURL];
        cell = webCell;
    }
    else
    {
        WLNewsDetailRemarkCell *remarkCell = [tableView dequeueReusableCellWithIdentifier:NewsRemarkCell forIndexPath:indexPath];
        remarkCell.content = @{@"image":@"",@"username":@"username",@"remark":@"解放路费打死了粉色礼服说解放路费打死了粉色礼服说解放路费打死了粉色礼服说解放路费打死了粉色礼服说解放路费打死了粉色礼服说解放路费打死了粉色礼服说解放路费打死了粉色礼服说解放路费打死了粉色礼服说"};
        cell = remarkCell;
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        CGFloat cellHeight = 0;
        CGSize titleSize = [self.titleDict[@"title"] boundingRectWithSize:CGSizeMake(tableView.frame.size.width - 20, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:20]}                                       context:nil].size;
        cellHeight += titleSize.height;
        return cellHeight + 50;
        
        return 70;
    }else if (indexPath.row == 1)
    {
        if (self.webHeight <= 0)
            return 500;
        return self.webHeight;
    }else
    {
        CGFloat cellHeight = 0;
        CGSize titleSize = [@"解放路费打死了粉色礼服说解放路费打死了粉色礼服说解放路费打死了粉色礼服说解放路费打死了粉色礼服说解放路费打死了粉色礼服说解放路费打死了粉色礼服说解放路费打死了粉色礼服说解放路费打死了粉色礼服说" boundingRectWithSize:CGSizeMake(tableView.frame.size.width - 60, MAXFLOAT)options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}                                       context:nil].size;
        cellHeight += titleSize.height;
        return cellHeight + 40;
    }
    
    return 200;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 判断webView所在的cell是否可见，如果可见就layout
    NSArray *cells = self.backScroll.visibleCells;
    for (UITableViewCell *cell in cells)
    {
        if ([cell isKindOfClass:[WLNewsDetailContentCell class]])
        {
            WLNewsDetailContentCell *webCell = (WLNewsDetailContentCell *)cell;
            [webCell.webView setNeedsLayout];
        }
    }
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
