//
//  ZXAccount.h
//  天天微博
//
//  Created by zxopen06 on 15/10/21.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <Foundation/Foundation.h>
/*
 "access_token" = "2.00Kg3LcDopE2EC8d91b8b6ab0T8G9b";
 "expires_in" = 157679999;
 "remind_in" = 157679999;
 uid = 3312608054;
 */
@interface ZXAccount : NSObject <NSCoding>
/**
 *  获取数据的命令牌
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *expires_in;
/**
 *  账号的有效期
 */
@property (nonatomic, copy) NSString *remind_in;
/**
 *  用户的唯一标识符
 */
@property (nonatomic, copy) NSString *uid;
/**
 *  用户的过期时间
 */
@property (nonatomic, strong) NSDate *expires_date;
/**
 *  用户昵称
 */
@property (nonatomic, copy) NSString *name;

+ (instancetype)accoutWithDictionary:(NSDictionary *)dict;

@end
