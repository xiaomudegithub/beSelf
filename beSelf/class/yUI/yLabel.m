//
//  yLabel.m
//  beSelf
//
//  Created by 木柳 on 15/5/2.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "yLabel.h"

@implementation yLabel

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if ( self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

@end
