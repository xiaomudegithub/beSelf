//
//  targetWriteCell.m
//  beSelf
//
//  Created by 木 on 15/4/17.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "targetWriteCell.h"

@interface  targetWriteCell()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textFieldCell;

@end

@implementation targetWriteCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        self = [[[NSBundle mainBundle]loadNibNamed:reuseIdentifier owner:nil options:nil]lastObject];
        self.backgroundColor = bgColor;
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
    self.textFieldCell.placeholder = obj.subTitle;
    self.textFieldCell.text = obj.title;
    self.textFieldCell.tag = obj.tag;
//    if (obj.subTitle) {
//        self.textFieldCell.selectedRange = nil;
//    }else{
//        self.textFieldCell.selectedRange = NSMakeRange(self.textFieldCell.text.length, 0);
//    }
   
    
}
- (void)setCellDelegate:(id)object{
    self.textFieldCell.delegate = object;
}
@end
