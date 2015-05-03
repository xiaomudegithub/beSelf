//
//  YMoneyTotalController.m
//  beSelf
//
//  Created by 木 on 15/4/21.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YMoneyTotalController.h"
#import "YMoneyRecordController.h"

@interface YMoneyTotalController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet yLabel *currentTime;
@property (weak, nonatomic) IBOutlet yLabel *totalMoneyLabel;
@property (weak, nonatomic) IBOutlet yLabel *bottomLabel;
@property (weak, nonatomic) IBOutlet UIButton *inBtn;
@property (weak, nonatomic) IBOutlet UIButton *confrimBtn;
@property (weak, nonatomic) IBOutlet UITextField *moneyValueText;
@property (weak, nonatomic) IBOutlet UITextField *moneyAttentionText;
@property (weak, nonatomic) IBOutlet UIButton *outBtn;
- (IBAction)selectIn:(UIButton *)sender;
- (IBAction)selectOut:(UIButton *)sender;
- (IBAction)didConfirm:(UIButton *)sender;

/**
 *  收支记录
 */
@property (nonatomic,strong)moneyRecord *mRecord;
/**
 *  totalMoney
 */
@property (nonatomic,copy)NSString *totalMoney;

@end

@implementation YMoneyTotalController
#pragma mark--0,生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setViewContent];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark--1,初始化控件属性
- (void)setViewContent{
    //confirmBtn
    _confrimBtn.layer.cornerRadius = 8;
    
    //_currentTime
    _currentTime.text = [timeTool getCurrentTimeWithFormat:@"YYYY/MM/dd"];
    
    //_totalMoney
    _totalMoney = [[NSUserDefaults standardUserDefaults] valueForKey:@"totalMoney"];
    self.totalMoneyLabel.text = self.totalMoney;
    
    //_bottomLabel
    _bottomLabel.text =  @"开源节流";
    
    //moneyValueText
    _moneyValueText.textColor = UIColorWithRGB(136, 254, 237);
    _moneyValueText.layer.borderColor = [UIColorWithRGB(136, 254, 237) CGColor];
    _moneyAttentionText.textColor = UIColorWithRGB(136, 254, 237);
    _moneyAttentionText.layer.borderColor = [UIColorWithRGB(136, 254, 237) CGColor];
    
    //导航栏
    [self setUpNavBar];
    
    //mRecord
    self.mRecord = [[moneyRecord alloc]init];
}
//初始化导航栏
- (void)setUpNavBar{
    self.title = @"财富";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(didBack)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"收支" style:UIBarButtonItemStylePlain target:self action:@selector(checkMoney)];
}
- (void)didBack{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)checkMoney{
    YMoneyRecordController *record = [[YMoneyRecordController alloc]init];
    [self.navigationController pushViewController:record animated:YES];
}
#pragma mark--2,选择类型：收入或是支出
//收入
- (IBAction)selectIn:(UIButton *)sender {
    self.mRecord.type = @"收入";
    sender.selected = YES;
    self.outBtn.selected = NO;
}
//选择支出
- (IBAction)selectOut:(UIButton *)sender {
    self.mRecord.type = @"支出";
    sender.selected = YES;
    self.inBtn.selected = NO;
}
#pragma mark--3，确认
- (IBAction)didConfirm:(UIButton *)sender {
    [self.view endEditing:YES];
    //缓存收支记录
    [yCache cacheMoneyRecord:self.mRecord];
    //获取totalMoney
    if (self.outBtn.selected) {
        CGFloat tempTotalMoney = [self.totalMoney floatValue] - [self.moneyValueText.text floatValue];
        self.totalMoney = [NSString stringWithFormat:@"%2.f",tempTotalMoney];
    }else if(self.inBtn.selected){
        CGFloat tempTotalMoney = [self.totalMoney floatValue] + [self.moneyValueText.text floatValue];
        self.totalMoney = [NSString stringWithFormat:@"%.2f",tempTotalMoney];
    }
    //保存totalMoney
    [self saveTotalMoney];
    //设置totalMoneyLabel
    self.totalMoneyLabel.text = self.totalMoney;

}
#pragma mark--4，save
- (void)saveTotalMoney{
    [[NSUserDefaults standardUserDefaults] setObject:self.totalMoney forKey:@"totalMoney"];
}

#pragma mark--delegate
//textfield's delegate
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    return YES;
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y -=200;
            self.view.frame = frame;
        }];
}
- (void)textFieldDidEndEditing:(UITextField *)textField{
    if (textField == self.moneyAttentionText) {
        self.mRecord.subTitle = textField.text;
    }else if (textField == self.moneyValueText){
        self.mRecord.value = textField.text;
    }
        [UIView animateWithDuration:0.25 animations:^{
            CGRect frame = self.view.frame;
            frame.origin.y +=200;
            self.view.frame = frame;
        }];
}
#pragma mark--共用方法
@end
