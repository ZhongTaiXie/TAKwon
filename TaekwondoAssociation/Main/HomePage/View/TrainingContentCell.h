//
//  TrainingContentCell.h
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TrainingContentCell : UITableViewCell

@property (nonatomic, strong) UILabel* leftLb;
@property (nonatomic, strong) UIButton* leftBtn;
@property (nonatomic, strong) UIButton* rightBtn;

+ (instancetype)cellWithTableview:(UITableView* )tableView;

@end
