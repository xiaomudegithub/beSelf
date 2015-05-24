//
//  YEmptyView.m
//  beSelf
//
//  Created by 木柳 on 15/5/14.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YEmptyView.h"


@interface YEmptyView()
@property (weak, nonatomic) IBOutlet UIImageView *emptyImage;
@property (weak, nonatomic) IBOutlet UILabel *emptyLabel;
//view的frame
@property (nonatomic, assign)CGRect viewFrame;
@end

@implementation YEmptyView


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
       self = [[[NSBundle mainBundle]loadNibNamed:@"YEmptyView" owner:nil options:nil]lastObject];
        
        self.viewFrame = frame;
       
    }
    return self;
}

//修改内容属性
- (void)setObject:(TableObject *)object{

    
    _object = object;
    self.emptyLabel.text = object.title;
   
    self.emptyImage.contentMode = UIViewContentModeScaleAspectFill;
    self.emptyImage.image = [UIImage imageNamed:@"empty.jpg"];
    
}

#pragma mark--修改内容的frame
- (void)layoutSubviews{
    [super layoutSubviews];
    self.frame = self.viewFrame;
 
}
@end
