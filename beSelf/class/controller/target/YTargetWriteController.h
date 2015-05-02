//
//  YTargetWriteController.h
//  beSelf
//
//  Created by 木 on 15/4/17.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    targetTag = 101,
    startTimeTag ,
    endTimeTag ,
    moneyTag,
    moneyUseTag,
}cellTag;

@protocol YTargetWriteControllerDelegate <NSObject>

- (void)didSaveTarget;

@end
@interface YTargetWriteController : UIViewController
/**
 *  回传代理
 */
@property (nonatomic,weak)id<YTargetWriteControllerDelegate> delegate;

@end
