//
//  ZXComposeTool.m
//  天天微博
//
//  Created by zxopen06 on 15/10/26.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXComposeTool.h"

#import "ZXHttpTool.h"
#import "ZXComposePrama.h"

#import "MJExtension.h"

#import "ZXAccountTool.h"
#import "ZXAccount.h"
#import "AFNetworking.h"

@implementation ZXComposeTool

+ (void)composeStatusWithText:(NSString *)status success:(void(^)())success failure:(void(^)(NSError *error))failure
{
    ZXComposePrama *prama = [[ZXComposePrama alloc] init];
    prama.access_token = [ZXAccountTool accout].access_token;
    prama.status = status;
    [ZXHttpTool POST:@"https://api.weibo.com/2/statuses/update.json" parameters:prama.keyValues success:^(id responseObject) {
        if (success) {
            success();
        }
    } failure:^(NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

+ (void)composeStatusWithText:(NSString *)status image:(UIImage *)image success:(void(^)())success failure:(void(^)(NSError *error))failure
{
    ZXComposePrama *prama = [[ZXComposePrama alloc] init];
    prama.access_token = [ZXAccountTool accout].access_token;
    
    prama.status = status.length ? status:@"分享图片";
    
    //创建请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:prama.keyValues constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        //上传的文件都要在这里拼接到formData
//        NSData *data = UIImagePNGRepresentation(image);
        NSData *data = UIImageJPEGRepresentation(image, 0.5);
        /**
         *
         * FileData:要上传的文件的二进制数据
         * name:上传参数名称
         * fileName:上传到服务器的名称
         * mimeType:文件类型
         */
        [formData appendPartWithFileData:data name:@"pic" fileName:@"image.png" mimeType:@"image/png"];
        
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if (success) {
            success();
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (failure) {
            failure(error);
        }
    }];
    
}

@end
