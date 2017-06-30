//
//  JHSCustomTextField.m
//  短线擂台
//
//  Created by wangqi on 16/7/4.
//  Copyright © 2016年 juhesheng. All rights reserved.
//

#import "TACustomTextField.h"

@implementation TACustomTextField

//控制显示文本的位置
-(CGRect)textRectForBounds:(CGRect)bounds
{
    //return CGRectInset(bounds, 50, 0);
    CGRect inset = CGRectMake(bounds.origin.x+10, bounds.origin.y, bounds.size.width -10, bounds.size.height);//更好理解些
//    self.textColor = [HTTP colorWithHexString:@"666666"];
    return inset;
    
}

//控制编辑文本的位置
-(CGRect)editingRectForBounds:(CGRect)bounds
{
    //return CGRectInset( bounds, 10 , 0 );
    
    CGRect inset = CGRectMake(bounds.origin.x +10, bounds.origin.y, bounds.size.width -10, bounds.size.height);
//    self.textColor = [HTTP colorWithHexString:@"666666"];

    return inset;
}
@end
