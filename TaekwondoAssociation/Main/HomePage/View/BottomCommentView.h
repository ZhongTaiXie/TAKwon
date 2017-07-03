//
//  BottomCommentView.h
//  TaekwondoAssociation
//
//  Created by 王尉坤 on 2017/6/29.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum: NSUInteger{
    BottomCommentViewComment,
    BottomCommentViewRePlay
}BottomCommentViewType;

@interface BottomCommentView : UIView

@property (nonatomic, strong) UITextField* tfView;
@property (nonatomic, strong) UILabel* BadgeLb;
@property (nonatomic, strong) UIButton* commentBtn;
@property (nonatomic, strong) UIButton* collectBtn;
@property (nonatomic, strong) UIButton* shareBtn;
@property (nonatomic, strong) UIButton* tagsBtn;
@property (nonatomic, strong) UIImageView* tfImageV;

@property (nonatomic, assign) NSInteger type;

// 创建底部工具栏
- (instancetype)initWithType:(BottomCommentViewType)type;

@end
