//
//  RemarkCell.h
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RemarkCell : UITableViewCell

@property (nonatomic, strong) UILabel* leftLable;
@property (nonatomic, strong) UITextView* textView;
@property (nonatomic, strong) UIButton* ensureBtn;

+ (instancetype)cellWithTableView:(UITableView *)tableView;


@end
