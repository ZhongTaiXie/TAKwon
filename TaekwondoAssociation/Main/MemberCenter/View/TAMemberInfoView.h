//
//  TAMemberInfoView.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/27.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TAMemberInfoView : UIView

@property (copy) void(^memberGradeViewDidClick)();
@property (copy) void(^integrationViewDidClick)();
@property (copy) void(^QRCodeViewDidClick)();


-(instancetype)initWithFrame:(CGRect)frame;
@end
