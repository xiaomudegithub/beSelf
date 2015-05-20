//
//  YTabBar.m
//  beSelf1
//
//  Created by 木 on 15/3/16.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YTabBar.h"
@interface YTabBar()
//btn数组
@property (strong, nonatomic) NSMutableArray *btns;
//选中btn
@property (strong, nonatomic) UIButton *selectedBtn;

@end

@implementation YTabBar
//重写initWithFrame
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = bgColor;
    }
    return self;
}
- (void)addBtnWithTitle:(NSString *)btnTitle andNomalColor:(UIColor *)nomalColor andSelectedColor:(UIColor *)selectedColor{
    
    //设置背景图片数组
    
    CGRect btnFrame = CGRectMake(0, 0, yUIScreenWidth/(self.btns.count+1), self.frame.size.height);
    NSArray *selectedImageColors = @[selectedColor,selectedColor];
    UIImage *selectedImage = [yImage colorImageFromColors:selectedImageColors ByGradientType:topToBottom andFrame:btnFrame];
    NSArray *nomalImageColors = @[nomalColor,nomalColor];
    UIImage *nomalImage = [yImage colorImageFromColors:nomalImageColors ByGradientType:topToBottom andFrame:btnFrame];
    
    //1,设置btn
    UIButton *btn = [[UIButton alloc]init];
    
    //title
    [btn setTitle:btnTitle forState:UIControlStateNormal];
    [btn setTitle:btnTitle forState:UIControlStateSelected];
    [btn setTitleColor:selectedColor forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    
    //image
    [btn setBackgroundImage:selectedImage forState:UIControlStateSelected];
    [btn setBackgroundImage:nomalImage forState:UIControlStateNormal];
   
    [btn addTarget:self action:@selector(didClick:) forControlEvents:UIControlEventTouchDown];
    //layer
    btn.layer.cornerRadius = 5;
    btn.layer.borderWidth = 0.33;
    btn.layer.borderColor = selectedColor.CGColor;
    btn.layer.masksToBounds = YES;
    //2,添加到button数组中
    [self.btns addObject:btn];
    
    //3,添加到view上
    [self addSubview:btn];
    
    //4,设置默认选中
    if (self.btns.count==1) {
        btn.selected = YES;
        [self didClick:btn];
    }
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    //1,遍历出所有btn
    
    CGFloat btnW = yUIScreenWidth/self.btns.count;
    CGFloat btnY = 0;
    CGFloat btnH = self.frame.size.height;
    
    for (NSInteger i = 0 ; i<self.btns.count; i++) {
        //1,get the btn
        UIButton *btn = self.btns[i];
        
        //2,set the frame of btn
        btn.frame = CGRectMake(btnW*i, btnY, btnW, btnH);
        
        //3,set tag of btn
        btn.tag = i;
    }
    
}

- (void)didClick:(UIButton *)btn{
    if ([self.delegate respondsToSelector:@selector(didSeleckedBtnTag:FromLastBtnTag:)]) {
        [self.delegate didSeleckedBtnTag:btn.tag FromLastBtnTag:self.selectedBtn.tag];
    }
    
    //设置选中btn状态
    btn.selected = YES;
    //设置上次选中btn状态
    self.selectedBtn.selected = NO;
    //将这次选中btn变成上次选中btn
    self.selectedBtn = btn;
    
}
#pragma mark--初始化
- (NSMutableArray *)btns{
    if (!_btns) {
        _btns = [NSMutableArray array];
    }
    return _btns;
}
@end
