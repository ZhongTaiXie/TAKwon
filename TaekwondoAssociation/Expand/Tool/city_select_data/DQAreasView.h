//
//  DQAreasView.h
//  YBCommunity
//
//  Created by DQ on 16/9/9.
//  Copyright © 2016年 com.NiceMoment. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TAProviceModel.h"

//@class WQAreaModel;
@protocol DQAreasViewDelegate <NSObject>
@optional
/**
 model 所在地的数据
 */
//点击选中哪一行 的代理方法
- (void)clickAreasViewEnsureBtnActionAreaStr:(NSString *)str cityCode:(NSString *)codeId;

@end

@interface DQAreasView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
/**
 ProvinceArr 地址的省份数组
 cityArr 城市的数组
 countyArr 县的数组
 */
@property (nonatomic, copy) NSArray *ProvinceArr;
@property (nonatomic, copy) NSArray *cityArr;
@property (nonatomic, copy) NSArray *countyArr;
@property (nonatomic, weak) id<DQAreasViewDelegate> delegate;

- (void)startAnimationFunction;
- (void)CloseAnimationFunction;

@end
