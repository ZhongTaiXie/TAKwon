//
//  BaseWebViewController.h
//  webviewdemo
//
//  Created by 王尉坤 on 2017/6/29.
//  Copyright © 2017年 王尉坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>

@interface BaseWebViewController : UIViewController

@property (nonatomic, strong) WKWebView* webView;
@property (nonatomic, strong) UIView* headView;
// 头视图高度
@property (nonatomic, assign) CGFloat headViewHeight;

@property (nonatomic, strong) NSString* webUrl;

// 加载(重载)webview页面
- (void)loadWebUrl:(NSString *)urlStr;

@end
