//
//  MatchApplyTableViewController.h
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/5.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TABaseViewController.h"
#import "WeightInfoCell.h"
#import "RemarkCell.h"

@interface MatchApplyTableViewController :TABaseViewController

@property (nonatomic, strong) UITableView* tv;
@property (nonatomic, strong) UILabel* headLabel;

@property (nonatomic, strong) WeightInfoCell* weightInfoCell;
@property (nonatomic, strong) RemarkCell* remarkCell;

@end
