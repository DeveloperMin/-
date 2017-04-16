//
//  ZXOriginalView.m
//  天天微博
//
//  Created by zxopen06 on 15/10/23.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXOriginalView.h"

#import "ZXStatusFrame.h"
#import "ZXStatus.h"
#import "ZXUser.h"

#import "ZXPhotosView.h"

#import "UIImageView+WebCache.h"

@interface ZXOriginalView ()

//头像
@property (nonatomic, weak) UIImageView *iconView;

//昵称
@property (nonatomic, weak) UILabel *nameView ;

//Vip
@property (nonatomic, weak) UIImageView *vipView ;

//时间
@property (nonatomic, weak) UILabel *timeView ;

//来源
@property (nonatomic, weak) UILabel *sourceView ;

//正文
@property (nonatomic, weak) UILabel *textView ;

//配图
@property (nonatomic, weak) ZXPhotosView *photosView ;
@end


@implementation ZXOriginalView


- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加所有子控件
        [self setUpAllChild];
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_top_background"];
        
    }
    return self;
}

- (void)setUpAllChild
{
    //头像
    UIImageView *iconView = [[UIImageView alloc] init];
    [self addSubview:iconView];
    self.iconView = iconView;
    
    //昵称
    UILabel *nameView = [[UILabel alloc] init];
    [self addSubview:nameView];
    
    nameView.font = ZXStatusNameFront;
    self.nameView = nameView;
    
    //Vip
    UIImageView *vipView = [[UIImageView alloc] init];
    [self addSubview:vipView];
    self.vipView = vipView;
    
    //时间
    UILabel *timeView = [[UILabel alloc] init];
    [self addSubview:timeView];
    timeView.textColor = [UIColor orangeColor];
    timeView.font = ZXStatusTimeFront;
    self.timeView = timeView;
    
    //来源
    UILabel *sourceView = [[UILabel alloc] init];
    sourceView.font = ZXSourceFront;
    sourceView.textColor = [UIColor lightGrayColor];
    [self addSubview:sourceView];
    _sourceView = sourceView;
    
    //正文
    UILabel *textView = [[UILabel alloc] init];
    [self addSubview:textView];
    textView.font = ZXStatusTextFront;
    textView.numberOfLines = 0;
    self.textView = textView;
    
    //配图
    ZXPhotosView *photosView = [[ZXPhotosView alloc] init];
    [self addSubview:photosView];
    self.photosView = photosView;
}
- (void)setStatusFrame:(ZXStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    
    //设置frame
    [self setUpFrame];
    //赋值
    [self setUpData];
}
#pragma mark 设置frame
- (void)setUpFrame
{
    //头像
    self.iconView.frame = _statusFrame.originalIconFrame;
    
    //昵称
    self.nameView.frame = _statusFrame.originalNameFrame;
    
    //vip
    if (_statusFrame.status.user.vip) { //是会员
        self.vipView.frame = _statusFrame.originalVipFrame;
        self.vipView.hidden = NO;
    }else
    {
        self.vipView.hidden = YES;
    }
    
    //时间
    
    ZXStatus *status = _statusFrame.status;
    
    CGFloat timeX = _nameView.frame.origin.x;
    CGFloat timeY = CGRectGetMaxY(self.nameView.frame) + 5;
    CGSize timeSize = [status.created_at sizeWithFont:ZXStatusTimeFront];
    self.timeView.frame = (CGRect){{timeX, timeY}, timeSize};
    
    //来源
    CGFloat sourceX = CGRectGetMaxX(self.timeView.frame) + ZXStatusCellMargin;
    CGFloat sourceY = timeY;
    CGSize sourceSize = [status.source sizeWithFont:ZXSourceFront];
    self.sourceView.frame = (CGRect){{sourceX, sourceY}, sourceSize};
   
    
    //正文
    self.textView.frame = _statusFrame.originalTextFrame;
    
    //配图
    self.photosView.frame = _statusFrame.originalPhotoFrame;
   
    
}
#pragma mark 赋值
- (void)setUpData
{
    ZXStatus *status = _statusFrame.status;
    
    //头像
    [self.iconView sd_setImageWithURL:status.user.profile_image_url placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
    //昵称
    if (self.statusFrame.status.user.vip) {
        _nameView.textColor = [UIColor redColor];
    }else
    {
        _nameView.textColor = [UIColor blackColor];
    }
    self.nameView.text = status.user.name;
    
    //vip
    
    NSString *imageName = [NSString stringWithFormat:@"common_icon_membership_level%d", status.user.mbrank];
    self.vipView.image = [UIImage imageNamed:imageName];
    
    
    //时间
    self.timeView.text = status.created_at;
    
    //来源
    self.sourceView.text = status.source;
    
    //正文
    self.textView.text = status.text;
    
    //配图
    self.photosView.pic_urls = status.pic_urls;
    
}


@end
