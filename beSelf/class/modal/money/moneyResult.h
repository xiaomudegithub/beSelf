//
//  moneyResult.h
//  beSelf
//
//  Created by 木 on 15/4/21.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface moneyResult : NSObject
/**
 *  收支记录数组
 */
@property (nonatomic,strong)NSMutableArray *mRecordArray;
+ (Class)money;
@end
