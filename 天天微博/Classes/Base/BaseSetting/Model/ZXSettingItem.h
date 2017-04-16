//
//  ZXSettingItem.h
//  天天微博
//
//  Created by zxopen06 on 15/10/30.
//  Copyright © 2015年 zxopen06. All rights reserved.
//  

#import <Foundation/Foundation.h>

@interface ZXSettingItem : NSObject
/**
 *  描述imageView
 */
@property (nonatomic, strong) UIImage *image;
/**
 *  描述title
 */
@property (nonatomic, copy) NSString *title;
/**
 *  描述detailTitle
 */
@property (nonatomic, copy) NSString *detailTitle;

/**
 *  跳转控制器的类名
 */
@property(nonatomic, assign) Class destVcClass;


+ (instancetype)itemWithTitle:(NSString *)title;

+ (instancetype)itemWithTitle:(NSString *)title subTitle:(NSString *)subTitle;

+ (instancetype)itemWithImage:(UIImage *)image Title:(NSString *)title subTitle:(NSString *)subTitle;

+ (instancetype)itemWithImage:(UIImage *)image Title:(NSString *)title;


@end
