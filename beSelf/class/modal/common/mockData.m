//
//  mockData.m
//  beSelf
//
//  Created by 木 on 15/4/18.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "mockData.h"

@implementation mockData
- (targetResult *)targetResult{
    if (!_targetResult) {
        _targetResult = [[targetResult alloc]init];
        NSMutableArray *tempArray = [NSMutableArray array];
        for (NSInteger i = 0; i<3; i++) {
            [tempArray addObject:self.target];
        }
        _targetResult.targetArray = tempArray;
    }
    return _targetResult;
}
- (NSString *)moneyTotal{
    if (!_moneyTotal) {
        _moneyTotal = @"总金额";
    }
    return _moneyTotal;
}
- (NSString *)timeTotal{
    if (!_timeTotal) {
        _timeTotal = @"时间总额";
    }
    return _timeTotal;
}
- (targetModal *)target{
    if (!_target) {
        _target = [[targetModal alloc]init];
        _target.targetTitle = @"目标内容";
        _target.startTime =  @"2015/02/11";
        _target.endTime =  @"2015/04/30";
        _target.targetMoney = @"钱数";
        _target.moneyUse = @"投入金额用途";
    }
    return _target;
}
- (moneyResult *)mResult{
    if (!_mResult) {
        _mResult = [[moneyResult alloc]init];
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i<3; i++) {
            [array addObject:self.mRecord];
        }
        _mResult.mRecordArray = array;
    }
    return _mResult;
}
- (moneyRecord *)mRecord{
    if (!_mRecord) {
        _mRecord = [[moneyRecord alloc]init];
        _mRecord.type = @"收入";
        _mRecord.value = @"金额";
        _mRecord.subTitle = @"备注";
    }
    return _mRecord;
}
@end
