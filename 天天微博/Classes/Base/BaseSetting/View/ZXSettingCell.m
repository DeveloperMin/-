//
//  ZXSettingCell.m
//  天天微博
//
//  Created by zxopen06 on 15/10/30.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXSettingCell.h"

#import "ZXGroupItem.h"
#include "ZXArrowItem.h"
#import "ZXBadgeItem.h"
#import "ZXSwitchItem.h"
#import "ZXCheakItem.h"
#import "ZXLabelItem.h"

#import "ZXBadgeView.h"

@interface ZXSettingCell ()

@property (nonatomic, strong) UIImageView *arrowView;

@property (nonatomic, strong) ZXBadgeView *badgeView;
@property (nonatomic, strong) UISwitch    *switchView;
@property (nonatomic, strong) UIImageView *cheakView;
@property (nonatomic, strong) UILabel     *labelView;
@end


@implementation ZXSettingCell

- (UILabel *)labelView
{
    if (_labelView == nil) {
        _labelView = [[UILabel alloc] init];
        _labelView.textAlignment = NSTextAlignmentCenter;
        _labelView.textColor = [UIColor redColor];
    }
    return _labelView;
}

- (UIImageView *)arrowView
{
    if (_arrowView == nil) {
        _arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_arrow"]];
    }
    return _arrowView;
}

- (ZXBadgeView *)badgeView
{
    if (_badgeView == nil) {
        _badgeView = [ZXBadgeView buttonWithType:UIButtonTypeCustom];
    }
    return _badgeView;
}
- (UIImageView *)cheakView
{
    if (_cheakView == nil) {
        _cheakView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"common_icon_checkmark"]];
    }
    return _cheakView;
}
- (UISwitch *)switchView
{
    if (_switchView == nil) {
        _switchView = [[UISwitch alloc] init];
    }
    return _switchView;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (instancetype)cellWithTableView:(UITableView *)tablview
{
    static NSString *ID = @"cell";
    //创建cell
    ZXSettingCell *cell = [tablview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    }
    return cell;
}
- (void)setItem:(ZXSettingItem *)item
{
    _item = item;
    
    //设置内容
    [self setUpData];
    //设置右视图
    [self setUpRightView];
    
    //设置labelView
    if ([item isKindOfClass:[ZXLabelItem class]]) {
        ZXLabelItem *item = (ZXLabelItem *)_item;
        self.labelView.text = item.text;
        
        [self addSubview:self.labelView];
    }else
    {
        [self.labelView removeFromSuperview];
    }
}
//设置内容
- (void)setUpData
{
    self.textLabel.text = _item.title;
    self.detailTextLabel.text = _item.detailTitle;
    self.imageView.image = _item.image;
}
//设置右视图
- (void)setUpRightView
{
    if ([_item isKindOfClass:[ZXArrowItem class]]) { //箭头
        self.accessoryView = self.arrowView;
    }else if ([_item isKindOfClass:[ZXBadgeItem class]])
    { //dadgeView
        ZXBadgeItem *badgeItem = (ZXBadgeItem *)_item;
        self.badgeView.badgeValue = badgeItem.badgeValue;
        self.accessoryView = self.badgeView;
    }else if ([_item isKindOfClass:[ZXSwitchItem class]])
    { //switchView
      
        self.accessoryView = self.switchView;
        
    }else if ([_item isKindOfClass:[ZXCheakItem class]])
    { //cheakView
        ZXCheakItem *cheakItem = (ZXCheakItem *)_item;
        if (cheakItem.isCheak) {
            self.accessoryView = self.cheakView;
        }else
        {
            self.accessoryView = nil;
        }
    }else
    {
        self.accessoryView = nil;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    _labelView.frame = self.bounds;
}

@end
