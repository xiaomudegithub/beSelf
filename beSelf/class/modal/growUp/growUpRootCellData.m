//
//  growUpRootCellData.m
//  beSelf
//
//  Created by 木 on 15/4/8.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "growUpRootCellData.h"

@implementation growUpRootCellData
//rowHeight
-(CGFloat)rowHeight{
    if (!_rowHeight) {
        CGSize size = [self.object.subTitle sizeWithFont:[UIFont systemFontOfSize:yCellSubTitleFontSize] constrainedToSize:CGSizeMake(yUIScreenWidth - 2*ySideInset, MAXFLOAT) lineBreakMode:NSLineBreakByCharWrapping];
        _rowHeight = 60+size.height;
    }
    return _rowHeight;
}
@end
