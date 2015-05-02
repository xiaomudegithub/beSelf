//
//  timeRootHeader.m
//  beSelf
//
//  Created by 木 on 15/4/13.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "rootHeader.h"
@interface rootHeader()
@property (weak, nonatomic) IBOutlet UILabel *subTitleLab;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;
@end

@implementation rootHeader

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        CGRect tempframe = self.frame;
        tempframe.size.width = yUIScreenWidth;
        self.frame = tempframe;
        self.backgroundColor = [UIColor clearColor];
        self = [[[NSBundle mainBundle]loadNibNamed:@"rootHeader" owner:nil options:nil]lastObject];
    }
    return self;
}

- (void)setContentWithObject:(id)object{
    TableObject *obj = (TableObject *)object;
    self.subTitleLab.text = obj.subTitle;
    self.titleLab.text = obj.title;
    self.timeLab.text =  obj.time;
}
@end
