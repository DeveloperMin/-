//
//  UIImage+ZXImage.h
//  天天微博
//
//  Created by zxopen06 on 15/10/18.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZXImage)
//要原始的图片,不要渲染
+ (instancetype)imageWithOriginalName:(NSString *)imageName;

//拉伸图片
+ (instancetype)imageWithStretchableName:(NSString *)imageName;
@end
