//
//  animationTool.m
//  beSelf
//
//  Created by 木柳 on 15/5/15.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "animationTool.h"

@interface animationTool()
//subType
@property (nonatomic,copy)NSString *subTypeTitle;
//subTypeEnum
@property (nonatomic, assign)subTypeEnum stEnum;
@end

@implementation animationTool
- (void) transitionWithType:(NSString *) type WithSubtype:(NSString *) subtype ForView : (UIView *) view {
         //创建CATransition对象
         CATransition *animation = [CATransition animation];
    
         //设置运动时间
         animation.duration = DURATION;
    
         //设置运动type
         animation.type = type;
         if (subtype != nil) {
        
                 //设置子类
                 animation.subtype = subtype;
             }
    
         //设置运动速度
         animation.timingFunction = UIViewAnimationOptionCurveEaseInOut;
    
         [view.layer addAnimation:animation forKey:@"animation"];
}

- (NSString *)subTypeTitle{
    switch (self.stEnum) {
        case 0:
            _subTypeTitle = kCATransitionFromLeft;
            break;
        case 1:
            _subTypeTitle = kCATransitionFromRight;
            
            break;
        case 2:
            _subTypeTitle = kCATransitionFromTop;

            break;
        case 3:
            _subTypeTitle = kCATransitionFromBottom;

            break;
        default:
            break;
    }
    return _subTypeTitle;
}
#pragma mark--具体动画
//翻页（上反）
- (void) fanYeUpWithView:(UIView *)view{
    self.stEnum = 3;
    [self transitionWithType:@"pageCurl" WithSubtype:self.subTypeTitle ForView:view];
}
//翻页（下反）
- (void) fanYeDownWithView:(UIView *)view{
    self.stEnum = 2;
    [self transitionWithType:@"pageUnCurl" WithSubtype:self.subTypeTitle ForView:view];
}

//立方体
- (void) lifangtiDownWithView:(UIView *)view{
    self.stEnum = 1;
    [self transitionWithType:@"cube" WithSubtype:self.subTypeTitle ForView:view];

}


//吮吸效果
- (void) yunxiDownWithView:(UIView *)view{
    self.stEnum = 0;
    [self transitionWithType:@"suckEffect" WithSubtype:self.subTypeTitle ForView:view];
}


//翻转效果
- (void) fanzhuanDownWithView:(UIView *)view{
    
    self.stEnum = 0;
    [self transitionWithType:@"oglFlip" WithSubtype:self.subTypeTitle ForView:view];
    
}

//波纹效果
- (void) boWenWithView:(UIView *)view{
    
    self.stEnum = 0;
    [self transitionWithType:@"rippleEffect" WithSubtype:self.subTypeTitle ForView:view];
    
}

//上移
- (void) moveUpView:(UIView *)view WithHeight:(CGFloat )height{
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect viewF =  view.frame;
        viewF.origin.y -= height;
        view.frame = viewF;

    }];

}

//下移
- (void) moveDownView:(UIView *)view WithHeight:(CGFloat )height{
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect viewF =  view.frame;
        viewF.origin.y += height;
        view.frame = viewF;
    }];
}

@end
