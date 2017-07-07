//
//  TASearchViewController.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TASearchViewController.h"
#import "ConstColor.h"
#import "TARequestManager.h"
#import "LCProgressHUD.h"
#import "TABaseTableView.h"

@interface TASearchViewController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong)UISearchBar *searchBar;

@property (nonatomic,strong)UIButton *backBut;

@property (nonatomic,strong)UIButton *searchBut;

@property (nonatomic,strong)TABaseTableView *searchTableView;

@property (nonatomic,strong)UIView *headView;
// 历史记录
@property (nonatomic,strong)NSMutableArray *historyArr;
// 热门搜索
@property (nonatomic,strong)NSMutableArray *newsArr;

@end

@implementation TASearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
//    self.title = @"搜索";
    
    [self loadData];
    
   NSArray *array =  [[NSUserDefaults standardUserDefaults] objectForKey:@"history"];
    
    if (array.count !=0 ) {
        
        self.historyArr = [NSMutableArray arrayWithArray:array];
        
    }else {
        
        self.historyArr = [NSMutableArray arrayWithObjects:@"2016年大赛",@"道馆信息",@"个人认证流程", nil];
        
    }
    
    
    
    
//    self.newsArr = [NSMutableArray arrayWithObjects:@"北京",@"奥运会",@"冬季会",@"体操",@"健美", nil];
    
    [self  createUI];

   
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}



- (void)viewWillDisappear:(BOOL)animated {
    
    
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
}

- (void)createUI {
    
    
       [self.view addSubview:self.searchBar];
       [self.view addSubview:self.backBut];
       [self.view addSubview:self.searchBut];
    
//       [self.view addSubview:self.searchTableView];
    

  
    
}

- (UIButton *)backBut {
    
    if (_backBut == nil) {
        _backBut = [[UIButton alloc]initWithFrame:CGRectMake(18, 28, 26, 26)];
        
        [_backBut setBackgroundImage:[UIImage imageNamed:@"backitem"] forState:(UIControlStateNormal)];
        [_backBut addTarget:self action:@selector(backtouAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _backBut;
}



- (UIButton *)searchBut {
    
    if (_searchBut == nil) {
        _searchBut = [[UIButton alloc]initWithFrame:CGRectMake(KTA_Screen_Width - 53, 25, 40, 35)];
//        [_searchBut setImage:[UIImage imageNamed:@"back"] forState:(UIControlStateNormal)];
        [_searchBut setTitle:@"搜索" forState:(UIControlStateNormal)];
        [_searchBut setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        _searchBut.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [_searchBut addTarget:self action:@selector(SearchAction) forControlEvents:(UIControlEventTouchUpInside)];
    }
    return _searchBut;
}


- (UISearchBar *)searchBar {
    
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(50,23 , KTA_Screen_Width-100, 40)];
        _searchBar.delegate = self;
        _searchBar.placeholder = @"搜索你想要的";
        _searchBar.backgroundImage = [UIImage imageNamed:@"searchback"];
//        _searchBar.showsCancelButton = YES;
//        _searchBar.backgroundColor = [UIColor redColor];
       _searchBar.barTintColor = [UIColor whiteColor];
        
        UITextField *searchField=[_searchBar valueForKey:@"_searchField"];
        searchField.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.94 alpha:1.0];
    
    }
    return _searchBar;
}

- (TABaseTableView *)searchTableView {
    
    if (_searchTableView == nil) {
        _searchTableView = [[TABaseTableView alloc]initWithFrame:CGRectMake(0, 64, KTA_Screen_Width, KTA_Screen_Height-64) style:(UITableViewStylePlain)];
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        _searchTableView.tableHeaderView = self.headView;
        [_searchTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellID"];
        
        TAWeakSelf(weakSelf)
        [_searchTableView refreshHeaderRefresh:^{
            [weakSelf loadData];
        } withFooterRefreshingBlock:^{
            [weakSelf loadData];
        }];
    }
    return _searchTableView;
}

- (UIView *)headView {
    
    
        
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height-64)];
//        _headView.backgroundColor = [UIColor redColor];
        
        UIView *bottomline = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 1)];
        bottomline.backgroundColor = [ConstColor dividerColor];
        [_headView addSubview:bottomline];
        
        UILabel *historyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 10, 200, 40)];
        historyLabel.font = [UIFont systemFontOfSize:14.0];
        historyLabel.text = @"历史记录";
        [_headView addSubview:historyLabel];
        
        UIButton *deleHistory = [[UIButton alloc]initWithFrame:CGRectMake(KTA_Screen_Width-50, 10, 30, 30)];
        [deleHistory setImage:[UIImage imageNamed:@"delegate"] forState:(UIControlStateNormal)];
        
        [deleHistory addTarget:self action:@selector(deHistory) forControlEvents:(UIControlEventTouchUpInside)];
        
        [_headView addSubview:deleHistory];
        
        
        UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, KTA_Screen_Width, 1)];
        line1.backgroundColor = [ConstColor dividerColor];
        [_headView addSubview:line1];
        
        int j =  0;
        
        for (int i = 0 ; i < self.historyArr.count; i ++) {
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, 55+30*j, 200, 30)];
            label.text = self.historyArr[i];
            label.font = [UIFont systemFontOfSize:13.0];
            label.textColor = [UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0];
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(KTA_Screen_Width-50, 55+30*j, 30, 30)];
            [btn setImage:[UIImage imageNamed:@"close"] forState:(UIControlStateNormal)];
            btn.tag = 300+j;
            [btn addTarget:self action:@selector(deleIndexHis:) forControlEvents:(UIControlEventTouchUpInside)];
            
            [_headView addSubview:btn];
            
            UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 55+30*(j+1),KTA_Screen_Width, 1)];
            lineView.backgroundColor = [ConstColor dividerColor];
            [_headView addSubview:label];
            [_headView addSubview:lineView];
            j ++;
        }
        
        UILabel *newsLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 55+30*self.historyArr.count, 200, 40)];
        newsLabel.text = @"热门搜索标签";
        newsLabel.font = [UIFont systemFontOfSize:14.0];
        UIView *linee = [[UIView alloc]initWithFrame:CGRectMake(0, 55+30*self.historyArr.count+40, KTA_Screen_Width, 1)];
        [linee setBackgroundColor:[ConstColor dividerColor]];
        [_headView addSubview:linee];
        [_headView addSubview:newsLabel];
      
        CGFloat mmm = (KTA_Screen_Width-60*4)/4.0;
        for (int m = 0; m <self.newsArr.count; m ++) {
            
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(mmm/2.0 + m%4 *(60 +mmm), 55+30*self.historyArr.count+42+m/4*30, 60, 30)];
            
            button.tag = 100+m;
            button.titleLabel.font = [UIFont systemFontOfSize:14.0];
            [button setTitle:self.newsArr[m] forState:(UIControlStateNormal)];
            [button setTitleColor:[UIColor colorWithRed:0.4 green:0.4 blue:0.4 alpha:1.0] forState:(UIControlStateNormal)];
            [button addTarget:self action:@selector(newsAction:) forControlEvents:(UIControlEventTouchUpInside)];
            [_headView addSubview:button];
        }
 
    return _headView;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [self SearchAction];

}

// 删除全部历史记录
- (void)deHistory {
    
    [_headView removeFromSuperview];
    
    [self.historyArr removeAllObjects];
    
    [[NSUserDefaults standardUserDefaults] setObject:self.historyArr forKey:@"history"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    self.searchTableView.tableHeaderView = self.headView;
}
// 删除某个历史记录
- (void)deleIndexHis:(UIButton *)btn {
    
    [self.historyArr removeObjectAtIndex:(btn.tag-300)];
   
    [[NSUserDefaults standardUserDefaults] setObject:self.historyArr forKey:@"history"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    
    [_headView removeFromSuperview];

   self.searchTableView.tableHeaderView = self.headView;
    
}

- (void)backtouAction {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tureAction {
    
    if (self.searchBar.text.length > 0) {
        
        [self loadData];
    }
}
#pragma mark tableViewDelegate  

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID" forIndexPath:indexPath];

    return cell;
}

#pragma mark  网路请求
- (void)loadData {
    
    [self.newsArr removeAllObjects];
    [_headView removeFromSuperview];

    
    [TARequestManager TARequestCompletedWithPath:URL_SEARCHHOTS Parameters:nil sucee:^(NSDictionary *dic) {
        NSArray *hotArr = dic[@"Data"][@"data"];
        
        self.newsArr = [NSMutableArray arrayWithArray:hotArr];
//        NSLog(@"%@",diy);
        [self.view addSubview:self.searchTableView];
        self.searchTableView.tableHeaderView = self.headView;
    } fail:^(NSError *error) {
        
    }];
    
    [self.searchTableView endRefreshing];
    
}

#pragma mark 热门搜索标签

- (void)newsAction:(UIButton *)but {
    
    //  也进行网络请求
    NSDictionary *dic = @{@"":but.titleLabel.text};
    
    [TARequestManager TARequestCompletedWithPath:nil Parameters:dic sucee:^(NSDictionary *dic) {
        // h5
        
    } fail:^(NSError *error) {
        
    }];
    
    
}

#pragma mark   搜索
- (void)SearchAction {
    
    if (self.searchBar.text.length== 0 ) {
        
        [LCProgressHUD showTextOntarget:self.view string:@"请输入搜索内容"];
    
        return;
    }
  
    [self.historyArr addObject:self.searchBar.text];
    [[NSUserDefaults standardUserDefaults] setObject:self.historyArr forKey:@"history"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSDictionary *dic = @{@"":self.searchBar.text};
    
    [TARequestManager TARequestCompletedWithPath:nil Parameters:dic sucee:^(NSDictionary *dic) {
        // 加载h5界面
        
    } fail:^(NSError *error) {
        
    }];
    
}



@end
