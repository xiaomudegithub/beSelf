//
//  YTimeViewController.h
//  beSelf
//
//  Created by 木 on 15/4/22.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol YTotalTimeViewControllerDelegate <NSObject>

- (void)didSaveTotalMoney;

@end

@interface YTotalTimeViewController : UIViewController
//代理
@property (weak, nonatomic) id<YTotalTimeViewControllerDelegate> delegate;

@end
