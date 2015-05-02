//
//  timeTool.m
//  beSelf
//
//  Created by 木 on 15/4/17.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "timeTool.h"

@implementation timeTool

+ (NSDateFormatter *)dateFormatterWithFormat:(NSString *)format{
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:format];
    return dateformatter;
}
//获取当前时间
+ (NSString *)getCurrentTimeWithFormat:(NSString *)format{
    NSDate *senddate=[NSDate date];
    return [self stringWihDate:senddate andFormat:format];
}
/**
 *  将date类型转换为字符串
 *
 *  @param date   date数据
 *  @param format 数据格式
 *
 *  @return 转换后的字符串
 */
+ (NSString *)stringWihDate:(NSDate *)date andFormat:(NSString *)format{
    
    NSDateFormatter *dateformatter = [self dateFormatterWithFormat:format];
    NSString *locationString=[dateformatter stringFromDate:date];
    return locationString;
    
}


/**
 *  将字符串转换为date
 *
 *  @param dateString date字符串
 *  @param format     日期格式
 *
 *  @return 日期
 */
+ (NSDate *)dateWithString:(NSString *)dateString andFormat:(NSString *)format{
    
    NSDateFormatter *dateformatter = [self dateFormatterWithFormat:format];
    NSDate *date = [dateformatter dateFromString:dateString];
    return date;
}


/**
  *  计算一个时间字符串与当前时间的天数
  *
  *  @param dateString 时间字符串
  *
  *  @return 天数
  */
+ (NSInteger)daysWithString:(NSString *)dateString andFormat:(NSString *)format{
    
    //结束时间
    NSDate *endDate = [self dateWithString:dateString andFormat:format];
    //当前时间
    NSDate *senderDate = [self dateWithString:[self getCurrentTimeWithFormat:format] andFormat:format];
    //得到相差秒数
    NSTimeInterval time=[endDate timeIntervalSinceDate:senderDate];
    
    NSInteger days = ((NSInteger)time)/(3600*24);
    
    return days;
}

/**
 *  计算一个时间与当前时间的天数
 *
 *  @param dateString 时间字符串
 *
 *  @return 天数
 */
+ (NSInteger)daysWithDate:(NSDate *)date andFormat:(NSString *)format{
    NSString *dateString = [self stringWihDate:date andFormat:format];
    return  [self daysWithString:dateString andFormat:format];
}

/**
 *  计算两个时间点之间的天数
 *
 *  @param startDate 开始日期
 *  @param endDate   结束日期
 *  @param format    日期格式
 *
 *  @return 天数
 */
+ (NSInteger)daysWithStartDay:(NSString *)startDate andEndDay:(NSString *)endDate andFormat:(NSString *)format{
    
    //结束时间
    NSDate *endDay = [self dateWithString:endDate andFormat:format];
    //当前时间
    NSDate *startDay = [self dateWithString:startDate andFormat:format];
    //得到相差秒数
    NSTimeInterval time=[endDay timeIntervalSinceDate:startDay];
    
    NSInteger days = ((NSInteger)time)/(3600*24);
    
    return days;
    
}

/**
 *  计算两个时间点之间的天数
 *
 *  @param startDate 开始日期
 *  @param endDate   结束日期
 *  @param format    日期格式
 *
 *  @return 天数
 */
+ (NSInteger)daysWithStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate andFormat:(NSString *)format{
    
    //得到相差秒数
    NSTimeInterval time=[endDate timeIntervalSinceDate:startDate];
    
    NSInteger days = ((NSInteger)time)/(3600*24);
    
    return days;
    
}
@end
