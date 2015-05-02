//
//  YDatePickView.m
//  beSelf
//
//  Created by 木 on 15/4/18.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YDatePickerView.h"
@interface YDatePickerView()
/**
 *  日期选择器
 */
@property (nonatomic,strong)UIDatePicker *picker;

@end


@implementation YDatePickerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.picker = [[UIDatePicker alloc]init];
        [self.picker addTarget:self action:@selector(pickDate:) forControlEvents:UIControlEventValueChanged];
        self.picker.datePickerMode = UIDatePickerModeDate;
        [self addSubview:self.picker];
    }
    return self;
}

- (void)pickDate:(UIDatePicker *)picker{
    if ([self.delegate respondsToSelector:@selector(didSelectDate:)]) {
        NSString *dateString = [timeTool stringWihDate:picker.date andFormat:@"yyyy-MM-dd"];
        [self.delegate didSelectDate:dateString];
    }
}

- (void)openDatePicker{
    
    [UIView animateWithDuration:1.0 animations:^{
        self.frame = CGRectMake(0, yUIScreenHeight-216, yUIScreenWidth, 216);
    }];
    
}
- (void)closeDatePicker{
    
    [UIView animateWithDuration:1.0 animations:^{
        self.frame = CGRectMake(0, yUIScreenHeight, yUIScreenWidth, 216);
    }];
    
    
}
@end
