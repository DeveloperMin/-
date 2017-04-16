//
//  ZXUser.h
//  天天微博
//
//  Created by zxopen06 on 15/10/21.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXUser : NSObject

/**
 *  微博昵称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  微博头像
 */
@property (nonatomic, strong) NSURL *profile_image_url;

/** 会员类型 > 2代表是会员 */
@property (nonatomic, assign) int mbtype;
/** 会员等级 */
@property (nonatomic, assign) int mbrank;


@property (nonatomic, assign,getter=isVip) BOOL vip;

@end
