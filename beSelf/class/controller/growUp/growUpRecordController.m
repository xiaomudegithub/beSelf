//
//  growUpRecordController.m
//  beSelf
//
//  Created by 木 on 15/4/9.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "growUpRecordController.h"

@interface growUpRecordController ()<UITextFieldDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet yLabel *timeLab;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic, strong)growUpRootObject   *growObject;
//saveBtn
@property (strong, nonatomic) UIButton *saveBtn;
@end

@implementation growUpRecordController
#pragma mark==============1,生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"温故而知新，可以为师矣";
    self.view.backgroundColor = bgColor;
    if (!self.growLastObj) {
        self.title = @"千里之行，始于足下";
    }
    
    
    [self setControllItem];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark==============2，UI搭建
//初始化
- (void)setControllItem{
    
    //titleTextField
    self.titleTextField.text = self.growLastObj.object.title;
    self.titleTextField.textColor = growColor;
    self.titleTextField.delegate = self;
    
    //timeLabel
    self.timeLab.text = [timeTool getCurrentTimeWithFormat:@"YYYY/MM/dd"];
    self.timeLab.textColor = growColor;
    
    //line
    self.lineView.backgroundColor = growColor;
    
    //contentTextView
    self.contentTextView.backgroundColor = [UIColor clearColor];
    self.contentTextView.layer.borderColor = growColor.CGColor;
    self.contentTextView.layer.cornerRadius = 5;
    self.contentTextView.text = self.growLastObj.object.subTitle;
    self.contentTextView.textColor = growColor;
    self.contentTextView.layer.borderWidth = 0.33;
    self.contentTextView.delegate = self;
    
    //saveBtn
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.saveBtn];
    
}
//growObject
- (growUpRootObject *)growObject{
    if (!_growObject) {
        _growObject = [[growUpRootObject alloc]init];
        _growObject.object.time = [timeTool getCurrentTimeWithFormat:@"YYYY/MM/dd"];
    }
    return _growObject;
}
//saveBtn
- (UIButton *)saveBtn{
    if (!_saveBtn) {
        _saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];

        _saveBtn.backgroundColor = [UIColor clearColor];
        [_saveBtn setTitle:@"保存" forState:UIControlStateNormal];
        CGSize btnSize = [nsstringTool sizeWithString:_saveBtn.titleLabel.text andFont:_saveBtn.titleLabel.font.pointSize];
        _saveBtn.frame = CGRectMake(yUIScreenWidth - btnWidth_44, 0, btnSize.width, btnWidth_44);
        [_saveBtn addTarget:self action:@selector(save:) forControlEvents:UIControlEventTouchUpInside];
        [_saveBtn setTitleColor:growColor forState:UIControlStateNormal];
        
    }
    return _saveBtn;
}

#pragma mark==============3，数据渲染

#pragma mark==============4，操作
#pragma mark--4.1,存储数据并返回
- (void)save:(id)sender{
    //3.1存储数据
    if (self.growLastObj) {
        growUpParam *param = [[growUpParam alloc]init];
        param.growId = self.growUpId+1;
        param.growObj = self.growLastObj;
        [yCache updateGrowUpRecord:param];
    }else{
        [yCache cacheGrowUpRecord:self.growObject];
    }
    //3.2.1通知代理
    if([self.delegate respondsToSelector:@selector(didSaveGrowUpRecord)]){
        [self.delegate didSaveGrowUpRecord];
    };
    //3.2返回
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark==============5，公用方法
#pragma mark--textField_delegate
//更改标题
- (void)textFieldDidEndEditing:(UITextField *)textField{
    self.growObject.object.title = textField.text;
    self.growLastObj.object.title = textField.text;
}
//关闭键盘
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
#pragma mark--textView_delegate
- (void)textViewDidChange:(UITextView *)textView{
    self.growObject.object.subTitle = textView.text;
    self.growLastObj.object.subTitle = textView.text;
}


@end
