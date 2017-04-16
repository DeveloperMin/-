//
//  ZXPhotoView.m
//  天天微博
//
//  Created by zxopen06 on 15/10/25.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXPhotoView.h"

#import "ZXPhoto.h"

#import "UIImageView+WebCache.h"

@interface ZXPhotoView ()

@property (nonatomic, weak) UIImageView *gifView;

@end

@implementation ZXPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        self.contentMode = UIViewContentModeScaleAspectFill;
        //裁剪多余的图片
        self.clipsToBounds = YES;
        
        UIImageView *gifView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_image_gif"]];
        [self addSubview:gifView];
        _gifView = gifView;
    }
    return self;
}

- (void)setPhoto:(ZXPhoto *)photo
{
    _photo = photo;
    
    // 赋值
    [self sd_setImageWithURL:photo.thumbnail_pic placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    // 判断下是否显示gif
    NSString *urlStr = photo.thumbnail_pic.absoluteString;
    if ([urlStr hasSuffix:@".gif"]) {
        self.gifView.hidden = NO;
    }else{
        self.gifView.hidden = YES;
    }
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.gifView.x = self.width - self.gifView.width;
    self.gifView.y = self.height - self.gifView.height;
}

@end
