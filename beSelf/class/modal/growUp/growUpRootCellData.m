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
        CGSize size = [nsstringTool sizeWithString:self.object.subTitle andFont:labelHeigh_14];
        _rowHeight = margin_20+size.height + yCellHeight +margin_20;
    }
    return _rowHeight;
}
@end
