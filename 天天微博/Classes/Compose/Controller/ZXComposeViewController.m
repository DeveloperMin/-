//
//  ZXComposeViewController.m
//  天天微博
//
//  Created by zxopen06 on 15/10/25.
//  Copyright © 2015年 zxopen06. All rights reserved.
//

#import "ZXComposeViewController.h"

#import "ZXTextView.h"
#import "ZXTextToolBar.h"
#import "ZXComposePhotoView.h"

#import "ZXComposeTool.h"

#import "MBProgressHUD+MJ.h"


@interface ZXComposeViewController ()<UITextViewDelegate, ZXTextToolBarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) ZXTextView *textView;
@property (nonatomic, weak) ZXTextToolBar *toolBar;
@property (nonatomic, weak) ZXComposePhotoView *composePhotoView;
@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) NSMutableArray *images;

@end

@implementation ZXComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];
    //设置导航条
    [self setUpNavigationBar];
    
    //设置TextView
    [self setUpTextView];
    
    //添加工具条
    [self setUpToolBar];
    
    //监听键盘的弹出
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(toolBarFrameChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    //添加photoView视图
    [self setUpPhotoView];
    
}
- (NSMutableArray *)images
{
    if (_images == nil) {
        _images = [NSMutableArray array];
    }
    return _images;
}
- (void)setUpPhotoView
{
    ZXComposePhotoView *composeView = [[ZXComposePhotoView alloc] initWithFrame:CGRectMake(0, 80, self.view.width, self.view.height - 80)];
    _composePhotoView = composeView;
    
    [_textView addSubview:composeView];
}
- (void)toolBarFrameChange:(NSNotification *)note
{
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] floatValue];
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    if (frame.origin.y == self.view.height) { //没有弹出键盘
        
        [UIView animateWithDuration:duration animations:^{
            self.toolBar.transform = CGAffineTransformIdentity;
        }];
    }else
    {
        [UIView animateWithDuration:duration animations:^{
            self.toolBar.transform = CGAffineTransformMakeTranslation(0, -frame.size.height);
        }];
    }
    
}
- (void)setUpToolBar
{
    CGFloat h = 35;
    CGFloat y = self.view.height - h;
    
    ZXTextToolBar *toolBar = [[ZXTextToolBar alloc] initWithFrame:CGRectMake(0, y, self.view.width, h)];
    _toolBar = toolBar;
    toolBar.delegate = self;
    
    [self.view addSubview:toolBar];
}
- (void)setUpTextView
{
    ZXTextView *textView = [[ZXTextView alloc] initWithFrame:self.view.bounds];
    _textView = textView;
    textView.delegate = self;
    
    //设置占位符
    textView.font = [UIFont systemFontOfSize:18];
    textView.placeHolder = @"分享新鲜事...";
    
    //默认允许拖拽
    textView.alwaysBounceVertical = YES;
    
    // 监听文本框的输入
    /**
     *  Observer:谁需要监听通知
     *  name：监听的通知的名称
     *  object：监听谁发送的通知，nil:表示谁发送我都监听
     *
     */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChange) name:UITextViewTextDidChangeNotification object:nil];
    
    [self.view addSubview:textView];
    
    
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [_textView becomeFirstResponder];
}
- (void)textChange
{
    //判断textView是否有内容
    if (_textView.text.length) {//有内容
        _textView.hidenPlaceHolder = YES;
        _rightItem.enabled = YES;
    }else
    {
        _textView.hidenPlaceHolder = NO;
        _rightItem.enabled = NO;
    }
}
#pragma mark 点击toolBar的时候调用
- (void)composeToolBar:(ZXTextToolBar *)toolBar didClickBtn:(NSUInteger)index
{
    if (index == 0) {
        //弹出系统相册
        UIImagePickerController *pickVc = [[UIImagePickerController alloc] init];
        
        //设置相册类型
        pickVc.sourceType =  UIImagePickerControllerSourceTypeSavedPhotosAlbum;
        
        //设置代理
        pickVc.delegate = self;
        
        [self presentViewController:pickVc animated:YES completion:nil];
    }
}
#pragma mark 点击相册图片的时候调用
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    _composePhotoView.image=image;
    
    [self.images addObject:image];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    _rightItem .enabled = YES;
}
#pragma mark - 开始拖拽的时候调用
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)setUpNavigationBar
{
    self.title = @"发微博";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(dismiss)];
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"发送" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [btn sizeToFit];
    [btn addTarget:self action:@selector(compose) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    rightItem.enabled = NO;
    self.navigationItem.rightBarButtonItem = rightItem;
    _rightItem = rightItem;
}

//发微博
- (void)compose
{
    _rightItem.enabled = NO;
    
    //发送图片
    if (self.images.count) {
        [self sendPhoto];
    }else{
        //发送文字
        [self sendTitle];
    }
    
}
- (void)sendPhoto
{
    UIImage *image = [self.images lastObject];
    [ZXComposeTool composeStatusWithText:_textView.text image:image success:^{
        //提示用用户
        [MBProgressHUD showSuccess:@"发送成功"];
        
        //返回主页
        [self dismissViewControllerAnimated:YES completion:nil];
    } failure:^(NSError *error) {
         [MBProgressHUD showError:@"发送失败"];
    }];
}
- (void)sendTitle
{
    [ZXComposeTool composeStatusWithText:_textView.text success:^{
        
        //提示用用户
        [MBProgressHUD showSuccess:@"发送成功"];
        
        //返回主页
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } failure:^(NSError *error) {
        
        [MBProgressHUD showError:@"发送失败"];
    }];
}

- (void)dismiss
{
    [self.view endEditing:YES];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}




@end
