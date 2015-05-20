//
//  cacheTool.m
//  beSelf
//
//  Created by 木 on 15/4/15.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "cacheTool.h"

@implementation cacheTool
#pragma mark==========================创建数据库
static FMDatabaseQueue *_queue;
+ (void)initialize{
    //0.获取沙盒路径
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject] stringByAppendingPathComponent:@"beSelf.sqlite"];
    //1,创建队列
    _queue = [FMDatabaseQueue databaseQueueWithPath:path];
    
    //2,创表
    [_queue inDatabase:^(FMDatabase *db) {
        [db executeUpdate:@"create table y_target (targetId integer primary key autoincrement,target blob,targetStep blob);"];
        [db executeUpdate:@"create table y_moneyRecord (moneyId integer primary key autoincrement,moneyRecord blob);"];
        [db executeUpdate:@"create table y_growUp (growId integer primary key autoincrement, growRecord blob)"];
    }];
}

#pragma mark==========================写入
#pragma mark--写入成长记录
- (void)cacheGrowUpRecord:(growUpRootObject *)growUp{
    [_queue inDatabase:^(FMDatabase *db) {
        //获得需要存储的数据
        NSData *growData = [NSKeyedArchiver archivedDataWithRootObject:growUp];
        
        //存储数据
        [db executeUpdate:@"insert into y_growUp (growRecord) values (?)",growData];
    }];
}
#pragma mark--写入目标
- (void)cacheTarget:(targetModal *)target{
    
    [_queue inDatabase:^(FMDatabase *db) {
        //1,获得需要存储的数据
        NSData *targetData = [NSKeyedArchiver archivedDataWithRootObject:target];
        
        //2,存储数据
        [db executeUpdate:@"insert into y_target (target) values (?)",targetData];
    }];
  
}
#pragma mark--写入收支记录
- (void)cacheMoneyRecord:(moneyRecord *)money{
    
    [_queue inDatabase:^(FMDatabase *db) {
        //1,获得需要存储的数据
        NSData *moneyData = [NSKeyedArchiver archivedDataWithRootObject:money];
        
        //2,存储数据
        [db executeUpdate:@"insert into y_moneyRecord (moneyRecord) values (?)",moneyData];
    }];
    
}
#pragma mark--写入目标分解步骤
- (void)cacheTargetSteps:(targetStep *)tStep{
    [_queue inDatabase:^(FMDatabase *db) {
        //1,获得需要存储的数据
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:tStep];
        
        NSString *sql = [NSString stringWithFormat:@"update y_target set targetStep = '%@' where targetID = '%ld';",data,tStep.targetId];
        //2,存储数据
        BOOL success =  [db executeUpdate:sql];

        [self isSuccess:success];
    }];
}
#pragma mark===================读取
#pragma mark--读取某一个目标
- (targetModal *)readerTargetWithParam:(targetParam *)param{
    __block targetModal *target = [[targetModal alloc]init];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = nil;
 
        rs = [db executeQuery:@"select * from y_target where targetId = ? ",param.targetId];
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"target"];
            target = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
 
    }];
    return target;
}
#pragma mark--读取所有目标
- (targetResult *)readerTargetResult{
    __block targetResult *result = [[targetResult alloc]init];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = nil;
        NSMutableArray *tempArray = [NSMutableArray array];
        rs = [db executeQuery:@"select * from y_target"];
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"target"];
            targetModal *target = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [tempArray addObject:target];
        }
        result.targetArray = tempArray;
    }];
    return result;
}
#pragma mark--读取某一个目标步骤
- (targetStep *)readerTargetStepWithParam:(targetParam *)param{
    __block targetStep *target = [[targetStep alloc]init];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = nil;
        
        NSString *sql = [NSString stringWithFormat:@"select targetStep from y_target where targetId = '%ld'",param.targetId];
        rs = [db executeQuery:sql];//@"select targetStep from y_target where targetId = '?' ",param.targetId];
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"targetStep"];
            target = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        }
        
    }];
    return target;
}
#pragma mark--读取所有目标步骤
- (targetResult *)readerTargetStepResult{
    __block targetResult *result = [[targetResult alloc]init];
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = nil;
        NSMutableArray *tempArray = [NSMutableArray array];
        rs = [db executeQuery:@"select targetStep from y_target"];
        while (rs.next) {
            NSData *data = [rs dataForColumn:@"target"];
            targetStep *target = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [tempArray addObject:target];
        }
        result.targetStepArray = tempArray;
    }];
    return result;
}
#pragma mark--读取所有收支记录
- (moneyResult *)readerMoneyResult{
    __block moneyResult *result = [[moneyResult alloc]init];
    
    [_queue inDatabase:^(FMDatabase *db) {
        
        FMResultSet *rs = nil;
        NSMutableArray *tempArray = [NSMutableArray array];
        rs = [db executeQuery:@"select * from y_moneyRecord"];
        while (rs.next) {
            
            NSData *data = [rs dataForColumn:@"moneyRecord"];
            moneyRecord *record = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if (record) {
                [tempArray addObject:record];
            }
            
        }
        
        result.mRecordArray = tempArray;
    }];
    return result;
}
#pragma mark--读取所有成长记录  
- (growUpResult *)readerGrowUpResult{
    __block growUpResult *result = [[growUpResult alloc]init];
    
    [_queue inDatabase:^(FMDatabase *db) {
        FMResultSet *rs = nil;
        NSMutableArray *tempArray = [NSMutableArray array];
        rs = [db executeQuery:@"select * from y_growUp"];
        while (rs.next) {
            
            NSData *data = [rs dataForColumn:@"growRecord"];
            growUpRootObject *grow = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            if (grow) {
                [tempArray addObject:grow];
            }
        }
        result.grows = tempArray;
    }];
    return result;
}
#pragma mark===================修改
#pragma mark--修改成长记录
- (void)updateGrowUpRecord:(growUpParam *)param{
    [_queue inDatabase:^(FMDatabase *db) {
        //获得需要修改的数据
        NSData *growData = [NSKeyedArchiver archivedDataWithRootObject:param.growObj];
        NSString *sql = [NSString stringWithFormat:@"update y_target set targetStep = '%@' where targetID = '%ld';",growData,param.growId];
        BOOL success = [db executeUpdate:@"update y_growUp set growRecord = ('?') where growId  = ('?');",growData,param.growId];
        
        [self isSuccess:success];
    }];
}
#pragma mark--公共方法
- (void)isSuccess:(BOOL)success{
    if (success) {
        [MBProgressHUD showSuccess:@"操作成功"];
    }else{
        [MBProgressHUD showSuccess:@"操作失败"];
    }
}
@end
