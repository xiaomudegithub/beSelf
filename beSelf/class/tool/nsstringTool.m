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
@end
