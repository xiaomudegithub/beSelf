//
//  YTabBar.h
//  beSelf1
//
//  Created by 木 on 15/3/16.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YTabBarDelegate <NSObject>

- (void)didSeleckedBtnTag:(NSInteger)btnTag FromLastBtnTag:(NSInteger)lastBtnTag;

@end

@interface YTabBar : UIView
//delegate
@property (weak, nonatomic) id<YTabBarDelegate> delegate;

- (void)addBtnWithTitle:(NSString *)btnTitle andNomalColor:(UIColor *)nomalColor andSelectedColor:(UIColor *)selectedColor;
@end
