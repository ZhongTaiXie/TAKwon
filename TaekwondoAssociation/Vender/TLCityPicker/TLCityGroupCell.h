//
//  TLCityGroupCell.h
//  TLCityPickerDemo
//
//  Created by 李伯坤 on 15/11/5.
//  Copyright © 2015年 李伯坤. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TLCity.h"
#import "TLCityPickerDelegate.h"

@interface TLCityGroupCell : UITableViewCell

@property (nonatomic, assign) id<TLCityGroupCellDelegate>delegate;

@property (nonatomic, strong) NSString *title;
//@property (nonatomic, strong) NSString *locationTitle;

@property (nonatomic, strong) NSArray *cityArray;
@property (nonatomic, strong) NSArray *locationArray;
- (id) initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
+ (CGFloat) getCellHeightOfCityArray:(NSArray *)cityArray;

@end
