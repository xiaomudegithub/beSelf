//
//  targetProgressController.h
//  beSelf
//
//  Created by 木柳 on 15/5/14.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YTargetProgressController : UIViewController
//target index
@property (nonatomic, assign)NSInteger targetIndex;
//mainColor
@property (strong, nonatomic)UIColor *mainColor;
//bool
@property (nonatomic, assign)BOOL canChange;
@end
