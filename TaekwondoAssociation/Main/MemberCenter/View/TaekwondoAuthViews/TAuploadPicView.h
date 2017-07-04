//
//  TAuploadPicView.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/28.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TAuploadPicView : UIView


@property (copy) void(^addPicBtnClick)(NSString *str);

@property (copy) void(^delPicBtnClick)(NSString *str,NSInteger tag);


-(instancetype)initWithFrame:(CGRect)frame title:(NSString *)title imageArray:(NSArray *)imageArray;

@end
