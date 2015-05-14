//
//  growUpCellTableViewCell.m
//  beSelf1
//
//  Created by 木 on 15/4/1.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "growUpCell.h"
#import "growUpRootObject.h"
@interface growUpCell()

//cellView
@property (nonatomic,strong)UIView *cellView;

//主标题
@property (nonatomic,strong)yLabel *titleLabel;
//副标题
@property (nonatomic,strong)yLabel *subTitleLabel;
//分割线
@property (nonatomic,strong)UIView *lineView;

@end


@implementation growUpCell

#pragma mark--1,在cell中添加控件
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.layer.borderColor =  growColor.CGColor;
        self.contentView.layer.borderWidth = 1;
        self.contentView.layer.cornerRadius = 5;

        
        yLabel *title = [[yLabel alloc]init];
        title.font = [UIFont systemFontOfSize:yCellTitleFontSize];
        [self.contentView addSubview:title];
        self.titleLabel = title;
        
        UIView *view = [[UIView alloc]init];
        view.backgroundColor = growColor;
        [self.contentView addSubview:view];
        self.lineView = view;
        
        yLabel *subTitle = [[yLabel alloc]init];
        subTitle.font = [UIFont systemFontOfSize:yCellSubTitleFontSize];
        subTitle.numberOfLines = 0 ;
        [self.contentView addSubview:subTitle];
        self.subTitleLabel = subTitle;
    }
    return self;
}
#pragma mark--2,设置cell中控件的属性]
- (void)setContentWithObject:(id)object AtIndexPath:(NSIndexPath *)index{
    
    id tempObject = object[index.section];
    
    NSArray *tempArray = nil;
    
    if ([tempObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDic = (NSDictionary *)tempObject;
        tempArray = tempDic.allValues[0];
    }else{
        tempArray = (NSArray *)tempObject;
    }
    
    growUpRootObject *obj  =  (growUpRootObject *)tempArray[index.row];
    
    self.titleLabel.text = obj.object.title;
    
    self.subTitleLabel.text = obj.object.subTitle;
    
    //CGRect cellF = CGRectMake(0, 0, yUIScreenWidth, obj.rowHeight);
    self.contentView.backgroundColor = bgColor;//[UIColor colorWithPatternImage:[yImage creatGrowImageWithFrame:cellF]];


    
}
- (void)setCellDelegate:(id)object{
    self.c_delegate = object;
}
#pragma mark--3,设置cell中控件的frame
- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat height = self.frame.size.height;
    
    self.contentView.frame = CGRectMake(yViewTopInset, 0, yUIScreenWidth- yViewTopInset*2, self.frame.size.height);
    
    CGFloat width = self.contentView.frame.size.width;

    self.titleLabel.frame = CGRectMake(ySideInset, 0,width - ySideInset*2, yCellHeight);
    
    self.lineView.frame = CGRectMake(ySideInset, CGRectGetMaxY(self.titleLabel.frame), width-2*ySideInset, yLineFont);

    self.subTitleLabel.frame = CGRectMake(ySideInset, CGRectGetMaxY(self.titleLabel.frame), width - 2*ySideInset,height-CGRectGetMaxY(self.titleLabel.frame));
    
}

@end
