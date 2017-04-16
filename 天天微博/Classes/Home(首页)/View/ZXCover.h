//
//  ZXCover.h
//  天天微博
//
//  Created by zxopen06 on 15/10/19.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZXCover;
@protocol ZXCoverDelegate <NSObject>
@optional
// 点击蒙板的时候调用
- (void)coverDidClickCover:(ZXCover *)cover;

@end
@interface ZXCover : UIView

/**
 *  显示蒙板
 */
+ (instancetype)show;

// 设置浅灰色蒙板
@property (nonatomic, assign) BOOL dimBackground;

@property (nonatomic, weak) id<ZXCoverDelegate> delegate;

@end
