//
//  YTextView.m
//  beSelf
//
//  Created by 木柳 on 15/5/3.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YTextView.h"

@implementation YTextView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.textColor = yWhite;
        
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.textColor = yWhite;
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = yWhite;
    }
    return self;
}

@end
