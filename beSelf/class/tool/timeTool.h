//
//  timeTool.h
//  beSelf
//
//  Created by 木 on 15/4/17.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface timeTool : NSObject
/**
 *  获取当前时间
 *
 *  @param format 日期格式
 *
 *  @return 日期字符串
 */
+ (NSString *)getCurrentTimeWithFormat:(NSString *)format;

/**
 *  将date类型转换为字符串
 *
 *  @param date   date数据
 *  @param format 日期格式
 *
 *  @return 日期字符串
 */
+ (NSString *)stringWihDate:(NSDate *)date andFormat:(NSString *)format;

/**
 *  将字符串转换为date
 *
 *  @param dateString date字符串
 *  @param format     日期格式
 *
 *  @return 日期
 */
+ (NSDate *)dateWithString:(NSString *)dateString andFormat:(NSString *)format;

/**
 *  计算一个时间字符串与当前时间的天数
 *
 *  @param dateString 时间字符串
 *
 *  @return 天数
 */
+ (NSInteger)daysWithString:(NSString *)dateString andFormat:(NSString *)format;

/**
 *  计算一个时间与当前时间的天数
 *
 *  @param dateString 时间字符串
 *
 *  @return 天数
 */
+ (NSInteger)daysWithDate:(NSDate *)date andFormat:(NSString *)format;

/**
 *  计算两个时间点之间的天数
 *
 *  @param startDate 开始日期
 *  @param endDate   结束日期
 *  @param format    日期格式
 *
 *  @return 天数
 */
+ (NSInteger)daysWithStartDay:(NSString *)startDate andEndDay:(NSString *)endDate andFormat:(NSString *)format;

/**
 *  计算两个时间点之间的天数
 *
 *  @param startDate 开始日期
 *  @param endDate   结束日期
 *  @param format    日期格式
 *
 *  @return 天数
 */
+ (NSInteger)daysWithStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate andFormat:(NSString *)format;

@end
