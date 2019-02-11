//
//  WLProfileViewController.m
//  CreditChina
//
//  Created by 王磊 on 2019/1/30.
//  Copyright © 2019 wanglei. All rights reserved.
//

#import "WLProfileViewController.h"
#import "WLTableView.h"
#import <Masonry.h>
#import "WLImageTitleAccessCell.h"
#import <objc/runtime.h>
#import "WLProfileHeaderCell.h"

@interface WLProfileViewController ()<wlTableViewDelegate>

@property (nonatomic, strong) WLTableView *tableView;
@property (nonatomic, strong) NSArray *rowsData;

@end

@implementation WLProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.navigationController.navigationBar.hidden = YES;
    [self decorateUI];
    
}

- (void)decorateUI
{
    UIView *profileView = [[UIView alloc]init];
    [self.view addSubview:profileView];
    UIImageView *profileImageView=  [[UIImageView alloc]init];
    profileImageView.image = [UIImage imageNamed:@"profileImage"];
    [profileView addSubview:profileImageView];
    
    UILabel *profileLabel = [[UILabel alloc]init];
    profileLabel.text = @"登录/注册";
    [profileView addSubview:profileLabel];
    
    [profileView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view.mas_centerX);
        make.top.equalTo(self.view.mas_top).offset(20);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.height.mas_equalTo(130);
    }];
    [profileImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(profileView.mas_top).offset(10);
        make.centerX.equalTo(profileView.mas_centerX);
        make.width.height.mas_equalTo(70);
        
    }];
    [profileLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(profileImageView.mas_bottom).offset(10);
        make.centerX.equalTo(profileImageView.mas_centerX);
    }];
    
    
    WLTableView *tableView = [[WLTableView alloc]init];
    self.tableView = tableView;
    tableView.cellClass = [WLImageTitleAccessCell class];
    tableView.wltableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [tableView registNibForCell:@"WLImageTitleAccessCell"  inBundel:nil orBundleName:@"WLControls"];
    [tableView registNibForCell:@"WLProfileHeaderCell"  inBundel:nil orBundleName:@"WLControls"];
    self.rowsData =@[
                     @{@"image":@"SearchQuestion",@"title":@"问题搜索",@"subTitle":@"",@"accessView":@"accessView"},
                     @{@"image":@"feedback",@"title":@"意见反馈",@"subTitle":@"",@"accessView":@"accessView"},
                     @{@"image":@"PushRecord",@"title":@"消息推送",@"subTitle":@"",@"accessView":@"accessView"},
                     @{@"image":@"clearCache",@"title":@"清除缓存",@"subTitle":@"",@"accessView":@"accessView"}];
    tableView.rowsData = self.rowsData;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.edges.equalTo(self.view);
        make.top.equalTo(profileView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view.mas_centerX);
        make.left.equalTo(self.view.mas_left).offset(20);
        make.right.equalTo(self.view.mas_right).offset(-20);
        make.bottom.equalTo(self.view.mas_bottom).offset(-70);
    }];
}


//-(UITableViewCell *)wltableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    WLBaseTableViewCell *cell;
//    if (indexPath.row == 0)
//    {
//        Class class = [WLProfileHeaderCell class];
//        
//        NSString *className = [NSString stringWithUTF8String:class_getName(class)];
//        
//        cell = [tableView dequeueReusableCellWithIdentifier:className forIndexPath:indexPath];
//        self.tableView.cellClass = class;
//        [cell fillCellContent:self.rowsData[indexPath.row] withTableView:tableView];
//        
//    }else
//    {
//        Class class = [WLImageTitleAccessCell class];
//        self.tableView.cellClass = class;
//        NSString *className = [NSString stringWithUTF8String:class_getName(class)];
//        
//        cell = [tableView dequeueReusableCellWithIdentifier:className forIndexPath:indexPath];
//        
//        [cell fillCellContent:self.rowsData[indexPath.row] withTableView:tableView];
//    }
//
//    
//    return cell;
//}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
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
