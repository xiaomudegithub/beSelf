//
//  timeRootCell.m
//  beSelf
//
//  Created by 木 on 15/4/13.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "timeRootCell.h"
@interface timeRootCell()

@property (weak, nonatomic) IBOutlet yLabel *targetTitleLab;
@property (weak, nonatomic) IBOutlet yLabel *timeStartLab;
@property (weak, nonatomic) IBOutlet yLabel *timeEndLab;
@property (weak, nonatomic) IBOutlet UIButton *timeValueBtn;

@end


@implementation timeRootCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self = [[[NSBundle mainBundle]loadNibNamed:reuseIdentifier owner:nil options:nil]lastObject];
        //timeVlueBtn
        self.timeValueBtn.backgroundColor = UIColorWithRGB(241, 156, 92);
    }
    return self;
}

- (void)setContentWithObject:(id)object AtIndexPath:(NSIndexPath *)indexPath{
   
    id tmpObject = object[indexPath.section];
    
    NSArray *tmpArr = nil;
    
    if([tmpObject isKindOfClass:[NSDictionary class]])
    {
        NSDictionary *tmpDic = tmpObject;
        tmpArr = tmpDic.allValues[0];
    }
    else
    {
        tmpArr = object;
    }
    
    TableObject *tmpObj = tmpArr[indexPath.row];
    self.targetTitleLab.text = tmpObj.title;
    self.timeStartLab.text = tmpObj.time;
    self.timeEndLab.text = tmpObj.subTime;
    [self.timeValueBtn setTitle:tmpObj.value forState:UIControlStateNormal];
}

@end
