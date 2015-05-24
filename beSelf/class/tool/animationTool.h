//
//  animationTool.h
//  beSelf
//
//  Created by 木柳 on 15/5/15.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum{
    left = 0,
    right ,
    up,
    down
}subTypeEnum;

@interface animationTool : NSObject
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view;

//翻页（上反）
- (void) fanYeUpWithView:(UIView *)view;

//翻页（下反）
- (void) fanYeDownWithView:(UIView *)view;

//立方体
- (void) lifangtiDownWithView:(UIView *)view;

//吮吸效果
- (void) yunxiDownWithView:(UIView *)view;

//翻转效果
- (void) fanzhuanDownWithView:(UIView *)view;

//波纹效果
- (void) boWenWithView:(UIView *)view;

//上移
- (void) moveUpView:(UIView *)view WithHeight:(CGFloat )height;

//下移
- (void) moveDownView:(UIView *)view WithHeight:(CGFloat )height;

@end
