//
//  MatchViewController.m
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "MatchViewController.h"
#import "IQKeyboardManager.h"
#import "MatchApplyTableViewController.h"

@interface MatchViewController ()
{
    CGRect keyBoardFrame;//键盘Frame

}

@end

@implementation MatchViewController

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:NO];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWasShownDocument:)
     
                                                 name:UIKeyboardWillShowNotification object:nil];
    
    //注册键盘消失的通知
    [[NSNotificationCenter defaultCenter] addObserver:self
     
                                             selector:@selector(keyboardWillBeHiddenDocument:)
     
                                                 name:UIKeyboardWillHideNotification object:nil];
}

//键盘通知
-(void)keyboardWasShownDocument:(NSNotification *) notif{
    keyBoardFrame = [[[notif userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    float num = [[[notif userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    if (moreBt.selected) {
//        [moreBt setSelected:!moreBt.selected];
//        [deleteView removeFromSuperview];
//    }
    if (_bottomView.tfView.isFirstResponder) {
        [UIView animateWithDuration:num animations:^{
            self.webView.frame =CGRectMake(0, 0, KTA_Screen_Width,KTA_Screen_Height-keyBoardFrame.size.height-_bottomView.frame.size.height);
            _bottomView.frame =CGRectMake(0, KTA_Screen_Height-keyBoardFrame.size.height-_bottomView.frame.size.height- TopNavigationBarHeight, _bottomView.frame.size.width,_bottomView.frame.size.height);
        }];
    }
}
-(void)keyboardWillBeHiddenDocument:(NSNotification *) notif{
    float num = [[[notif userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] floatValue];
//    if (moreBt.selected) {
//        [moreBt setSelected:!moreBt.selected];
//        [deleteView removeFromSuperview];
//    }
    //    if (sendView.sendField.isFirstResponder) {
    [UIView animateWithDuration:num animations:^{
        self.webView.frame =CGRectMake(0, 0, KTA_Screen_Width,KTA_Screen_Height-TopNavigationBarHeight-50);
        _bottomView.frame =CGRectMake(0, KTA_Screen_Height-_bottomView.frame.size.height - TopNavigationBarHeight, _bottomView.frame.size.width,_bottomView.frame.size.height);
//        _bottomView.sendField.placeholder = [NSString stringWithFormat:@"回复文章"];
    }];
    //    }
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"赛事";
    
    [self AddBottomView];
    [self loadWebUrl:@"http://p5xxdn.natappfree.cc/h5/news/newsDetailPage.html"];
    
    _bottomView = [[BottomCommentView alloc] initWithType:BottomCommentViewComment];
    [self.view addSubview:_bottomView];
    
    [self createRightBtn];
    
}
// 用于测试跳转
- (void)createRightBtn
{
    UIButton* btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    btn.frame = CGRectMake(0, 0, 40, 40);
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* item = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.rightBarButtonItem = item;
    
}

- (void)btnClick
{
    MatchApplyTableViewController* applayVC = [[MatchApplyTableViewController alloc] init];
    [self.navigationController pushViewController:applayVC animated:YES];
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
