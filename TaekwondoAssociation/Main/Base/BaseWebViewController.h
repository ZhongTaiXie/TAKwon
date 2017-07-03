//
//  BaseWebViewController.h
//  webviewdemo
//
//  Created by 王尉坤 on 2017/6/29.
//  Copyright © 2017年 王尉坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "TABaseViewController.h"

typedef void (^segueBlock)(NSString* segueParams);


@interface BaseWebViewController : TABaseViewController

@property (nonatomic, strong) WKWebView* webView;

@property (nonatomic, strong) NSString* webUrl;

// 预留头视图(子视图都加在上面)
@property (nonatomic, strong) UIView* headView;
// 头视图高度
@property (nonatomic, assign) CGFloat headViewHeight;
// h5页面点击事件的跳转参数回调
@property (strong, nonatomic) segueBlock segueB;


// 加载(重载)webview页面
- (void)loadWebUrl:(NSString *)urlStr;

// 更改头视图高度(头视图高度改变时调用传入高度,初始为0)
- (void)changeHeadViewHeight:(CGFloat)height;



@end
