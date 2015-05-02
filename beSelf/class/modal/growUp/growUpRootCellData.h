//
//  growUpRootCellData.h
//  beSelf
//
//  Created by 木 on 15/4/8.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface growUpRootCellData : NSObject
//object
@property (nonatomic,strong)TableObject *object;
//cellName
@property (nonatomic,copy)NSString *cellString;
//行高
@property(nonatomic,assign)CGFloat rowHeight;
@end
