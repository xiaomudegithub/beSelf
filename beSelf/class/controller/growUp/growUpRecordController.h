//
//  growUpRecordController.h
//  beSelf
//
//  Created by 木 on 15/4/9.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import <UIKit/UIKit.h>
@class growUpRecordController;
@protocol growUpRecordControllerDelegate <NSObject>

- (void)didSaveGrowUpRecord;

@end

@interface growUpRecordController : UIViewController

@property(nonatomic, weak)id<growUpRecordControllerDelegate> delegate;
//上个页面传过来的数据
@property (nonatomic,strong)growUpRootObject *growLastObj;
//growUpId
@property (nonatomic, assign)NSInteger growUpId;
@end
