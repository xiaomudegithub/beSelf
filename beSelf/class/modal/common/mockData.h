//
//  mockData.h
//  beSelf
//
//  Created by 木 on 15/4/18.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface mockData : NSObject
//mock读取目标表的结果
@property (nonatomic,strong)targetResult *targetResult;
//mock读取的时间总额值
@property (nonatomic,copy)NSString *timeTotal;
//mock读取的财富总额值
@property (nonatomic,copy)NSString *moneyTotal;
//目标
@property (nonatomic,strong)targetModal *target;
/**
 *  收支记录
 */
@property (nonatomic,strong)moneyRecord *mRecord;
/**
 *  收支记录结果
 */
@property (nonatomic,strong)moneyResult *mResult;


@end
