//
//  YDatePickView.h
//  beSelf
//
//  Created by 木 on 15/4/18.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YDatePickerViewDelegate <NSObject>

- (void)didSelectDate:(NSString *)date;

@end
@interface YDatePickerView : UIView

@property (nonatomic,weak)id<YDatePickerViewDelegate>delegate;
- (void)openDatePicker;
- (void)closeDatePicker;
@end
