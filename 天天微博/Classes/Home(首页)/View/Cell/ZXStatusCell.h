//
//  ZXStatusCell.h
//  天天微博
//
//  Created by zxopen06 on 15/10/23.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXStatusFrame;

@interface ZXStatusCell : UITableViewCell

@property (nonatomic, strong) ZXStatusFrame *statusFrame;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
