//
//  BaseWebViewController.m
//  webviewdemo
//
//  Created by 王尉坤 on 2017/6/29.
//  Copyright © 2017年 王尉坤. All rights reserved.
//

#import "BaseWebViewController.h"

#define kDeviceWidth [UIScreen mainScreen].bounds.size.width
#define kDeviceHeight [UIScreen mainScreen].bounds.size.height

@interface BaseWebViewController ()<WKUIDelegate,WKNavigationDelegate>

@end

@implementation BaseWebViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatHeadView];
    [self creatWebView];
    
}

- (void)creatHeadView
{
    _headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kDeviceWidth, _headViewHeight)];
    _headView.backgroundColor = [UIColor redColor];
    
    [self.view addSubview:_headView];
}

- (void)creatWebView
{
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    _webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, _headViewHeight, kDeviceWidth, kDeviceHeight - _headViewHeight - 64) configuration:config];
    
    _webView.scrollView.showsVerticalScrollIndicator = NO;
    _webView.navigationDelegate = self;
    _webView.UIDelegate =self;
    
    [self.view addSubview:_webView];
}

// 加载(重载)webview页面
- (void)loadWebUrl:(NSString *)urlStr
{
    [MBProgressHUD showHUDAddedTo:_webView animated:YES];
    NSURL* url = [NSURL URLWithString:urlStr];
    [_webView loadRequest:[NSURLRequest requestWithURL:url]];
}

// 更改headview高度
- (void)changeHeadViewHeight:(CGFloat)height
{
    _headViewHeight = height;
    
    [self setHeadviewFrame];
    [self setWebViewFrame];
}

- (void)AddBottomView
{
    self.webView.frame = CGRectMake(0, _headViewHeight, kDeviceWidth, kDeviceHeight - _headViewHeight - 50 -64);
}

- (void)setHeadviewFrame
{
    _headView.frame = CGRectMake(0, 64, kDeviceWidth, _headViewHeight);
}

- (void)setWebViewFrame
{
    _webView.frame = CGRectMake(0, 64 + _headViewHeight, kDeviceWidth, kDeviceHeight - 64);
}


#pragma -mark -WKNavigationDelegate 1 2 3 4 5为调用顺序


// 接收到服务器跳转请求之后调用 (服务器端redirect)，不一定调用
- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{;
}
// 3 在收到服务器的响应头，根据response相关信息，决定是否跳转。decisionHandler必须调用，来决定是否跳转，参数WKNavigationActionPolicyCancel取消跳转，WKNavigationActionPolicyAllow允许跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler{
    decisionHandler(WKNavigationResponsePolicyAllow);
}
// 1 在发送请求之前，决定是否跳转
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{
    NSString *urlString = [[navigationAction.request URL] absoluteString];
    
    urlString = [urlString stringByRemovingPercentEncoding];
    NSLog(@"urlString=%@",urlString);
    // 用://截取字符串
    NSArray *urlComps = [urlString componentsSeparatedByString:@"://"];
    if ([urlComps count]) {
        // 获取协议头
        NSString *protocolHead = [urlComps objectAtIndex:0];
        NSString* segueParams = [urlComps lastObject];
        NSLog(@"protocolHead=%@",protocolHead);
        if ([protocolHead isEqualToString:@"http"] || [protocolHead isEqualToString:@"https"]) {
            decisionHandler(WKNavigationActionPolicyAllow);
        }
        else if ([protocolHead isEqualToString:@"test"]){
            self.segueB(segueParams);
            decisionHandler(WKNavigationActionPolicyCancel);

        }
        else{
            decisionHandler(WKNavigationActionPolicyCancel);
        }
    }else{
        decisionHandler(WKNavigationActionPolicyCancel);
    }
}
// 2 页面开始加载
- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //    //测试tool
    //    [[KuyouUtils kuyouTips] showHUDWithTitle:@"加载中" message:@"加载完成" view:self.view];
    //    //    [KuyouLog logWith:@"web加载信息",@"开始加载",@"加载成功", nil];
    //    [[KuyouUtils kuyouLog] kuyouLogWith:@"web加载信息",@"开始加载",@"加载成功", nil];
    //    [[KuyouUtils kuyouDeviceInfo] getLocalIpAddress];
    //    NSLog(@"%@",[[KuyouUtils kuyouDataBase] readPlistWithName:@"Ikuyou_config"]);
    
}
// 4 开始获取到网页内容时返回
- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
}
// 5 页面加载完成之后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    //    //创建配置类
    //    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    //
    //    config.userContentController = [[WKUserContentController alloc] init];
    //    [config.userContentController addScriptMessageHandler:self name:@"AppModel"];
    //
    //    WKPreferences *preferences = [WKPreferences new];
    //    preferences.javaScriptCanOpenWindowsAutomatically = YES;
    //    preferences.minimumFontSize = 40.0;
    //    config.preferences = preferences;
    //    [[KuyouUtils kuyouTips] removeHUD];
    
    [MBProgressHUD hideHUDForView:_webView animated:YES];
}
// 页面加载失败时调用
- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation{
    [MBProgressHUD hideHUDForView:_webView animated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
