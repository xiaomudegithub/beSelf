//
//  targetStep.h
//  beSelf
//
//  Created by 木柳 on 15/5/10.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface targetStep : NSObject
//targetId
@property (nonatomic, assign)NSInteger targetId;
//步骤数组
@property (strong, nonatomic) NSMutableArray *targetSteps;
@end
