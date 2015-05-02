//
//  moneyRecord.h
//  targetDemo
//
//  Created by 木 on 15-4-12.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface moneyRecord : NSObject
//类型：收入，支出
@property (nonatomic ,copy) NSString *type;
//金额
@property (nonatomic ,copy) NSString *value;
//备注
@property (nonatomic ,copy) NSString *subTitle;

@end
