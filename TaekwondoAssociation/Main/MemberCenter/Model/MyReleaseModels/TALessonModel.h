//
//  TALessonModel.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/7/6.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TALessonModel : NSObject

@property (nonatomic,strong) NSNumber *Id;
@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *Price;
@property (nonatomic,strong) NSString *CreatedTime;
@property (nonatomic,strong) NSString *StarTime;
@property (nonatomic,strong) NSString *EndTime;


+(instancetype)initTALessonModelWithDic:(NSDictionary *)dic;

@end
