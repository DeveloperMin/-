//
//  ZXSettingCell.h
//  天天微博
//
//  Created by zxopen06 on 15/10/30.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZXSettingItem.h"

@interface ZXSettingCell : UITableViewCell

+ (instancetype)cellWithTableView:(UITableView *)tablview;

@property (nonatomic, strong) ZXSettingItem *item;

@end
