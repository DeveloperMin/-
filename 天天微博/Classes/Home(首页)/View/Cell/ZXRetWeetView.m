//
//  ZXRetWeetView.m
//  天天微博
//
//  Created by zxopen06 on 15/10/23.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXRetWeetView.h"

#import "ZXStatusFrame.h"
#import "ZXStatus.h"

#import "ZXPhotosView.h"

@interface ZXRetWeetView ()

//昵称
@property (nonatomic, weak) UILabel *nameView ;

//正文
@property (nonatomic, weak) UILabel *textView ;
//正文
@property (nonatomic, weak) ZXPhotosView *photosView ;
@end

@implementation ZXRetWeetView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加所有子控件
        [self setUpAllChild];
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_retweet_background"];
    }
    return self;
}

- (void)setUpAllChild
{
    //昵称
    UILabel *nameView= [[UILabel alloc] init];
    [self addSubview:nameView];
    nameView.textColor = [UIColor blueColor];
    nameView.font = ZXStatusNameFront;
    self.nameView = nameView;
    
    //正文
    UILabel *textView= [[UILabel alloc] init];
    [self addSubview:textView];
    textView.numberOfLines = 0;
    textView.font = ZXStatusTextFront;
    self.textView = textView;
    
    //配图
    ZXPhotosView *photosView = [[ZXPhotosView alloc] init];
    [self addSubview:photosView];
    self.photosView = photosView;
    
}
- (void)setStatusFrame:(ZXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    ZXStatus *status = statusFrame.status;
    
    //设置昵称
    self.nameView.frame = statusFrame.retWeetNameFrame;
    self.nameView.text = status.retweetName;
    
    //设置转发微博
    self.textView.frame = statusFrame.retWeetTextFrame;
    self.textView.text = status.retweeted_status.text;
    
    //配图
    self.photosView.frame = _statusFrame.retWeetPhotoFrame;
    self.photosView.pic_urls = status.retweeted_status.pic_urls;
}

@end
