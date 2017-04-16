//
//  ZXTextView.m
//  天天微博
//
//  Created by zxopen06 on 15/10/26.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXTextView.h"


@interface ZXTextView ()

@property (nonatomic, weak) UILabel *placeHolderLabel;

@end
@implementation ZXTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.font = [UIFont systemFontOfSize:13];
        
    }
    return self;
}

- (UILabel *)placeHolderLabel
{
    if (_placeHolderLabel == nil) {
        UILabel *label = [[UILabel alloc] init];
        
        [self addSubview:label];
        
        _placeHolderLabel  = label;
    }
    return _placeHolderLabel;
}
- (void)setFont:(UIFont *)font
{
    [super setFont:font];
    
    self.placeHolderLabel.font = font;
    
}
- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)setPlaceHolder:(NSString *)placeHolder
{
    _placeHolder = placeHolder;
    
    self.placeHolderLabel.text = placeHolder;
    [self.placeHolderLabel sizeToFit];
}
- (void)setHidenPlaceHolder:(BOOL)hidenPlaceHolder
{
    _hidenPlaceHolder = hidenPlaceHolder;
    
    self.placeHolderLabel.hidden = hidenPlaceHolder;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.placeHolderLabel.x = 5;
    self.placeHolderLabel.y = 8;
}


@end
