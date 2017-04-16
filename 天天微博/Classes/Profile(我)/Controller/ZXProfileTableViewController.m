//
//  ZXProfileTableViewController.m
//  天天微博
//
//  Created by zxopen06 on 15/10/19.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXProfileTableViewController.h"

#import "ZXGroupItem.h"
#import "ZXArrowItem.h"
#import "ZXSwitchItem.h"
#import "ZXBadgeItem.h"
#import "ZXCheakItem.h"

#import "ZXProfileCell.h"
#import "ZXSettingViewController.h"

@interface ZXProfileTableViewController ()

@end

@implementation ZXProfileTableViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置导航栏
    [self setUpNav];
    
    //添加group0
    [self setUpGroup0];
    //添加group1
    [self setUpGroup1];
    //添加group2
    [self setUpGroup2];
    //添加group3
    [self setUpGroup3];
}
//点击设置按钮
- (void)setting {
    
    ZXSettingViewController *settingVc = [[ZXSettingViewController alloc] init];
    [self.navigationController pushViewController:settingVc animated:YES];
}
- (void)setUpGroup0
{
    //新的好友
    ZXArrowItem *friend= [ZXArrowItem itemWithImage:[UIImage imageNamed:@"new_friend"] Title:@"新的好友"];
    ZXGroupItem *group = [[ZXGroupItem alloc] init];
    group.items = @[friend];
    
    [self.groups addObject:group];
}
- (void)setUpGroup1
{
    //我的相册
    ZXArrowItem *album = [ZXArrowItem itemWithImage:[UIImage imageNamed:@"album"] Title:@"我的相册" subTitle:@"(12)"];
    //我的收藏
    ZXArrowItem *collect = [ZXArrowItem itemWithImage:[UIImage imageNamed:@"collect"] Title:@"我的收藏" subTitle:@"(0)" ];
    //赞
    ZXArrowItem *like = [ZXArrowItem itemWithImage:[UIImage imageNamed:@"like"] Title:@"我的相册" subTitle:@"(0)"];
    
    ZXGroupItem *group = [[ZXGroupItem alloc] init];
    group.items = @[album, collect, like];
    
    
    [self.groups addObject:group];
}
- (void)setUpGroup2
{
    //微博支付
    ZXArrowItem *pay = [ZXArrowItem itemWithImage:[UIImage imageNamed:@"pay"] Title:@"微博支付"];
    //个性化
    ZXArrowItem *vip = [ZXArrowItem itemWithImage:[UIImage imageNamed:@"vip"] Title:@"个性化" subTitle:@"微博来源、皮肤、封面图" ];
    
    ZXGroupItem *group = [[ZXGroupItem alloc] init];
    group.items = @[pay, vip];
    
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    //我的二维码
    ZXArrowItem *card = [ZXArrowItem itemWithImage:[UIImage imageNamed:@"card"] Title:@"我的二维码"];
    //草稿箱
    ZXArrowItem *draft = [ZXArrowItem itemWithImage:[UIImage imageNamed:@"draft"] Title:@"草稿箱" subTitle:@"(10)" ];
    
    ZXGroupItem *group = [[ZXGroupItem alloc] init];
    group.items = @[card, draft];
    
    [self.groups addObject:group];
}

- (void)setUpNav
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"设置" style:UIBarButtonItemStyleBordered target:self action:@selector(setting)];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    ZXProfileCell *cell = [ZXProfileCell cellWithTableView:tableView];
    //赋值
    ZXGroupItem *group = self.groups[indexPath.section];
    ZXSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    
    return cell;
}


@end
