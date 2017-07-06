//
//  TAMyReleaseCell.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/4.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAActivityModel.h"
#import "TALessonModel.h"

@interface TAMyReleaseCell : UITableViewCell

@property (nonatomic,strong) TAActivityModel *activityModel;
@property (nonatomic,strong) TALessonModel *lessonModel;

@end
