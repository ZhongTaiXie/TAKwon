//
//  TAActivityModel.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAActivityModel.h"
#import <MJExtension.h>


@implementation TAActivityModel

+(instancetype)initTAActivityModelWithDic:(NSDictionary *)dic{
    TAActivityModel *model = [TAActivityModel new];
    [model mj_setKeyValues:dic];
    
    return model;
}

@end
