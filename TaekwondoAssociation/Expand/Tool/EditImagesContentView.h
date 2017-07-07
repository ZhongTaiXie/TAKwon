//
//  EditImagesContentView.h
//  lumbarVertebrae
//
//  Created by Ceres on 15/9/15.
//  Copyright (c) 2015年 www.upupapp.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditPhotoImagesView.h"
@class EditImagesFrame;
@interface EditImagesContentView : UIImageView
//配图
@property (nonatomic ,weak) EditPhotoImagesView *editPhotoImagesView;

@property (nonatomic , strong) EditImagesFrame *editImagesFrame;

- (instancetype)initWithPicX:(CGFloat)picX;

@end
