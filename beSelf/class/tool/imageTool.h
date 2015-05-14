//
//  imageTool.h
//  beSelf
//
//  Created by 木柳 on 15/5/5.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum  {
    topToBottom = 0,//从上到小
    leftToRight = 1,//从左到右
    upleftTolowRight = 2,//左上到右下
    uprightTolowLeft = 3,//右上到左下
}GradientType;
@interface imageTool : NSObject

- (UIImage *)creatGrowImageWithFrame:(CGRect)frame;

- (UIImage *)creatTargetImageWithFrame:(CGRect)frame;

- (UIImage *)creatTimeImageWithFrame:(CGRect)frame;

- (UIImage *)creatMoneyImageWithFrame:(CGRect)frame;

- (UIImage*) colorImageFromColors:(NSArray*)colors ByGradientType:(GradientType)gradientType  andFrame:(CGRect)frame;
@end
