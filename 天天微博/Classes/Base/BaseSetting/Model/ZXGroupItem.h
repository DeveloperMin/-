//
//  ZXGroupItem.h
//  天天微博
//
//  Created by zxopen06 on 15/10/30.
//  Copyright © 2015年 zxopen06. All rights reserved.
//  描述每组什么样子

#import <Foundation/Foundation.h>

@interface ZXGroupItem : NSObject
/**
 *  返回有一组多少行（ZXSettingItem）
 */
@property (nonatomic, strong) NSArray  *items;
/**
 *  头部标题
 */
@property (nonatomic, copy) NSString *headerTitle;
/**
 *  尾部标题
 */
@property (nonatomic, copy) NSString *footerTitle;

@end
