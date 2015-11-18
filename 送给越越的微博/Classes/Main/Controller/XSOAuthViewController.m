//
//  XSOAuthViewController.m
//  送给越越的微博
//
//  Created by xiaos on 15/11/10.
//  Copyright © 2015年 com.xsdota. All rights reserved.
//

#import "XSOAuthViewController.h"
#import "XSTabBarController.h"

#import "XSNetTool.h"

#import "MBProgressHUD+Extend.h"
#import "Masonry.h"

@interface XSOAuthViewController ()<UIWebViewDelegate>

@end

@implementation XSOAuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 展示登陆的网页 -> UIWebView
    UIWebView *webView = [[UIWebView alloc] init];
    webView.delegate = self;
    [self.view addSubview:webView];
    [webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(20);
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view.mas_right);
    }];
    
    NSString *baseUrl      = @"https://api.weibo.com/oauth2/authorize";
    NSString *client_id    = @"529280005";
    NSString *redirect_uri = @"http://www.xsdota.com";
    NSString *urlStr = [NSString stringWithFormat:@"%@?client_id=%@&redirect_uri=%@",baseUrl,client_id,redirect_uri];
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}

#pragma mark -UIWebView代理
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    // 提示用户正在加载...
    [MBProgressHUD showMessage:@"正在加载..."];
}

// webview加载完成的时候调用
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideHUD];
}

//  webview加载失败的时候调用
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [MBProgressHUD hideHUD];
    [MBProgressHUD showError:@"连接失败"];
}

// 拦截webView请求
// 当Webview需要加载一个请求的时候，就会调用这个方法，询问下是否请求
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *urlStr = request.URL.absoluteString;
    // 获取code(RequestToken)
    NSRange range = [urlStr rangeOfString:@"code="];
    if (range.length)
    {
        NSString *code = [urlStr substringFromIndex:range.location + range.length];
        // 换取accessToken
        [self accessTokenWithCode:code];
        return NO;
    }
    
    return YES;
}

#pragma mark - 获取accessToken
- (void)accessTokenWithCode:(NSString *)code
{
    [XSNetTool netOAuthWithCode:code success:^() {
        XSKeyWindow.rootViewController = [[XSTabBarController alloc] init];
    } failure:^(NSError *error) {
        XSLog(@"%@",error);
    }];
}

@end
