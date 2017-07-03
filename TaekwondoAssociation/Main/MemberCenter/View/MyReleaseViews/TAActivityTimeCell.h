//
//  TAActivityTimeCell.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/3.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TAActivityTimeCell : UITableViewCell

@property (copy) void(^startTimeBtnClick)(NSString *str);

@property (copy) void(^endTimeBtnClick)(NSString *str);

@property (nonatomic,strong) NSString *startTimeStr;
@property (nonatomic,strong) NSString *endTimeStr;

@end
