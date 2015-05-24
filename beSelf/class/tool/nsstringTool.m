//
//  nsstringTool.m
//  beSelf
//
//  Created by 木柳 on 15/5/3.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "nsstringTool.h"

@implementation nsstringTool
+ (CGSize)sizeWithUILabel:(UILabel *)label{
    NSDictionary *atrribute = @{NSFontAttributeName:label.font};
    return [label.text sizeWithAttributes:atrribute];
}

+ (CGSize)sizeWithString:(NSString *)str andFont:(CGFloat)fontSize{
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    return [str sizeWithAttributes:attribute];
}

+ (CGSize)sizeWithString:(NSString *)str andFont:(CGFloat)fontSize andMaxWidth:(CGFloat)maxWidth{
    //字体属性
    NSDictionary *attribute = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]};
    //
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    //获取字体的frame
    CGRect frame = [str boundingRectWithSize:CGSizeMake(maxWidth, MAXFLOAT) options:options attributes:attribute context:nil];
    
    return frame.size;
    
}
@end
