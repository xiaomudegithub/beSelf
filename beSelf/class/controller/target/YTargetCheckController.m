//
//  YTargetCheckControllerViewController.m
//  beSelf
//
//  Created by 木柳 on 15/5/4.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YTargetCheckController.h"

@interface YTargetCheckController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *iconView;
- (IBAction)didNextStepTapped:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *stepDes;
@property (weak, nonatomic) IBOutlet UITextView *stepTextView;
@property (weak, nonatomic) IBOutlet UIButton *nextStep;
//返回按钮
@property (strong, nonatomic) UIButton *lastStepBtn;
//第几步
@property (assign, nonatomic) NSInteger step;
//数据存储
@property (strong, nonatomic) NSMutableArray *stepsArray;
//步骤标题
@property (strong, nonatomic) NSArray *stepTitles;

@end

@implementation YTargetCheckController

#pragma mark==============1,生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpUI];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark==============2，UI搭建
#pragma mark--初始化属性
- (void)setUpUI{
    //headerView
    self.headerView.backgroundColor = targetColor;
    
    //iconView
    self.iconView.backgroundColor = [UIColor redColor];
    
    //stepDes
    self.stepDes.textColor = targetColor;
    
    //stepTextView
    self.stepTextView.textColor = yWhite;
    
    //step
    self.step = 0;
    
    //stepTitles
    self.stepTitles = @[@"第一步",@"第二步",@"第三步",@"第四步",@"最后一步"];
    
    
    //nextStep
    [self.nextStep setBackgroundColor:targetColor];
    [self.nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextStep setTitle:self.stepTitles[self.step] forState:UIControlStateNormal];
    
    //lastStepBtn
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.lastStepBtn];
    
}
#pragma mark--初始化控件
//上一步
- (UIButton *)lastStepBtn{
    if (!_lastStepBtn) {
        _lastStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lastStepBtn.frame = CGRectMake(0, 0, btnWidth_44, btnWidth_44);
        _lastStepBtn.backgroundColor = targetColor;
        _lastStepBtn.titleLabel.textColor = yWhite;
        }
    return  _lastStepBtn;
}
//步骤数组
- (NSMutableArray *)stepsArray{
    if (!_stepsArray) {
        
        _stepsArray = [NSMutableArray array];
        
    }
    return _stepsArray;
}
#pragma mark==============3，数据渲染

#pragma mark==============4，操作
#pragma mark--下一步
- (IBAction)didNextStepTapped:(id)sender {
    if (self.step == 4) {
        //缓存数据
        [self cacheStep];
        //返回到上层页面
        [self.navigationController popViewControllerAnimated:YES];
        return;
    }
    //设置返回按钮title
    [self.lastStepBtn setTitle:@"返回上一步" forState:UIControlStateNormal];
    
    //加一步
    self.step ++;
    //存储数据
    [self.stepsArray addObject:self.stepTextView.text];
    //清空数据
    self.stepTextView.text = @"";
    //设置btn上的title
    [self.nextStep setTitle:self.stepTitles[self.step] forState:UIControlStateNormal];
    //设置图片和说明文案
    
}
#pragma mark--上一步
- (void)backLastStep{
    if (self.step==0) {
        //返回
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        //减一步
        self.step --;
        //设置返回按钮
        [self.lastStepBtn setTitle:@"返回" forState:UIControlStateNormal];
        //判断显示上一步按钮
        if (self.step ==1) {
            
        }
        //设置btn上的title
        [self.nextStep setTitle:self.stepTitles[self.step] forState:UIControlStateNormal];
    }

}

#pragma mark==============5，公用方法
#pragma mark--textView代理
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.24 animations:^{
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y -=216;
        self.view.frame = viewFrame;
    }];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.24 animations:^{
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y +=216;
        self.view.frame = viewFrame;
    }];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)cacheStep{
    targetStep *tStep = [[targetStep alloc]init];
    tStep.targetStepArray = self.stepsArray;
    tStep.targetId = self.targetId;
    //存储数据
    [yCache cacheTargetSteps:tStep];
}
@end
