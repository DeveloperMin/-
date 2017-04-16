//
//  ZXComposeTool.h
//  天天微博
//
//  Created by zxopen06 on 15/10/26.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZXComposeTool : NSObject
/**
 *  发送文字
 */
+ (void)composeStatusWithText:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error))failure;
//上传图片
+ (void)composeStatusWithText:(NSString *)status image:(UIImage *)image success:(void(^)())success failure:(void(^)(NSError *error))failure;
@end
