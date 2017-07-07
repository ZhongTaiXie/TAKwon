//
//  EditImagesFrame.h
//  lumbarVertebrae
//
//  Created by Ceres on 15/9/15.
//  Copyright (c) 2015年 www.upupapp.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EditImagesFrame : NSObject


@property (nonatomic, strong)NSArray *imagesArray;
@property (nonatomic, assign) BOOL is_edit;

//images frame
@property (nonatomic , assign) CGRect imagesFrame;

//cell高度
@property (nonatomic , assign) CGFloat cellHeight;

// 6.自己的frame
@property (nonatomic , assign) CGRect frame;

@property (nonatomic , assign) CGFloat picX;

-(instancetype)initWithPicX :(CGFloat)picX;

@end
