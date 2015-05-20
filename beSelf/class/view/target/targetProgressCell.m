//
//  targetProgressCell.m
//  beSelf
//
//  Created by 木柳 on 15/5/14.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "targetProgressCell.h"

@interface targetProgressCell()
//标识
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subTitleLabel;


@end


@implementation targetProgressCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self = [[[NSBundle mainBundle]loadNibNamed:@"targetProgressCell" owner:nil options:nil]lastObject];
    }
    return self;
}

- (void)setContentWithObject:(id)object AtIndexPath:(NSIndexPath *)indexPath{
    id tempObject = object[indexPath.section];
    
    NSArray *tempArray = nil;
    
    if ([tempObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDic = (NSDictionary *)tempObject;
        tempArray = tempDic.allValues[0];
    }else{
        tempArray = (NSArray *)object;
    }
    
    TableObject *obj = (TableObject *)tempArray[indexPath.row];
    
    self.titleLabel.text = obj.title;
    self.detailTextLabel.text = obj.subTitle;
    
}
@end
