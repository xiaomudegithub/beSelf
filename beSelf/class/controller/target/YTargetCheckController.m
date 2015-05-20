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
@property (weak, nonatomic) IBOutlet UIImageView *iconView;
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
//步骤按钮标题
@property (strong, nonatomic) NSArray *stepBtnTitles;
//步骤文案标题
@property (strong, nonatomic) NSMutableArray *stepLabelTitles;
//步骤icon
@property (strong, nonatomic) NSMutableArray *stepsIcon;


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
    //step
    self.step = 0;
    
    //headerView
    self.headerView.backgroundColor = bgColor;
    
    //stepTextView
    self.stepTextView.textColor = targetColor;
    self.stepTextView.layer.borderColor = targetColor.CGColor;
    self.stepTextView.layer.borderWidth = 0.33;
    self.stepTextView.layer.cornerRadius = 5;
    
    //iconView
    NSString *stepIconName = self.stepsIcon[self.step];
    self.iconView.image = [UIImage imageNamed:stepIconName];
    
    //stepDes
    self.stepDes.textColor = targetColor;
    self.stepDes.text = self.stepLabelTitles[self.step];
    
    //stepBtnTitles
    self.stepBtnTitles = @[@"第一步",@"第二步",@"第三步",@"第四步",@"最后一步"];
    
    
    
    //nextStep
    [self.nextStep setBackgroundColor:targetColor];
    [self.nextStep setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.nextStep setTitle:self.stepBtnTitles[self.step] forState:UIControlStateNormal];
    self.nextStep.layer.cornerRadius = 5;
    
    //关闭键盘
    UIButton *closeKeyBoardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    closeKeyBoardBtn.frame = CGRectMake(0, yUIScreenHeight-yViewTopInset-btnWidth_44, btnWidth_44, btnHeight_30);
    closeKeyBoardBtn.layer.cornerRadius =5;
    [closeKeyBoardBtn setTitle:@"关闭" forState:UIControlStateNormal];
    [closeKeyBoardBtn setBackgroundColor:targetColor];
    [closeKeyBoardBtn addTarget:self action:@selector(closeKeyBoard) forControlEvents:UIControlEventTouchUpInside];
    self.stepTextView.inputAccessoryView = closeKeyBoardBtn;
    
    
    //lastStepBtn
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.lastStepBtn];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"上一步" style:UIBarButtonItemStylePlain target:self action:@selector(backLastStep)];

    
}
#pragma mark--初始化控件
//上一步
- (UIButton *)lastStepBtn{
    if (!_lastStepBtn) {
        _lastStepBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _lastStepBtn.frame = CGRectMake(yUIScreenWidth-yViewTopInset-btnWidth_44, 0, btnWidth_60, btnWidth_44);
        [_lastStepBtn addTarget:self action:@selector(backLastStep) forControlEvents:UIControlEventTouchUpInside];
        [_lastStepBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        [_lastStepBtn setTitle:@"上一步" forState:UIControlStateNormal];
        _lastStepBtn.enabled = NO;
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
//步骤icon
- (NSMutableArray *)stepsIcon{
    if (!_stepsIcon) {
        _stepsIcon = [NSMutableArray array];
        
        for (NSInteger i = 1; i<=5; i++) {
            NSString *iconName = [NSString stringWithFormat:@"step%ld.png",i];
            [_stepsIcon addObject:iconName];
        }
    }
    return _stepsIcon;
}
- (NSMutableArray *)stepLabelTitles{
    if (!_stepLabelTitles) {
        _stepLabelTitles = [NSMutableArray array];
        
        NSString *stepLabel1 = @"万事开头难";
        [_stepLabelTitles addObject:stepLabel1];
        
        NSString *stepLabel2 = @"继往开来";
        [_stepLabelTitles addObject:stepLabel2];
        
        NSString *stepLabel3 = @"如日中天";
        [_stepLabelTitles addObject:stepLabel3];
        
        NSString *stepLabel4 = @"坚持就是胜利";
        [_stepLabelTitles addObject:stepLabel4];
        
        NSString *stepLabel5 = @"站好最后一班岗";
        [_stepLabelTitles addObject:stepLabel5];


    }
    return _stepLabelTitles;
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
    //设置返回上一步按钮可用
    self.lastStepBtn.enabled = YES;
    [_lastStepBtn setTitleColor:targetColor forState:UIControlStateNormal];
    [yAnimation fanYeUpWithView:self.headerView];
    
    //加一步
    self.step ++;
    //存储数据
    [self.stepsArray addObject:self.stepTextView.text];
    //清空数据
    self.stepTextView.text = @"";
    [self refreshUI];
}
#pragma mark--上一步
- (void)backLastStep{
    if (self.step==0) {
        //返回到上一步的按钮不可用
        self.lastStepBtn.enabled= NO;
        [_lastStepBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        
    }else{
        //减一步
        self.step --;
    
        [yAnimation fanYeDownWithView:self.headerView];
        [self refreshUI];
    }

}

#pragma mark==============5，公用方法
#pragma mark--textView代理
- (void)textViewDidBeginEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.24 animations:^{
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y -= self.headerView.frame.size.height;
        self.view.frame = viewFrame;
    }];
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    [UIView animateWithDuration:0.24 animations:^{
        CGRect viewFrame = self.view.frame;
        viewFrame.origin.y += self.headerView.frame.size.height;
        self.view.frame = viewFrame;
    }];
}
#pragma mark--关闭键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (void)closeKeyBoard{
    [self.view endEditing:YES];
}
#pragma mark--缓存数据
- (void)cacheStep{
    targetStep *tStep = [[targetStep alloc]init];
    tStep.targetSteps = self.stepsArray;
    tStep.targetId = self.targetId+1;
    //存储数据
    [yCache cacheTargetSteps:tStep];
}

- (void)refreshUI{
    //设置btn上的title
    [self.nextStep setTitle:self.stepBtnTitles[self.step] forState:UIControlStateNormal];
    //设置图片和说明文案
    //iconView
    NSString *stepIconName = self.stepsIcon[self.step];
    self.iconView.image = [UIImage imageNamed:stepIconName];
    //stepDes
    self.stepDes.text = self.stepLabelTitles[self.step];
}
@end
