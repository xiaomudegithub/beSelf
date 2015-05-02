//
//  target.h
//  targetDemo
//
//  Created by 木 on 15-4-12.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface targetModal : NSObject
/**
 *  目标内容
 */
@property (nonatomic,copy)NSString *targetTitle;
/**
 *  开始时间
 */
@property (nonatomic,copy)NSString *startTime;
/**
 *  结束时间
 */
@property (nonatomic,copy)NSString *endTime;
/**
 *  投入金额
 */
@property (nonatomic,copy)NSString *targetMoney;
/**
 *  投入金额用途
 */
@property (nonatomic,copy)NSString *moneyUse;

@end
