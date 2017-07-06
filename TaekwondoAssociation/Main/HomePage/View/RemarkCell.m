//
//  RemarkCell.m
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "RemarkCell.h"

@implementation RemarkCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString* Id = @"remarkCellId";
    RemarkCell* cell = [tableView dequeueReusableCellWithIdentifier:Id];
    if (!cell) {
        cell = [[RemarkCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:Id];
        
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self setupDetailView];
    }
    
    return self;
}

- (void)setupDetailView
{
    // 左边label
    _leftLable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 40, 40)];
    _leftLable.text = @"备注:";
    _leftLable.textColor = [UIColor lightGrayColor];
    _leftLable.font = [UIFont systemFontOfSize:14];
    
    // 备注textview
    _textView = [[UITextView alloc] initWithFrame:CGRectMake(10, 45, KTA_Screen_Width - 20, 80)];
    _textView.backgroundColor = [UIColor colorWithRed:0.95 green:0.95 blue:0.95 alpha:0.95];
    _textView.layer.cornerRadius = 5;
    _textView.layer.masksToBounds = YES;
    _textView.contentMode = UIViewContentModeScaleAspectFill;
    
    // 确认按钮
    _ensureBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _ensureBtn.frame = CGRectMake(10, 150, KTA_Screen_Width - 20, 50);
    _ensureBtn.backgroundColor = [UIColor colorWithRed:51/255.0 green:135/255.0 blue:255/255.0 alpha:1];
    [_ensureBtn setTitle:@"确认报名" forState:UIControlStateNormal];
    [_ensureBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _ensureBtn.layer.cornerRadius = 5;
    _ensureBtn.layer.masksToBounds = YES;
    _ensureBtn.contentMode = UIViewContentModeScaleAspectFill;
    [_ensureBtn addTarget:self action:@selector(ensureBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_leftLable];
    [self.contentView addSubview:_textView];
    [self.contentView addSubview:_ensureBtn];
    
    
}

- (void)ensureBtnClick
{
    NSLog(@"click - ensureBtn");
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
