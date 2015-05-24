//
//  targetRootCell.m
//  beSelf
//
//  Created by 木 on 15/4/11.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "targetRootCell.h"
@interface targetRootCell()
@property (weak, nonatomic) IBOutlet yLabel *timeValueLabel;
@property (weak, nonatomic) IBOutlet yLabel *moneyValueLabel;
@property (weak, nonatomic) IBOutlet yLabel *subTimeValueLabel;
@property (weak, nonatomic) IBOutlet yLabel *subMoneyValueLabel;
@property (weak, nonatomic) IBOutlet yLabel *title;
@property (weak, nonatomic) IBOutlet UIView *shuLine;
@property (weak, nonatomic) IBOutlet UIView *hengLine;
@end
@implementation targetRootCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self = [[[NSBundle mainBundle]loadNibNamed:reuseIdentifier owner:nil options:nil]lastObject];
        
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
    
    self.shuLine.backgroundColor = targetColor;
    self.hengLine.backgroundColor = targetColor;
    

    self.contentView.layer.borderColor = targetColor.CGColor;
    self.contentView.layer.borderWidth = 0.33;
    self.contentView.layer.cornerRadius = 5;
    self.backgroundColor = bgColor;
    
    
}
- (void)layoutSubviews{
    [super layoutSubviews];
   
    
}
@end
