//
//  moneyRecordCell.m
//  beSelf
//
//  Created by 木 on 15/4/21.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "moneyRecordCell.h"
@interface moneyRecordCell()
@property (weak, nonatomic) IBOutlet yLabel *typeLabel;
@property (weak, nonatomic) IBOutlet yLabel *moneyValueLabel;
@property (weak, nonatomic) IBOutlet yLabel *moneyUseLabel;

@end


@implementation moneyRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:reuseIdentifier owner:nil options:nil]lastObject];
        self.layer.borderColor = [UIColorWithRGB(136, 254, 237)CGColor];
        self.layer.borderWidth = 0.5;
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
    self.typeLabel.text = tmpObj.title;
    self.moneyValueLabel.text = tmpObj.money;
    self.moneyUseLabel.text = tmpObj.subTitle;
    
}

@end
