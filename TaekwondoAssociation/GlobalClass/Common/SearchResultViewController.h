//
//  SearchResultViewController.h
//  TaoTao
//
//  Created by 王霞 on 16/3/11.
//  Copyright © 2016年 myself. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultViewController : UITableViewController
@property (strong,nonatomic)NSArray * dataArray;
- (void)reloadData;
- (void)removeNoDataView;
@end
