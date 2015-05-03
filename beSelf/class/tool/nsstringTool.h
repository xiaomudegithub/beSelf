//
//  nsstringTool.h
//  beSelf
//
//  Created by 木柳 on 15/5/3.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface nsstringTool : NSObject

+ (CGSize)sizeWithUILabel:(UILabel *)label;

+ (CGSize)sizeWithString:(NSString *)str andFont:(CGFloat)fontSize;
@end
