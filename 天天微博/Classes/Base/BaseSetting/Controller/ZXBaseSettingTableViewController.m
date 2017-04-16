//
//  ZXBaseSettingTableViewController.m
//  天天微博
//
//  Created by zxopen06 on 15/10/30.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXBaseSettingTableViewController.h"
#import "ZXGroupItem.h"
#import "ZXSettingItem.h"
#import "ZXSettingCell.h"

#import "ZXProfileCell.h"

@interface ZXBaseSettingTableViewController ()

@end

@implementation ZXBaseSettingTableViewController
/**
 *  初始化init方法，让控制器为分组状态
 */
- (instancetype)init
{
  
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (NSMutableArray *)groups
{
    if (_groups == nil) {
        _groups = [NSMutableArray array];
    }
    return _groups;
}

- (void)viewDidLoad {
    [super viewDidLoad];

}



#pragma mark - Table view data source
//返回有多少组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return self.groups.count;
}
//返回每组有多少行
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    ZXGroupItem *group = self.groups[section];
    
    return group.items.count;
}

//返回每一行的样式
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //创建cell
    ZXSettingCell *cell = [ZXSettingCell cellWithTableView:tableView];
    //赋值
    ZXGroupItem *group = self.groups[indexPath.section];
    ZXSettingItem *item = group.items[indexPath.row];
    cell.item = item;
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section
{
    ZXGroupItem *group = self.groups[section];
    return group.footerTitle;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    ZXGroupItem *group = self.groups[section];
    return group.headerTitle;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ZXGroupItem *group = self.groups[indexPath.section];
    ZXSettingItem *item = group.items[indexPath.row];
    
    if (item.destVcClass) {
        UIViewController *vc = [[item.destVcClass alloc] init];
        vc.title = item.title;
        [self.navigationController pushViewController:vc animated:YES];
    }
}









@end
