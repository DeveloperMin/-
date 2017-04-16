//
//  ZXSearchBar.m
//  天天微博
//
//  Created by zxopen06 on 15/10/19.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXSearchBar.h"

@implementation ZXSearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //设置搜索框的样式
        self.borderStyle = UITextBorderStyleRoundedRect;
        
        self.font = [UIFont systemFontOfSize:13];
        UIImage *image = [UIImage imageWithStretchableName: @"searchbar_textfield_background"];
        self.background = image;
        //initWithImage:默认UIImageView图片一样大
        UIImageView *leftView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchbar_textfield_search_icon"]];
        leftView.width += 10;
        leftView.contentMode = UIViewContentModeCenter;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}

@end
