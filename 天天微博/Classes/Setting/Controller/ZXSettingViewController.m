//
//  ZXSettingViewController.m
//  天天微博
//
//  Created by zxopen06 on 15/10/31.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXSettingViewController.h"

#import "ZXGroupItem.h"
#import "ZXBadgeItem.h"
#import "ZXArrowItem.h"
#import "ZXLabelItem.h"

#import "ZXCommonSettingViewController.h"

@interface ZXSettingViewController ()

@end

@implementation ZXSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //添加group0
    [self setUpGroup0];
    //添加group1
    [self setUpGroup1];
    //添加group2
    [self setUpGroup2];
    //添加group3
    [self setUpGroup3];
}

- (void)setUpGroup0
{
    //账号管理
    ZXBadgeItem *account= [ZXBadgeItem itemWithTitle:@"账号管理"];
    account.badgeValue = @"10";
    
    ZXGroupItem *group = [[ZXGroupItem alloc] init];
    group.items = @[account];
    
    [self.groups addObject:group];
}

- (void)setUpGroup1
{
    //我的相册
    ZXArrowItem *account= [ZXArrowItem itemWithTitle:@"我的相册"];
    //通用设置
    ZXArrowItem *setting= [ZXArrowItem itemWithTitle:@"通用设置"];
    setting.destVcClass = [ZXCommonSettingViewController class];
    
    //隐私安全
    ZXArrowItem *securty= [ZXArrowItem itemWithTitle:@"隐私安全"];
    
    ZXGroupItem *group = [[ZXGroupItem alloc] init];
    group.items = @[account, setting, securty];
    
    [self.groups addObject:group];
}
- (void)setUpGroup2
{
    //意见反馈
    ZXArrowItem *idea= [ZXArrowItem itemWithTitle:@"意见反馈"];
    //关于微博
    ZXArrowItem *about= [ZXArrowItem itemWithTitle:@"关于微博"];
    
    ZXGroupItem *group = [[ZXGroupItem alloc] init];
    group.items = @[idea, about];
    
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    ZXLabelItem *logout = [[ZXLabelItem alloc] init];
    logout .text = @"退出当前程序";
    
    ZXGroupItem *group = [[ZXGroupItem alloc] init];
    group.items = @[logout];
    
    [self.groups addObject:group];
}


@end
