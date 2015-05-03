//
//  cacheTool.h
//  beSelf
//
//  Created by 木 on 15/4/15.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface cacheTool : NSObject
#pragma mark==================写入
#pragma mark--写入成长记录
- (void)cacheGrowUpRecord:(growUpRootObject *)growUp;
#pragma mark--写入目标
- (void)cacheTarget:(targetModal *)target;
#pragma mark--写入收支记录
- (void)cacheMoneyRecord:(moneyRecord *)money;
#pragma mark===================读取
#pragma mark--读取所有成长记录
- (growUpResult *)readerGrowUpResult;
#pragma mark--读取某一个目标
- (targetModal *)readerTargetWithParam:(targetParam *)param;
#pragma mark--读取所有目标
- (targetResult *)readerTargetResult;
#pragma mark--读取所有收支记录
- (moneyResult *)readerMoneyResult;
@end
