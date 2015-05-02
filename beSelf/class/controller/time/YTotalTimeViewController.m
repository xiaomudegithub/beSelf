//
//  YTimeViewController.m
//  beSelf
//
//  Created by 木 on 15/4/22.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YTotalTimeViewController.h"

@interface YTotalTimeViewController ()<UITextFieldDelegate,YDatePickerViewDelegate>
//属性
@property (weak, nonatomic) IBOutlet UILabel *timeTotalLab;
@property (weak, nonatomic) IBOutlet UILabel *currentTime;
@property (weak, nonatomic) IBOutlet UITextField *startTimeText;
@property (weak, nonatomic) IBOutlet UITextField *endTimeText;
@property (weak, nonatomic) IBOutlet UIButton *cofirmBtn;

//方法
- (IBAction)confirm:(UIButton *)sender;

/**
 *  日期选择器
 */
@property (nonatomic,strong)YDatePickerView *datePicker;
/**
 *  开始时间或者结束时间
 */
@property(nonatomic,assign)BOOL startOrEnd;
@end

@implementation YTotalTimeViewController
#pragma mark--0,生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setUpEverything];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark=====================1,初始化控件
#pragma mark--初始化控件
- (void)setUpEverything{
    //totalTimeLab
    self.timeTotalLab.text = [[NSUserDefaults standardUserDefaults]valueForKey:@"timeTotal"];
    
    //currentTime
    self.currentTime.text = [timeTool getCurrentTimeWithFormat:@"YYYY/MM/dd"];
    self.startTimeText.layer.borderColor = UIColorWithRGB(110, 253, 103).CGColor;
    
    //datePicker
    [self.view addSubview:self.datePicker];
    
    //导航栏
    [self setUpNavBar];
}
#pragma mark--导航栏
- (void)setUpNavBar{
    self.title = @"时间总额";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didBack)];
}
- (void)didBack{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}
#pragma mark--日期选择器
- (YDatePickerView *)datePicker{
    if (!_datePicker) {
        _datePicker = [[YDatePickerView alloc]initWithFrame:CGRectMake(0, yUIScreenHeight, yUIScreenWidth, 216)];
        _datePicker.delegate = self;
    }
    return _datePicker;
}
#pragma mark=====================2,获取数据
- (void)didSelectDate:(NSString *)date{
    if (self.startOrEnd) {
        self.startTimeText.text = date;
    }else{
        self.endTimeText.text = date;
    }
}
#pragma mark=====================3,存储数据
- (IBAction)confirm:(UIButton *)sender {
    NSInteger days = [timeTool daysWithStartDay:self.startTimeText.text andEndDay:self.endTimeText.text andFormat:@"YYYY/MM/dd"];
    self.timeTotalLab.text = [NSString stringWithFormat:@"%ld",days];
    [[NSUserDefaults standardUserDefaults]setObject:self.timeTotalLab.text forKey:@"timeTotal"];
}
#pragma mark=====================delegate
#pragma mark=====================公用方法
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.datePicker closeDatePicker ];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField == self.startTimeText) {
        self.startOrEnd = YES;
    }else if (textField == self.endTimeText){
        self.startOrEnd = NO;
    }
    textField.placeholder = @"";
    [self.datePicker openDatePicker];
    return NO;
}

@end
