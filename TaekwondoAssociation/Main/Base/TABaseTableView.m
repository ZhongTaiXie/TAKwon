//
//  TABaseTableView.m
//  TaekwondoAssociation
//
//  Created by 栗国聚 on 17/10/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TABaseTableView.h"
#import "MJRefresh.h"
#import "ConstColor.h"



@implementation TABaseTableView


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.separatorColor = [ConstColor dividerColor];
        self.tableFooterView = [[UIView alloc]init];
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
    
}

- (void)refreshFooterRefresh:(RefreshComponentFooterRefreshingBlock)componentFooterRefreshingBlock {
    
    self.page = 2;
    MJRefreshAutoNormalFooter  * mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.refreshState = SMBaseTableViewRefreshStateFooter;
        componentFooterRefreshingBlock();
    }];
    mj_footer.stateLabel.textColor = [UIColor colorWithWhite:0.498 alpha:0.500];
    mj_footer.automaticallyHidden = YES;
    self.mj_footer = mj_footer;
}

- (void)refreshheaderRefresh:(RefreshComponentFooterRefreshingBlock)componentHeaderRefreshingBlock {
    
    self.page = 1;
    
    MJRefreshNormalHeader * mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        self.refreshState = SMBaseTableViewRefreshStateHeader;
        componentHeaderRefreshingBlock();
    }];
    mj_header.automaticallyChangeAlpha = YES;
    mj_header.lastUpdatedTimeLabel.textColor =  [UIColor colorWithWhite:0.498 alpha:0.500];
    mj_header.stateLabel.textColor = mj_header.lastUpdatedTimeLabel.textColor;
    self.mj_header = mj_header;

    
}

- (void)refreshHeaderRefresh:(RefreshComponentHeaderRefreshingBlock)componentHeaderRefreshingBlock withFooterRefreshingBlock:(RefreshComponentFooterRefreshingBlock)componentFooterRefreshingBlock {
    
    
    self.page = 1;
    
    MJRefreshNormalHeader * mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        self.page = 1;
        self.refreshState = SMBaseTableViewRefreshStateHeader;
        componentHeaderRefreshingBlock();
    }];
    mj_header.automaticallyChangeAlpha = YES;
    mj_header.lastUpdatedTimeLabel.textColor =  [UIColor colorWithWhite:0.498 alpha:0.500];
    mj_header.stateLabel.textColor = mj_header.lastUpdatedTimeLabel.textColor;
    self.mj_header = mj_header;
    
    self.page = 2;
    MJRefreshAutoNormalFooter  * mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        self.refreshState = SMBaseTableViewRefreshStateFooter;
        componentFooterRefreshingBlock();
    }];
    mj_footer.stateLabel.textColor = mj_header.lastUpdatedTimeLabel.textColor;
    mj_footer.automaticallyHidden = YES;
    self.mj_footer = mj_footer;
    
}

- (void)endReload {
   
    [self reloadData];
    [self endRefreshing];
    self.page ++;
}


- (void)beginRefreshing {
    
    [self.mj_header beginRefreshing];
}


- (void)endRefreshing{
    
    if (self.mj_header) {
        if ([self.mj_header isRefreshing]) {
            [self.mj_header endRefreshing];
        }
    }
    
    if (self.mj_footer) {
        if ([self.mj_footer isRefreshing]) {
            [self.mj_footer endRefreshing];
        }
    }
}





@end
