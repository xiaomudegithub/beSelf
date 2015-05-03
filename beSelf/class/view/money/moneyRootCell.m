//
//  moneyRootCell.m
//  beSelf
//
//  Created by 木 on 15/4/14.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "moneyRootCell.h"
@interface moneyRootCell()

@property (weak, nonatomic) IBOutlet yLabel *targetValueLab;
@property (weak, nonatomic) IBOutlet yLabel *moneyValueLab;
@property (weak, nonatomic) IBOutlet UIButton *moneyBtn;

@end

@implementation moneyRootCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:reuseIdentifier owner:nil options:nil]lastObject];
        self.backgroundColor = moneyColor;
        
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
    
    self.targetValueLab.text = tmpObj.title;
    self.moneyValueLab.text = tmpObj.subTitle;
    [self.moneyBtn setTitle:tmpObj.value forState:UIControlStateNormal];
    
}
@end
