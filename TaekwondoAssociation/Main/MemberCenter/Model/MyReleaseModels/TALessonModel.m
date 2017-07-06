//
//  TALessonModel.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TALessonModel.h"
#import <MJExtension.h>


@implementation TALessonModel

+(instancetype)initTALessonModelWithDic:(NSDictionary *)dic{
    TALessonModel *model = [TALessonModel new];
    [model mj_setKeyValues:dic];
    
    return model;
}

@end
