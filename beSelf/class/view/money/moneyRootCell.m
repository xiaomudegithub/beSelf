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
        
        self.contentView.layer.borderColor = moneyColor.CGColor;
        self.contentView.layer.borderWidth = 0.33;
        self.contentView.layer.cornerRadius = 5;
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
    //target
    self.targetValueLab.text = tmpObj.title;
    self.targetValueLab.textColor = moneyColor;
    //money
    self.moneyValueLab.text = tmpObj.subTitle;
    self.moneyValueLab.textColor = moneyColor;
    //valeBtn
    [self.moneyBtn setTitle:tmpObj.value forState:UIControlStateNormal];
    self.moneyBtn.layer.cornerRadius = 5;
    self.moneyBtn.backgroundColor = moneyColor;
}

- (void)layoutSubviews{
    [super layoutSubviews];

    
}
@end
