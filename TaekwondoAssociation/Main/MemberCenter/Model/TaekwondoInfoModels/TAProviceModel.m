//
//  TAProviceModel.m
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import "TAProviceModel.h"
#import <MJExtension.h>
#import "TACityModel.h"


@implementation TAProviceModel

+(instancetype)initProvinceModelWithDic:(NSDictionary *)dic{
    TAProviceModel *model = [[self alloc] init];
    [model mj_setKeyValues:dic];
    
    NSMutableArray *mArray = [NSMutableArray array];
    for (NSDictionary *dic in model.CityList) {
        TACityModel *cityModel = [TACityModel initCityModelWithDic:dic];
        [mArray addObject:cityModel];
    }
    model.CityList = [mArray copy];
    
    return model;
}

@end
