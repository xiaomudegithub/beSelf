//
//  YNavigationControllerViewController.h
//  beSelf
//
//  Created by 木柳 on 15/5/5.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YNavigationController : UINavigationController
//backBtn title
@property (nonatomic, copy)NSString *backBtnTitle;
//backBtn color
@property (strong, nonatomic)UIColor *backBtnColor;
@end
