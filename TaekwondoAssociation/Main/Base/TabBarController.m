//
//  TabBarController.m
//  TaekwondoAssociation
//
//  Created by 李瑞平 on 2017/6/26.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TabBarController.h"
#import "TAHomePageViewController.h"

#import "TATaekwondoHallViewController.h"
#import "TAPersonalMemberCenterViewController.h"
#import "TATaekwondoMemberCenterViewController.h"
#import "TATaekwondoMemberCenterViewController.h"

@interface TabBarController ()

@end

@implementation TabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //添加所需的子控制器
    [self addChildViewControllers];
    
}
//添加子控制器
-(void)addChildViewControllers{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    [self.tabBar setBarTintColor:[UIColor whiteColor]];//设置背景颜色
    [self setupChildVc:[TAHomePageViewController new] title:@"首页" image:@"tabbar_home_noSelect" selectedImage:@"tabbar_home_select"];
    [self setupChildVc:[TATaekwondoHallViewController new] title:@"道馆" image:@"tabbar_taekwondo_noSelect" selectedImage:@"tabbar_taekwondo_select"];
    
    int a = 1; //用于测试
    if(a == 1){  //个人
        [self setupChildVc:[TAPersonalMemberCenterViewController new] title:@"会员中心" image:@"tabbar_memberCenter_noSelect" selectedImage:@"tabbar_memberCenter_select"];
    }else{
        [self setupChildVc:[TATaekwondoMemberCenterViewController new] title:@"会员中心" image:@"tabbar_memberCenter_noSelect" selectedImage:@"tabbar_memberCenter_select"];
    }
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [WQTools colorWithHexString:@"7a7e83"];
    
    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSFontAttributeName] = attrs[NSFontAttributeName];
    selectedAttrs[NSForegroundColorAttributeName] = MAINCOLOR;
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

//初始化子控制器
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage{
    // 设置文字和图片
    vc.navigationItem.title = title;
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [[UIImage imageNamed:image] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    //    [nav.navigationBar setBackgroundImage:[UIImage imageNamed:@"sunselected"] forBarMetrics:UIBarMetricsDefault];
    //导航栏上面的字设置为白色
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    //设置导航栏背景图片
    UINavigationBar *navigationBar = nav.navigationBar;
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"nav_bg"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [navigationBar setShadowImage:[UIImage new]];
    
    
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
    [self addChildViewController:nav];
}


@end
