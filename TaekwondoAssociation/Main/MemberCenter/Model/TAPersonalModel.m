//
//  WQPersonalModel.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/27.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAPersonalModel.h"
#import <MJExtension.h>

@implementation TAPersonalModel

+(instancetype)initTAPersonalModelWithDic:(NSDictionary *)dic{
    TAPersonalModel *model = [TAPersonalModel new];
    [model mj_setKeyValues:dic];
    
    return model;
}

@end
