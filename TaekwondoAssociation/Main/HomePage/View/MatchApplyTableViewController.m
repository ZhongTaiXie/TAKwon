//
//  MatchApplyTableViewController.m
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/5.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "MatchApplyTableViewController.h"
#import "IQKeyboardManager.h"

@interface MatchApplyTableViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation MatchApplyTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
    [[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
    self.navigationItem.title = @"报名";
    // tv初始化
    _tv = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, KTA_Screen_Height - TopNavigationBarHeight) style:UITableViewStyleGrouped];
    _tv.separatorColor = [UIColor colorWithRed:0.9 green:0.9 blue:0.9 alpha:1];
    _tv.backgroundColor = [UIColor whiteColor];
    _tv.delegate = self;
    _tv.dataSource = self;
    
    [self.view addSubview:_tv];
    
    // 隐藏多余的分割线
    UIView* footerView = [[UIView alloc] init];
    footerView.backgroundColor = [UIColor clearColor];
    self.tv.tableFooterView = footerView;
    
    // 设置头部label
    [self createHeadLabel];
}

- (void)createHeadLabel
{
    _headLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, KTA_Screen_Width, 60)];
    _headLabel.textAlignment = NSTextAlignmentCenter;
    _headLabel.text = @"2017年全国大众跆拳道xxx赛事";
    _tv.tableHeaderView = _headLabel;
}


#pragma -mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 4;
    }else{
        return 2;
    }
}


#pragma -mark UITableViewDelegate
- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.section) {
        case 0:
        {
            static NSString* strId = @"infoCellId";
            UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:strId];
            
            if (!cell) {
                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:strId];
            }
            cell.textLabel.textColor = [UIColor lightGrayColor];
            cell.detailTextLabel.textColor = [UIColor grayColor];
            cell.textLabel.font = [UIFont systemFontOfSize:14];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
            cell.textLabel.text = @"demo测试1";
            cell.detailTextLabel.text = @"demo测试2";
            
            return cell;

        }
            
            break;
        case 1:
        {
            _weightInfoCell = [WeightInfoCell cellWithTableView:_tv];
            
            
            return _weightInfoCell;

        }
            
            break;
        default:
            return nil;
            break;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 50;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view=[[UIView alloc] init];
    view.backgroundColor = [UIColor colorWithRed:0.96 green:0.96 blue:0.96 alpha:1];
    
    UIView* blueView = [[UIView alloc] initWithFrame:CGRectMake(0, 17, 5, 15)];
    blueView.backgroundColor = [UIColor colorWithRed:51/255.0 green:135/255.0 blue:255/255.0 alpha:1];
    
    UILabel* groupLb = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 50)];
    switch (section) {
        case 0:
        {
            NSString* str = @"会员信息 (＊)";
            NSMutableAttributedString* attStr = [[NSMutableAttributedString alloc] initWithString:str];
            
            NSDictionary* colorAS = @{NSForegroundColorAttributeName:[UIColor redColor]};
            [attStr addAttributes:colorAS range:[str rangeOfString:@"＊"]];
            groupLb.attributedText = attStr;
        }
            
            break;
        case 1:
            groupLb.text = @"填写项";
            break;
        default:
            break;
    }
    
    
    
    
    [view addSubview:blueView];
    [view addSubview:groupLb];
    
    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 取消cell的选中效果
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // 分割线顶头
    
    // Remove seperator inset
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    // Prevent the cell from inheriting the Table View's margin settings
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    // Explictly set your cell's layout margins
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
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
