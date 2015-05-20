//
//  YMoneyTotalController.h
//  beSelf
//
//  Created by 木 on 15/4/21.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol YMoneyTotalControllerDelegate <NSObject>

- (void)didSaveTotalMoney;

@end

@interface YMoneyTotalController : UIViewController

@property(nonatomic ,weak)id<YMoneyTotalControllerDelegate>delegate;

@end
