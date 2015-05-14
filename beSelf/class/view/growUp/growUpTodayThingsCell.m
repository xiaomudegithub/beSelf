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

}
@end
