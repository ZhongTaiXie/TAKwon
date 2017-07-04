//
//  SearchResultViewController.m
//  TaoTao
//
//  Created by 王霞 on 16/3/11.
//  Copyright © 2016年 myself. All rights reserved.
//

#import "SearchResultViewController.h"

@interface SearchResultViewController (){
    UILabel *noDataLabel;
}

@end

@implementation SearchResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    noDataLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, KTA_Screen_Height/3.0f, KTA_Screen_Width, 50)];
    noDataLabel.font = [UIFont systemFontOfSize:40];
    noDataLabel.textAlignment = NSTextAlignmentCenter;
    noDataLabel.textColor = RGB(145, 145, 145);
    noDataLabel.text = @"无结果";
    
    UIView *myview =[ [UIView alloc]init];
    myview.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:myview];

}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (noDataLabel) {
        [noDataLabel removeFromSuperview];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)removeNoDataView{
    
}
- (void)reloadData{
    [self.tableView reloadData];
    NSInteger rowNumbers = 0;
    for (NSInteger i = 0; i < self.tableView.numberOfSections; i++) {
        rowNumbers += [self.tableView numberOfRowsInSection:i];
    }
    if ((_dataArray == nil || _dataArray.count == 0) && rowNumbers == 0) {
        noDataLabel.hidden = NO;
        [self.tableView addSubview:noDataLabel];
    }else{
        noDataLabel.hidden = YES;
        [noDataLabel removeFromSuperview];
    }
    
}
@end
