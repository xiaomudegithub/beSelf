//
//  growUpRootCellData.m
//  beSelf
//
//  Created by 木 on 15/4/8.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "growUpRootObject.h"

@implementation growUpRootObject

//rowHeight
-(CGFloat)rowHeight{
    if (!_rowHeight) {
        CGSize size = [nsstringTool sizeWithString:self.object.subTitle andFont:labelHeigh_14];
        _rowHeight = margin_20+size.height + yCellHeight +margin_20;
    }
    return _rowHeight;
}
//cellString
- (NSString *)cellString{
    if (!_cellString) {
        _cellString = @"growUpCell";
    }
    return _cellString;
}

MJCodingImplementation;
@end
