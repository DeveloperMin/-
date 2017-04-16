//
//  ZXStatusFrame.h
//  天天微博
//
//  Created by zxopen06 on 15/10/23.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZXStatus;
@interface ZXStatusFrame : NSObject

@property (nonatomic, strong) ZXStatus *status;
/**
 *  原创微博的frame
 */
@property (nonatomic, assign) CGRect originalViewFrame;

/********************原创微博子控件的frame***************/

/**
 *  头像的frame
 */
@property (nonatomic, assign) CGRect originalIconFrame;
/**
 *  昵称的frame
 */
@property (nonatomic, assign) CGRect originalNameFrame;
/**
 *  会员frame
 */
@property (nonatomic, assign) CGRect originalVipFrame;
/**
 *  时间的frame
 */
@property (nonatomic, assign) CGRect originalTimeFrame;
/**
 *  来源frame
 */
@property (nonatomic, assign) CGRect originalSourceFrame;
/**
 *  正文frame
 */
@property (nonatomic, assign) CGRect originalTextFrame;
/**
 * 原创配图
 */
@property (nonatomic, assign) CGRect originalPhotoFrame;


/********************转发微博子控件的frame***************/

/**
 *  转发微博的frame
 */
@property (nonatomic, assign) CGRect retWeetViewFrame;



/**
 *  昵称的frame
 */
@property (nonatomic, assign) CGRect retWeetNameFrame;
/**
 *  正文frame
 */
@property (nonatomic, assign) CGRect retWeetTextFrame;
/**
 * 原创配图
 */
@property (nonatomic, assign) CGRect retWeetPhotoFrame;



/**
 *  工具条frame
 */
@property (nonatomic, assign) CGRect toolBarFrame;
/**
 *  cell的frame
 */
@property (nonatomic, assign) CGFloat cellHight;
@end
