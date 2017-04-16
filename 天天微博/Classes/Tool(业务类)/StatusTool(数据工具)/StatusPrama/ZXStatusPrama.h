//
//  ZXStatusPrama.h
//  天天微博
//
//  Created by zxopen06 on 15/10/22.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXStatusPrama : NSObject
/**
 *  采用OAuth授权方式为必填参数,访问命令牌
 */
@property (nonatomic, copy) NSString *access_token;
/**
 *  返回比max_id小得数据
 */
@property (nonatomic, copy) NSString *max_id;
/**
 *  返回比since_id大的数据
 */
@property (nonatomic, copy) NSString *since_id;

@end
