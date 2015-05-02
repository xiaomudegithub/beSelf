//
//  TableObject.h
//  MyGroupTableView
//
//  Created by chenchen.lcc on 15-2-12.
//  Copyright (c) 2015年 chenchen.lcc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TableObject : NSObject
//cellString
@property (nonatomic,copy)NSString *cellString;
//cellHeight
@property(nonatomic,assign)CGFloat cellHeight;

//title
@property (nonatomic,copy)NSString *title;

//subTitle
@property (nonatomic,copy)NSString *subTitle;

//value
@property (nonatomic,copy)NSString *value;

//subValue
@property (nonatomic,copy)NSString *subValue;

//time
@property (nonatomic,copy)NSString *time;

//subTime
@property (nonatomic,copy)NSString *subTime;

//money
@property (nonatomic,copy)NSString *money;

//subMoney
@property (nonatomic,copy)NSString *subMoney;

/**
 *  标识
 */
@property(nonatomic,assign)NSInteger tag;
@end
