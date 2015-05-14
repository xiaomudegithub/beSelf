//
//  imageTool.m
//  beSelf
//
//  Created by 木柳 on 15/5/5.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "imageTool.h"

@implementation imageTool



- (UIImage *)creatGrowImageWithFrame:(CGRect)frame{
    
    //设置颜色
    NSMutableArray *tempArray = [NSMutableArray array];
    UIColor *upColor = UIColorWithRGB(82, 237, 199) ;
    UIColor *downColor = UIColorWithRGB(90, 200, 251);
    [tempArray addObject:upColor];
    [tempArray addObject:downColor];
    //设置图片
    return  [self colorImageFromColors:tempArray ByGradientType:topToBottom andFrame:frame];
    
}

- (UIImage *)creatTargetImageWithFrame:(CGRect)frame{
    
    //设置颜色
    NSMutableArray *tempArray = [NSMutableArray array];
    UIColor *upColor = UIColorWithRGB(255, 149, 0) ;
    UIColor *downColor = UIColorWithRGB(255, 94, 58);
    [tempArray addObject:upColor];
    [tempArray addObject:downColor];
    //设置图片
    return  [self colorImageFromColors:tempArray ByGradientType:topToBottom andFrame:frame];
    
}

- (UIImage *)creatTimeImageWithFrame:(CGRect)frame{
    
    //设置颜色
    NSMutableArray *tempArray = [NSMutableArray array];
    UIColor *upColor = UIColorWithRGB(90, 212, 39) ;
    UIColor *downColor = UIColorWithRGB(164, 231, 134);
    [tempArray addObject:upColor];
    [tempArray addObject:downColor];
    //设置图片
    return  [self colorImageFromColors:tempArray ByGradientType:topToBottom andFrame:frame];
    
}

- (UIImage *)creatMoneyImageWithFrame:(CGRect)frame{
    
    //设置颜色
    NSMutableArray *tempArray = [NSMutableArray array];
    UIColor *upColor = UIColorWithRGB(255, 219, 76) ;
    UIColor *downColor = UIColorWithRGB(255, 205, 2);
    [tempArray addObject:upColor];
    [tempArray addObject:downColor];
    //设置图片
    return  [self colorImageFromColors:tempArray ByGradientType:topToBottom andFrame:frame];
    
}

- (UIImage*) colorImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType  andFrame:(CGRect)frame{
    NSMutableArray *ar = [NSMutableArray array];
    for(UIColor *c in colors) {
        [ar addObject:(id)c.CGColor];
    }
    UIGraphicsBeginImageContextWithOptions(frame.size, YES, 1);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGColorSpaceRef colorSpace = CGColorGetColorSpace([[colors lastObject] CGColor]);
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (CFArrayRef)ar, NULL);
    CGPoint start;
    CGPoint end;
    switch (gradientType) {
        case 0:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(0.0, frame.size.height);
            break;
        case 1:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(frame.size.width, 0.0);
            break;
        case 2:
            start = CGPointMake(0.0, 0.0);
            end = CGPointMake(frame.size.width, frame.size.height);
            break;
        case 3:
            start = CGPointMake(frame.size.width, 0.0);
            end = CGPointMake(0.0, frame.size.height);
            break;
        default:
            break;
    }
    CGContextDrawLinearGradient(context, gradient, start, end, kCGGradientDrawsBeforeStartLocation | kCGGradientDrawsAfterEndLocation);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
    CGColorSpaceRelease(colorSpace);
    UIGraphicsEndImageContext();
    return image;
}

@end
