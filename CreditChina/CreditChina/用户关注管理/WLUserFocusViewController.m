//
//  WLUserFocusViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/30.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLUserFocusViewController.h"
#import "WLSegmentTableViewController.h"
#import <Masonry.h>
#import "WLTableView.h"
#import "WLUserFocusTableController.h"

@interface WLUserFocusViewController ()

@end

@implementation WLUserFocusViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self decorateUI];
}

- (void)decorateUI
{
    WLSegmentTableViewController *segVC = [[WLSegmentTableViewController alloc]init];
    
    segVC.titles = @[@"新闻",@"信用主体",@"双公示"];
    NSMutableArray *controllers = [NSMutableArray arrayWithCapacity:3];
    for (NSString *title in segVC.titles)
    {
        WLUserFocusTableController *tableView = [[WLUserFocusTableController alloc]init];
        tableView.view.backgroundColor = [UIColor redColor];
        [controllers addObject:tableView];
    }
    segVC.controllers = controllers;
    [self addChildViewController:segVC];
    [self.view addSubview:segVC.view];
    [segVC didMoveToParentViewController:self];
    
    [segVC.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
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
