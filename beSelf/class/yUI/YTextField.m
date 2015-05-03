//
//  YTextField.m
//  beSelf
//
//  Created by 木柳 on 15/5/3.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YTextField.h"

@implementation YTextField
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.textColor = [UIColor whiteColor];
    }
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
         self.textColor = [UIColor whiteColor];
    }
    return self;
}
- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    if (self) {
         self.textColor = [UIColor whiteColor];
    }
    return self;
}
@end
