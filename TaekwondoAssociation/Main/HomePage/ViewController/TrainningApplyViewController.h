//
//  TrainningApplyViewController.h
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TABaseViewController.h"
#import "RemarkCell.h"
#import "TrainingContentCell.h"
#import "ApplyTextFieldCell.h"

@interface TrainningApplyViewController : TABaseViewController

@property (nonatomic, strong) RemarkCell* remarkCell;
@property (nonatomic, strong) UITableView* tv;
@property (nonatomic, strong) UILabel* headLabel;
@property (nonatomic, strong) TrainingContentCell* trainingContentCell;
@property (nonatomic, strong) ApplyTextFieldCell* applyTFCell;

@end
