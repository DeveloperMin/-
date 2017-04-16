//
//  ZXStatusToolBar.m
//  天天微博
//
//  Created by zxopen06 on 15/10/23.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXStatusToolBar.h"

#import "ZXStatus.h"

@interface ZXStatusToolBar ()
/**
 *  按钮
 */
@property (nonatomic, strong) NSMutableArray *buttons;
/**
 *  间隔线
 */
@property (nonatomic, strong) NSMutableArray *devides;

@property (nonatomic, strong) UIButton *reweet;
@property (nonatomic, strong) UIButton *commebt;
@property (nonatomic, strong) UIButton *unlike;
@end

@implementation ZXStatusToolBar

- (NSMutableArray *)buttons
{
    if (_buttons == nil) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (NSMutableArray *)devides
{
    if (_devides == nil) {
        _devides = [NSMutableArray array];
    }
    return _devides;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加所有子控件
        [self setUpAllChild];
        
        self.userInteractionEnabled = YES;
        self.image = [UIImage imageWithStretchableName:@"timeline_card_bottom_background"];
        
    }
    return self;
}

- (void)setUpAllChild
{
    //转发
    UIButton *reweet = [self setUpOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_retweet"] Title:@"转发"];
    _reweet = reweet;
    
    //评论
    UIButton *commebt = [self setUpOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_comment"] Title:@"评论"];
    _commebt = commebt;
    
    //赞
    UIButton *unlike = [self setUpOneButtonWithImage:[UIImage imageNamed:@"timeline_icon_unlike"] Title:@"赞"];
    _unlike = unlike;
    
    //分割线
    for(int i = 0 ; i < 2; i++)
    {
        UIImageView *devide = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"timeline_card_bottom_line"]];
        [self addSubview:devide];
        
        [self.devides addObject:devide];
    }
}

- (UIButton *)setUpOneButtonWithImage:(UIImage *)image Title:(NSString *)title
{
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setImage:image forState:UIControlStateNormal];
    
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
    
    [self addSubview:btn];
    [self.buttons addObject:btn];
    
    return btn;
}

- (void)layoutSubviews
{
    CGFloat x = 0;
    NSUInteger count = self.buttons.count;
    
    CGFloat y = 0;
    CGFloat w = ZXScreenW /count;
    CGFloat h = self.height;
    for (int i = 0; i < count; i++) {
        
        UIButton *btn = self.buttons[i];
        x = w * i;
        btn.frame = CGRectMake(x, y, w, h);
        
    }
    int i= 1;
    for (UIImageView *devide in self.devides) {
        UIButton *btn = self.buttons[i];
        
        devide.x = btn.x;
        i ++;
    }
}

- (void)setStatus:(ZXStatus *)status
{
    _status = status;
    
    //设置微博转发数
    [self setButton:_reweet withTilte:status.reposts_count];
    
    //设置评论数
    [self setButton:_commebt withTilte:status.comments_count];
    
    //设置赞数
    [self setButton:_unlike withTilte:status.attitudes_count];
}
- (void)setButton:(UIButton *)btn withTilte:(int)count
{
    NSString *title = nil;
    if (count) {
        if (count > 10000) {
            CGFloat floatCount = count/10000.0;
            title = [NSString stringWithFormat:@"%.1fW", floatCount];
            title = [title stringByReplacingOccurrencesOfString:@".0" withString:@""];
        }else
        {
            title = [NSString stringWithFormat:@"%d", count];
        }
        [btn setTitle:title forState:UIControlStateNormal];
    }
}


@end
