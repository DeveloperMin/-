//
//  ZXCommonSettingViewController.m
//  天天微博
//
//  Created by zxopen06 on 15/10/31.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXCommonSettingViewController.h"

#import "ZXGroupItem.h"
#import "ZXBadgeItem.h"
#import "ZXArrowItem.h"
#import "ZXLabelItem.h"
#import "ZXSwitchItem.h"

@interface ZXCommonSettingViewController ()

@end

@implementation ZXCommonSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加group0
    [self setUpGroup0];
    //添加group1
    [self setUpGroup1];
    //添加group2
    [self setUpGroup2];
    //添加group3
    [self setUpGroup3];
    //添加group4
    [self setUpGroup4];
}
- (void)setUpGroup0
{
    //阅读模式
    ZXLabelItem *read= [ZXLabelItem itemWithTitle:@"阅读模式" subTitle:@"有图模式"];
    
    ZXLabelItem *front= [ZXLabelItem itemWithTitle:@"字体大小"];
    
    ZXSwitchItem *appece= [ZXSwitchItem itemWithTitle:@"显示备注"];
    
    ZXGroupItem *group = [[ZXGroupItem alloc] init];
    group.items = @[read,front, appece];
    
    [self.groups addObject:group];
}

- (void)setUpGroup1
{
    //图片质量
    ZXArrowItem *photoQuality= [ZXArrowItem itemWithTitle:@"图片质量"];
    
    ZXGroupItem *group = [[ZXGroupItem alloc] init];
    group.items = @[photoQuality];
    
    [self.groups addObject:group];
}
- (void)setUpGroup2
{
    //声音
    ZXSwitchItem *sound= [ZXSwitchItem itemWithTitle:@"声音"];
    
    ZXGroupItem *group = [[ZXGroupItem alloc] init];
    group.items = @[sound];
    
    [self.groups addObject:group];
}
- (void)setUpGroup3
{
    ZXLabelItem *moreLanguage = [ZXLabelItem  itemWithTitle:@"多语言环境" subTitle:@"跟随系统"];
    
    ZXGroupItem *group = [[ZXGroupItem alloc] init];
    group.items = @[moreLanguage];
    
    [self.groups addObject:group];
}
- (void)setUpGroup4
{
    ZXArrowItem *clean= [ZXArrowItem itemWithTitle:@"清空图片缓存"];
    
    ZXGroupItem *group = [[ZXGroupItem alloc] init];
    group.items = @[clean];
    
    [self.groups addObject:group];
}


@end
