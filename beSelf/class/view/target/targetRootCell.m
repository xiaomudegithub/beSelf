//
//  targetRootCell.m
//  beSelf
//
//  Created by 木 on 15/4/11.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "targetRootCell.h"
@interface targetRootCell()
@property (weak, nonatomic) IBOutlet UILabel *timeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTimeValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *subMoneyValueLabel;
@property (weak, nonatomic) IBOutlet UILabel *title;

@end
@implementation targetRootCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];

        self = [[[NSBundle mainBundle]loadNibNamed:reuseIdentifier owner:nil options:nil]lastObject];
        CGRect frame = self.frame;
        frame.size.width = yUIScreenWidth;
        self.frame = frame;
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
    self.timeValueLabel.text = tmpObj.time;
    self.subTimeValueLabel.text = tmpObj.subTime;
    self.moneyValueLabel.text = tmpObj.money;
    self.subMoneyValueLabel.text = tmpObj.subMoney;
    
}
@end
