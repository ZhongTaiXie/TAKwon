//
//  TASearchViewController.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TASearchViewController.h"

@interface TASearchViewController ()<UISearchBarDelegate>

@property (nonatomic,strong)UISearchBar *searchBar;

@end

@implementation TASearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    self.title = @"搜索";
    
    [self  createUI];
   
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    
    [super viewDidDisappear:animated];
}

- (void)createUI {
    
    [self.view addSubview:self.searchBar];
  
    
}

- (UISearchBar *)searchBar {
    
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(50,10 , KTA_Screen_Width-100, 40)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索你想要的";
        _searchBar.showsCancelButton = YES;
    
    }
    return _searchBar;
}



@end
