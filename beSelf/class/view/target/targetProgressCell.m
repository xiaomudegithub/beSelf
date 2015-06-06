//
//  targetProgressCell.m
//  beSelf
//
//  Created by 木柳 on 15/5/27.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "targetProgressCell.h"
@interface targetProgressCell()
//icon
@property (strong, nonatomic) UIButton *iconBtn;
//titleLabel
@property (strong, nonatomic) UILabel *titleLab;
//line
@property (strong, nonatomic) UIView *lineView;
//index
@property (nonatomic, assign) NSInteger stepIndex;
//mainColor
@property (strong, nonatomic) UIColor *mainColor;
@end


@implementation targetProgressCell
#pragma mark--set content 
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //icon
        self.iconBtn = [[UIButton alloc]init];
        self.iconBtn.layer.cornerRadius = imageW_25*0.5;
        self.iconBtn.layer.borderColor = [UIColor lightGrayColor].CGColor;
        self.iconBtn.layer.borderWidth = 0.33;
        [self.iconBtn addTarget:self action:@selector(iconBtnDidTapped:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:self.iconBtn];
        
        //title
        self.titleLab = [[UILabel alloc]init];
        [self.contentView addSubview:self.titleLab];
        
        //line
        self.lineView = [[UIView alloc]init];
        self.lineView.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:self.lineView];
        
    }
    return self;
}

#pragma mark--set attribute
- (void)setContentWithObject:(id)object AtIndexPath:(NSIndexPath *)indexPath{
    self.stepIndex =  indexPath.row;
    
    id tempObject = object[indexPath.section];
    
    NSArray *tempArray = nil;
    
    if ([tempObject isKindOfClass:[NSDictionary class]]) {
        NSDictionary *tempDic = (NSDictionary *)tempObject;
        tempArray = tempDic.allValues[0];
    }else{
        tempArray = (NSArray *)object;
    }
    
    TableObject *obj = (TableObject *)tempArray[indexPath.row];
    self.titleLab.text = obj.title;
    self.mainColor = yGreenColor;
    //self.iconBtn.enabled = obj.cellEable;
    if (indexPath.row ==4) {
        self.lineView.hidden = YES;
    }
    
    if (indexPath.row < obj.tag) {
        NSString *iconName = [NSString stringWithFormat:@"step%d",indexPath.row+1];
        self.lineView.backgroundColor = self.mainColor;
        self.titleLab.textColor = self.mainColor;
        [self.iconBtn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
        self.iconBtn.layer.borderColor = self.mainColor.CGColor;
    }else{
        NSString *iconName = [NSString stringWithFormat:@"unStepDone%d",indexPath.row+1];
        [self.iconBtn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    }
    
    
}

- (void)setCellDelegate:(id)sender{
    self.c_delegate = sender;
}
#pragma mark--set frame
- (void)layoutSubviews{
    [super layoutSubviews];
    self.iconBtn.frame = CGRectMake(yViewTopInset, yViewTopInset,imageW_25, imageH_25);
    self.titleLab.frame = CGRectMake(CGRectGetMaxX(self.iconBtn.frame)+margin_20, yViewTopInset, yUIScreenWidth, imageH_25);
    self.lineView.frame = CGRectMake(CGRectGetMaxX(self.iconBtn.frame)-self.iconBtn.frame.size.width*0.5-1, CGRectGetMaxY(self.iconBtn.frame),2,self.frame.size.height - CGRectGetMaxY(self.iconBtn.frame)+yViewTopInset);
    
}


#pragma mark--common method
- (void)iconBtnDidTapped:(id)sender{
    if ([self.c_delegate respondsToSelector:@selector(didFinishStepWithIndex:)]) {
        [self.c_delegate didFinishStepWithIndex:self.stepIndex+1];
    }
    NSString *iconName = [NSString stringWithFormat:@"step%d",self.stepIndex+1];
    [self.iconBtn setImage:[UIImage imageNamed:iconName] forState:UIControlStateNormal];
    self.iconBtn.layer.borderColor = self.mainColor.CGColor;
    
    self.lineView.backgroundColor = self.mainColor;
    
    self.titleLab.textColor = self.mainColor;
}
@end
