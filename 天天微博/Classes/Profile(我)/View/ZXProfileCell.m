//
//  ZXProfileCell.m
//  天天微博
//
//  Created by zxopen06 on 15/10/31.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXProfileCell.h"

@implementation ZXProfileCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.detailTextLabel.font = [UIFont systemFontOfSize:12];
    }
    return self;
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.detailTextLabel.x = CGRectGetMaxX(self.textLabel.frame) + 5;
}

@end
