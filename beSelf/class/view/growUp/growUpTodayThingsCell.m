//
//  growUpTodayThingsCell.m
//  beSelf
//
//  Created by 木 on 15/4/21.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "growUpTodayThingsCell.h"

@interface growUpTodayThingsCell()
@property (weak, nonatomic) IBOutlet yLabel *title;
//finishedIcon
@property (strong, nonatomic) UILabel *finishLabel;
@end

@implementation growUpTodayThingsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:reuseIdentifier owner:nil options:nil]lastObject];
        self.layer.borderWidth =0.33;
        self.layer.borderColor = growColor.CGColor;
        self.backgroundColor = bgColor;
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
    self.title.text = tmpObj.title;
    if (tmpObj.color) {
        self.backgroundColor = tmpObj.color;
        self.alpha = 0.33;
        self.finishLabel.textColor = tmpObj.color;
        [self.contentView addSubview:self.finishLabel];
    }
}

- (UILabel *)finishLabel{
    if (!_finishLabel) {
        CGFloat X = (self.frame.size.height - labelHeight_30)*0.5;
        _finishLabel = [[UILabel alloc]initWithFrame:CGRectMake(yUIScreenWidth-yViewTopInset-labelWidth_60, X, labelWidth_60, labelHeight_30)];
        _finishLabel.text = @"已完成";
        _finishLabel.textAlignment = NSTextAlignmentCenter;
        _finishLabel.backgroundColor = yWhite;
        _finishLabel.layer.cornerRadius = 15;
        _finishLabel.layer.masksToBounds = YES;
        
    }
    return _finishLabel;
}
@end
