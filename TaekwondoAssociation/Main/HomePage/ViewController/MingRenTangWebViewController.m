//
//  MingRenTangWebViewController.m
//  TaekwondoAssociation
//
//  Created by 李瑞平 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "MingRenTangWebViewController.h"
#import "TABaseTableView.h"
#import "MingRenTangListTableViewCell.h"
#import "TARequestManager.h"
#import "UIImageView+WebCache.h"
#import "SearchResultViewController.h"

@interface MingRenTangWebViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableDictionary *dataDic;
    NSMutableArray*                         _searchResultArray;
    SearchResultViewController*              _resultViewController;
    UISearchController*                     _searchController;
}
@property (nonatomic ,strong)TABaseTableView *tableView;
//@property (nonatomic,strong)UIButton *searchBtn;
@end

@implementation MingRenTangWebViewController
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"名人堂";
        _searchResultArray = [NSMutableArray array];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.tableView];
    [self searchErrand];
//    [self.view addSubview:self.searchBtn];
    
    [self getMingRenTangListData];
    
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.tabBarController.tabBar.hidden = NO;
}
- (void)searchErrand
{
    
    _resultViewController = [[SearchResultViewController alloc]init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_resultViewController];
    _searchController.searchBar.backgroundImage = [UIImage imageNamed:@"searchBarBackgroud"];
    _searchController.searchBar.placeholder = @"搜索姓名";
//    _searchController.searchBar.barTintColor = [UIColor whiteColor];
    UITextField *searchField=[_searchController.searchBar valueForKey:@"_searchField"];
    searchField.backgroundColor = RGB(235, 236, 238);
    _searchController.searchBar.delegate = self;
    _resultViewController.tableView.dataSource = self;
    _resultViewController.tableView.delegate = self;
    _resultViewController.dataArray = _searchResultArray;
    _searchController.searchBar.frame = CGRectMake(0, 0, 0, 44);
    _searchController.active = NO;
    _searchController.dimsBackgroundDuringPresentation = YES;
    self.definesPresentationContext = YES;
    _tableView.tableHeaderView = _searchController.searchBar;
    _resultViewController.tableView.rowHeight = 44;
}

- (TABaseTableView *)tableView {
    
    if (_tableView == nil) {
        _tableView = [[TABaseTableView alloc]initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height) style:(UITableViewStylePlain)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 60;
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor clearColor];
        [_tableView setTableFooterView:view];
        
    }
    return _tableView;
}
- (void)getMingRenTangListData
{
    [MBProgressHUD showHUDAddedTo:_tableView animated:YES];
    
    [TARequestManager TARequestCompletedWithPath:@"/Home/FameList" Parameters:nil sucee:^(NSDictionary *dic) {
        // 解析数据
        NSLog(@"----------%@",dic);
        [MBProgressHUD hideHUDForView:_tableView animated:YES];
        dataDic = [dic[@"Data"][@"Data"] mutableCopy];
        [_tableView reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:_tableView animated:YES];
    }];
}
#pragma mark - UItableViewDelegateDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray *tqxArr;
    if (section == 0) {
        tqxArr = dataDic[@"TQXList"];
        
    }
    else
    {
        tqxArr = dataDic[@"DSJTlist"];
    }
    return tqxArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MingRenTangListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"identifer"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"MingRenTangListTableViewCell" owner:self options:nil] lastObject];
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.selectionStyle = UITableViewCellAccessoryNone;
    }
    NSArray *tqxArr;
    if (indexPath.section == 0) {
        tqxArr = dataDic[@"TQXList"];
        
    }
    else
    {
        tqxArr = dataDic[@"DSJTlist"];
    }
    NSString *imageStr = [NSString stringWithFormat:@"%@%@",URL_BASE,tqxArr[indexPath.row][@"FamePic"]];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@""]];
    cell.titleLabel.text = tqxArr[indexPath.row][@"FameName"];
    cell.detailLabel.text = tqxArr[indexPath.row][@"FameContent"];
    cell.detailLabel.textColor = RGB(156, 158, 159);
    return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bigView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 30)];
    bigView.backgroundColor = RGB(245, 245, 245);
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 5, 5, 20)];
    lineView.backgroundColor = RGB(54, 130, 240);
    [bigView addSubview:lineView];
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(12, 5, 100, 20)];
    textLabel.font = [UIFont systemFontOfSize:16];
    if (section == 0) {
        textLabel.text = @"跆拳星";
    }
    else
    {
        textLabel.text = @"大师讲堂";
    }
    [bigView addSubview:textLabel];
    return bigView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
#pragma mark - UISearchBar and UISearchDisplayController Delegate Methods
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
//    [_tableView.mj_header endRefreshing];
//    [_tableview.mj_footer endRefreshing];
//    [_resultViewController.tableView.mj_footer endRefreshing];
    _tableView.frame = CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height);
    [self setAutomaticallyAdjustsScrollViewInsets:NO];
    [self setExtendedLayoutIncludesOpaqueBars:NO];
    //    [_resultViewController reloadData];
    return YES;
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [_searchResultArray removeAllObjects];
//    isSearchAleardySpCx = NO;
    //    [_resultViewController reloadData];
    _tableView.frame = CGRectMake(0, 48, KTA_Screen_Width, KTA_Screen_Height-48);
//    [_resultViewController.tableView.mj_footer endRefreshing];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchResultArray removeAllObjects];
//    [self syncSearchErrandList:nil];
//    [self addSearchFooter];
}
- (void)searchBtnClick
{
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
