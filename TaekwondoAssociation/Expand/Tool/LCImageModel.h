//
//  LCImageModel.h
//  lumbarVertebrae
//
//  Created by Ceres on 15/9/9.
//  Copyright (c) 2015年 www.upupapp.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LCImageModel : NSObject

//缩略图
@property (nonatomic , strong) UIImage *image;
//缩略图
@property (nonatomic , copy) NSString *thumbnail_pic;

//中等尺寸图片地址，没有时返回此字段
@property (nonatomic , copy) NSString *bmiddle_pic;

//原图地址，没有时不返回此字段
@property (nonatomic , copy) NSString *original_pic;

@end
