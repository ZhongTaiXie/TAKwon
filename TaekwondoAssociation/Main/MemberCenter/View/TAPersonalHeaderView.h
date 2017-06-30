//
//  WQPersonalHeaderView.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/27.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAPersonalModel.h"

@interface TAPersonalHeaderView : UIView

@property (copy) void(^bgImageViewDidClick)(NSString *str);
@property (copy) void(^headerImageViewClick)(NSString *str);

-(instancetype)initWithFrame:(CGRect)frame;

@end
