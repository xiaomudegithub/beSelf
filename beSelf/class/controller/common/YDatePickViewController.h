//
//  YDatePickViewController.h
//  beSelf
//
//  Created by 木柳 on 15/5/21.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YDatePickViewControllerDelegate <NSObject>

- (void)didDatePickWithDateString:(NSString *)dateString;

- (void)cancelDatePick;

@end

@interface YDatePickViewController : UIViewController
//uicolor
@property (strong, nonatomic) UIColor *mainColor;
//代理
@property (weak, nonatomic) id<YDatePickViewControllerDelegate> delegate;

@end
