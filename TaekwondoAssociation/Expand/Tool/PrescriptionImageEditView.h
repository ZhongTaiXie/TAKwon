//
//  PrescriptionImageEditView.h
//  lumbar
//
//  Created by Ceres on 16/10/23.
//  Copyright © 2016年 www.upupapp.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol prescriptionImageDelegate <NSObject>

- (void)returnEditImage:(NSString*)imageUrl withIndex:(NSInteger)index;

@end

@interface PrescriptionImageEditView : UIView

@property (nonatomic, strong) NSString* imageUrl;
@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) id <prescriptionImageDelegate>delegate;


@end
