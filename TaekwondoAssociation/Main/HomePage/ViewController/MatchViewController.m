//
//  MatchViewController.m
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "MatchViewController.h"

@interface MatchViewController ()

@end

@implementation MatchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = @"赛事";
    
    [self AddBottomView];
    [self loadWebUrl:@"http://p5xxdn.natappfree.cc/h5/news/newsDetailPage.html"];
    
    _bottomView = [[BottomCommentView alloc] initWithType:BottomCommentViewComment];
    [self.view addSubview:_bottomView];

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
