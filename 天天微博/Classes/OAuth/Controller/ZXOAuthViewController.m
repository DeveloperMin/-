//
//  ZXOAuthViewController.m
//  天天微博
//
//  Created by zxopen06 on 15/10/21.
//  Copyright © 2015年 zxopen06. All rights reserved.
//https://api.weibo.com/oauth2/access_token?client_id=1896394484&client_secret=97263b3b64afafa6e748e343ac554d02&grant_type=authorization_code&code=b49fc69b73a2b245474df788dc6f6e79&redirect_uri=http://www.baidu.com
//https://api.weibo.com/oauth2/access_token?

#import "ZXOAuthViewController.h"

#import "MBProgressHUD+MJ.h"
#import "AFNetworking.h"
#import "ZXAccount.h"
#import "ZXAccountTool.h"
#import "ZXRootTool.h"

#define ZXClient_id     @"1896394484"
#define ZXRedirect_uri  @"http://www.baidu.com"
#define ZXClient_secret @"97263b3b64afafa6e748e343ac554d02"

@interface ZXOAuthViewController ()<UIWebViewDelegate>

@end

@implementation ZXOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //加载网页
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    
    //拼接url
    NSString *baseStr = @"https://api.weibo.com/oauth2/authorize";
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseStr,ZXClient_id,ZXRedirect_uri];
    NSLog(@"%@", urlStr);

    //创建url
    NSURL *url = [NSURL URLWithString:urlStr];
    
    //创建请求
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    //加载数据
    [webView loadRequest:request];
    //设置代理
    webView.delegate = self;
}

//开始加载
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    //提醒用户正在加载
    [MBProgressHUD showMessage:@"正在加载..."];
}
//加载完成
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    //隐藏加载条
    [MBProgressHUD hideHUD];
}
//加载失败
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    //隐藏加载条
    [MBProgressHUD hideHUD];
}
//当webView加载一个请求的时候会调用此方法
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSLog(@"%@", request.URL.absoluteString);
    
    NSString *urlStr = request.URL.absoluteString;
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length) {
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        NSLog(@"%@", code);
        //换去access_token
        [self accessToToken:code];
        return NO;
    }
    return YES;
}
- (void)accessToToken:(NSString *)code
{
    //获取accesstoken
    [ZXAccountTool accountWithCode:code success:^{
        //进入主页或新特性,选择主窗口
        [ZXRootTool chooseRootViewController:ZXKeyWindow];
    } failure:^{
        
    }];
  
}




@end
