//
//  WQPersonalModel.h
//  TaekwondoAssociation
//
//  Created by 伟宏 on 2017/6/27.
//  Copyright © 2017年 Miss 李. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TAPersonalModel : NSObject

@property (nonatomic,strong) NSString *Photo;  //头像
@property (nonatomic,strong) NSString *BGPic;  //背景图片
@property (nonatomic,strong) NSNumber *UserType; //用户类型(个人/道馆)  1个人  2道馆
@property (nonatomic,strong) NSString *NickName;  //昵称
@property (nonatomic,assign) BOOL IsCertification;//是否认证
@property (nonatomic,strong) NSString *Career; //职业

@property (nonatomic,strong) NSNumber *Level;//等级
@property (nonatomic,strong) NSNumber *integral;//积分
@property (nonatomic,strong) NSString *Qrcode; //二维码

+(instancetype)initTAPersonalModelWithDic:(NSDictionary *)dic;


@end
