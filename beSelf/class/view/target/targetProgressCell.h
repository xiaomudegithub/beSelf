//
//  targetProgressCell.h
//  beSelf
//
//  Created by 木柳 on 15/5/27.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol targetProgressCellDelegate <NSObject>

- (void)didFinishStepWithIndex:(NSInteger)stepIndex;

@end

@interface targetProgressCell : UITableViewCell
@property (nonatomic, weak)id<targetProgressCellDelegate>c_delegate;
@end
