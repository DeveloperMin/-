//
//  ZXStatus.h
//  天天微博
//
//  Created by zxopen06 on 15/10/21.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MJExtension.h"
#import "ZXUser.h"


@interface ZXStatus : NSObject<MJKeyValue>
/**
 *  微博创建时间
 */
@property (nonatomic, copy) NSString *created_at;
/**
 *  字符串型的微博ID
 */
@property (nonatomic, copy) NSString *idstr;
/**
 *  微博信息内容
 */
@property (nonatomic, copy) NSString *text;
/**
 *  微博来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  转发数
 */
@property (nonatomic, assign) int reposts_count;
/**
 *  评论数
 */
@property (nonatomic, assign) int comments_count;
/**
 *  表态数
 */
@property (nonatomic, assign) int attitudes_count;
/**
 *  微博作者的用户信息字段
 */
@property (nonatomic, strong) ZXUser *user;
/**
 *  微博配图ID
 */
@property (nonatomic, strong) NSArray *pic_urls;
/**
 *  被转发的原微博信息字段，当该微博为转发微博时返回
 */
@property (nonatomic, strong) ZXStatus *retweeted_status;
/**
 *  转发微博昵称
 */
@property (nonatomic, copy) NSString *retweetName;

@end
