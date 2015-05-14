//
//  YNavigationControllerViewController.m
//  beSelf
//
//  Created by 木柳 on 15/5/5.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YNavigationController.h"

@interface YNavigationController ()

@end

@implementation YNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.backgroundColor = yWhite;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)popself

{
    
    [self popViewControllerAnimated:YES];
    
}

-(UIBarButtonItem*) createBackButton

{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    [btn setBackgroundColor:[UIColor clearColor]];
    [btn setTitleColor:self.backBtnColor forState:UIControlStateNormal];
    [btn setTitle:self.backBtnTitle forState:UIControlStateNormal];
    
  
    CGSize btnSize = [nsstringTool sizeWithString:self.backBtnTitle andFont:btn.titleLabel.font.pointSize];
    btn.frame = CGRectMake(yViewTopInset, 0, btnSize.width, 44);
    return [[UIBarButtonItem alloc]initWithCustomView:btn];
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    
    [super pushViewController:viewController animated:animated];
    
    if (viewController.navigationItem.leftBarButtonItem== nil && [self.viewControllers count] > 1) {
        
        viewController.navigationItem.leftBarButtonItem =[self createBackButton];
        
    } 
    
}
@end
