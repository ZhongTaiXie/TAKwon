//
//  EditImagesFrame.m
//  lumbarVertebrae
//
//  Created by Ceres on 15/9/15.
//  Copyright (c) 2015年 www.upupapp.com. All rights reserved.
//

#import "EditImagesFrame.h"
#import "EditPhotoImagesView.h"

#define kDeviceHeight      [[UIScreen mainScreen] bounds].size.height
#define kDeviceWidth       [[UIScreen mainScreen] bounds].size.width


//cell的 左边距上边距
#define kStatusCellXOffset 10
#define kStatusCellYCutoff 15


@implementation EditImagesFrame

-(instancetype)initWithPicX :(CGFloat)picX{
    self =[super init];
    if (self) {
        _picX = picX;
    }
    return self;
}

- (void)setImagesArray:(NSArray *)imagesArray
{
    _imagesArray = imagesArray;
    
   [self setupCTPostContentFrame:_picX];
}

- (void)setIs_edit:(BOOL)is_edit
{
    _is_edit = is_edit;
    
}


//设置内容frame
- (void)setupCTPostContentFrame:(CGFloat)picX
{
    //缩略图
    CGFloat photosX = kStatusCellXOffset;
    CGFloat photosY = kStatusCellYCutoff;
    if (_imagesArray.count) {
        CGSize photosSize = [EditPhotoImagesView sizeWithPhotosCount:(int)_imagesArray.count picX:picX];
        if (_imagesArray.count > 3 && _is_edit) {
            photosSize = [EditPhotoImagesView sizeWithPhotosCount:(int)_imagesArray.count + 1 picX:picX];
        }
        self.imagesFrame =  (CGRect){{photosX, photosY}, photosSize};
    }  else {
        self.imagesFrame =  (CGRect){{photosX, photosY}, CGSizeMake(0, 0)};
    }
    
    CGFloat maxH = CGRectGetMaxY(self.imagesFrame)+kStatusCellYCutoff;
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = kDeviceWidth;
    self.frame = CGRectMake(x, y, w, maxH);
    
}

@end
