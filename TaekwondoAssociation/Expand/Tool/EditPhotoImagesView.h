//
//  EditPhotoImagesView.h
//  lumbarVertebrae
//
//  Created by Ceres on 15/9/15.
//  Copyright (c) 2015年 www.upupapp.com. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MediaPack.h"
#import "PrescriptionImageEditView.h"

@protocol EditPhotoImagesViewDelegate <NSObject>

- (void)showActionSheetShowWithTag:(NSInteger)index;

- (void)addNewPhotosTaped;

@end

@interface EditPhotoImagesView : UIView

@property (nonatomic, assign) id<EditPhotoImagesViewDelegate> delegate;

@property (nonatomic,strong) NSArray *image_thumb_urls;
@property (nonatomic,strong) NSArray *image_urls;

@property (nonatomic, strong) NSArray* mediaPacks;

@property (nonatomic,assign)CGFloat picX;
@property (nonatomic,assign)CGFloat picline;

@property (nonatomic,strong) PrescriptionImageEditView* prescriptionView;

@property (nonatomic, assign) BOOL is_prescription;
//根据图片个数计算尺寸
+ (CGSize)sizeWithPhotosCount:(int)photosCount picX:(CGFloat)picX;
- (instancetype)initWithPicX:(CGFloat)picX;
@end
