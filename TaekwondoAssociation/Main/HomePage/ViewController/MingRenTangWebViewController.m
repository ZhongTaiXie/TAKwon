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
#import "MingRenTangDetailViewController.h"

@interface MingRenTangWebViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>
{
    NSMutableDictionary *dataDic;
    NSMutableDictionary *searchDataDic;
    NSMutableArray*                         _searchResultArray;
    SearchResultViewController*              _resultViewController;
    UISearchController*                     _searchController;
}
@property (nonatomic ,strong)TABaseTableView *tableView;
//@property (nonatomic,strong)UIButton *searchBtn;
@end

@implementation MingRenTangWebViewController
#pragma mark - lifeCircle
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
    [self getMingRenTangListData];
    
}
#pragma mark - 初始化控件
- (void)searchErrand
{
    _resultViewController = [[SearchResultViewController alloc]init];
    _searchController = [[UISearchController alloc] initWithSearchResultsController:_resultViewController];
    _searchController.searchBar.backgroundImage = [UIImage imageNamed:@"searchback"];
    _searchController.searchBar.placeholder = @"搜索姓名";
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
    _resultViewController.tableView.rowHeight = 60;
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
    if (tableView == _resultViewController.tableView){
        if (searchDataDic[@"TQXList"] != nil && [searchDataDic[@"TQXList"] count] != 0) {
            if (searchDataDic[@"DSJTlist"] != nil && [searchDataDic[@"DSJTlist"] count] != 0) {
                return 2;
            }
            else
            {
                return 1;
            }
            
        }
        else
        {
            if (searchDataDic[@"DSJTlist"] != nil && [searchDataDic[@"DSJTlist"] count] != 0) {
                return 1;
            }
            else
            {
                return 0;
            }
        }
    }
    else
    {
        if (dataDic[@"TQXList"] != nil && [dataDic[@"TQXList"] count] != 0) {
            if (dataDic[@"DSJTlist"] != nil && [dataDic[@"DSJTlist"] count] != 0) {
                return 2;
            }
            else
            {
                return 1;
            }
            
        }
        else
        {
            if (dataDic[@"DSJTlist"] != nil && [dataDic[@"DSJTlist"] count] != 0) {
                return 1;
            }
            else
            {
                return 0;
            }
        }
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == _resultViewController.tableView){
        if (searchDataDic[@"TQXList"] != nil && [searchDataDic[@"TQXList"] count] != 0) {
            if (searchDataDic[@"DSJTlist"] != nil && [searchDataDic[@"DSJTlist"] count] != 0) {
                if (section == 0) {
                    return [searchDataDic[@"TQXList"] count];
                }
                else
                {
                    return [searchDataDic[@"DSJTlist"] count];
                }
            }
            else
            {
                return [searchDataDic[@"TQXList"] count];
            }
            
        }
        else
        {
            if (searchDataDic[@"DSJTlist"] != nil && [searchDataDic[@"DSJTlist"] count] != 0) {
                return [searchDataDic[@"DSJTlist"] count];
            }
            else
            {
                return 0;
            }
        }
    }
    else
    {
        if (dataDic[@"TQXList"] != nil && [dataDic[@"TQXList"] count] != 0) {
            if (dataDic[@"DSJTlist"] != nil && [dataDic[@"DSJTlist"] count] != 0) {
                if (section == 0) {
                    return [dataDic[@"TQXList"] count];
                }
                else
                {
                    return [dataDic[@"DSJTlist"] count];
                }
            }
            else
            {
                return [dataDic[@"TQXList"] count];
            }
            
        }
        else
        {
            if (dataDic[@"DSJTlist"] != nil && [dataDic[@"DSJTlist"] count] != 0) {
                return [dataDic[@"DSJTlist"] count];
            }
            else
            {
                return 0;
            }
        }
    }
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
    if (tableView == _resultViewController.tableView){
        if (searchDataDic[@"TQXList"] != nil && [searchDataDic[@"TQXList"] count] != 0) {
            if (searchDataDic[@"DSJTlist"] != nil && [searchDataDic[@"DSJTlist"] count] != 0) {
                if (indexPath.section == 0) {
                    tqxArr = searchDataDic[@"TQXList"];
                    
                }
                else
                {
                    tqxArr = searchDataDic[@"DSJTlist"];
                }
            }
            else
            {
                tqxArr = searchDataDic[@"TQXList"];
            }
        }
        else
        {
            if (searchDataDic[@"DSJTlist"] != nil && [searchDataDic[@"DSJTlist"] count] != 0) {
                tqxArr = searchDataDic[@"DSJTlist"];
            }
        }
    }
    else
    {
        if (dataDic[@"TQXList"] != nil && [dataDic[@"TQXList"] count] != 0) {
            if (dataDic[@"DSJTlist"] != nil && [dataDic[@"DSJTlist"] count] != 0) {
                if (indexPath.section == 0) {
                    tqxArr = dataDic[@"TQXList"];
                    
                }
                else
                {
                    tqxArr = dataDic[@"DSJTlist"];
                }
            }
            else
            {
                tqxArr = dataDic[@"TQXList"];
            }
            
        }
        else
        {
            if (dataDic[@"DSJTlist"] != nil && [dataDic[@"DSJTlist"] count] != 0) {
                tqxArr = dataDic[@"DSJTlist"];
            }
        }
    }
    
    NSString *imageStr = [NSString stringWithFormat:@"%@%@",URL_BASE,tqxArr[indexPath.row][@"FamePic"]];
    [cell.headImage sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@""]];
    cell.titleLabel.text = tqxArr[indexPath.row][@"FameName"];
    cell.detailLabel.text = tqxArr[indexPath.row][@"FameContent"];
    cell.detailLabel.textColor = RGB(156, 158, 159);
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MingRenTangDetailViewController *detailVC = [[MingRenTangDetailViewController alloc]init];
    NSArray *tqxArr;
    if (tableView == _resultViewController.tableView){
        if (searchDataDic[@"TQXList"] != nil && [searchDataDic[@"TQXList"] count] != 0) {
            if (searchDataDic[@"DSJTlist"] != nil && [searchDataDic[@"DSJTlist"] count] != 0) {
                if (indexPath.section == 0) {
                    tqxArr = searchDataDic[@"TQXList"];
                }
                else
                {
                    tqxArr = searchDataDic[@"DSJTlist"];
                }
            }
            else
            {
                tqxArr = searchDataDic[@"TQXList"];
            }
        }
        else
        {
            if (searchDataDic[@"DSJTlist"] != nil && [searchDataDic[@"DSJTlist"] count] != 0) {
                tqxArr = searchDataDic[@"DSJTlist"];
            }
        }
    }
    else
    {
        if (dataDic[@"TQXList"] != nil && [dataDic[@"TQXList"] count] != 0) {
            if (dataDic[@"DSJTlist"] != nil && [dataDic[@"DSJTlist"] count] != 0) {
                if (indexPath.section == 0) {
                    tqxArr = dataDic[@"TQXList"];
                    
                }
                else
                {
                    tqxArr = dataDic[@"DSJTlist"];
                }
            }
            else
            {
                tqxArr = dataDic[@"TQXList"];
            }
            
        }
        else
        {
            if (dataDic[@"DSJTlist"] != nil && [dataDic[@"DSJTlist"] count] != 0) {
                tqxArr = dataDic[@"DSJTlist"];
            }
        }
    }
    detailVC.dataDic = tqxArr[indexPath.row];
    [self.navigationController pushViewController:detailVC animated:YES];
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
    
    
    if (tableView == _resultViewController.tableView){
        if (searchDataDic[@"TQXList"] != nil && [searchDataDic[@"TQXList"] count] != 0) {
            if (searchDataDic[@"DSJTlist"] != nil && [searchDataDic[@"DSJTlist"] count] != 0) {
                if (section == 0) {
                    textLabel.text = @"跆拳星";
                    
                }
                else
                {
                    textLabel.text = @"大师讲堂";
                }
            }
            else
            {
                textLabel.text = @"跆拳星";
            }
        }
        else
        {
            if (searchDataDic[@"DSJTlist"] != nil && [searchDataDic[@"DSJTlist"] count] != 0) {
               textLabel.text = @"大师讲堂";
            }
        }
    }
    else
    {
        if (section == 0) {
            textLabel.text = @"跆拳星";
        }
        else
        {
            textLabel.text = @"大师讲堂";
        }
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
    _tableView.frame = CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height-48);
//    [_resultViewController.tableView.mj_footer endRefreshing];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [_searchResultArray removeAllObjects];
    [MBProgressHUD showHUDAddedTo:_tableView animated:YES];
    NSMutableDictionary *keyDic = [[NSMutableDictionary alloc]initWithCapacity:1];
    NSString *searchText = [_searchController.searchBar.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    [keyDic setValue:searchText forKey:@"FameName"];
    [TARequestManager TARequestCompletedWithPath:@"/Home/FameList" Parameters:keyDic sucee:^(NSDictionary *dic) {
        // 解析数据
        NSLog(@"----------%@",dic);
        [MBProgressHUD hideHUDForView:_tableView animated:YES];
        NSArray *tqxArr = dic[@"Data"][@"Data"][@"TQXList"];
        NSArray *dsjtArr = dic[@"Data"][@"Data"][@"DSJTlist"];
        if (tqxArr != nil && tqxArr.count != 0) {
            for (NSDictionary *tqxDic in tqxArr) {
                [_searchResultArray addObject:tqxDic];
            }
        }
        if (dsjtArr != nil && dsjtArr.count != 0) {
            for (NSDictionary *tqxDic in dsjtArr) {
                [_searchResultArray addObject:tqxDic];
            }
        }
        searchDataDic = dic[@"Data"][@"Data"];
        [_resultViewController.tableView reloadData];
    } fail:^(NSError *error) {
        [MBProgressHUD hideHUDForView:_tableView animated:YES];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
