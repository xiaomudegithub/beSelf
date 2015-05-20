//
//  YTabbarController.m
//  beSelf1
//
//  Created by 木 on 15/3/16.
//  Copyright (c) 2015年 木. All rights reserved.
//

#import "YTabbarController.h"
#import "YTimeController.h"
#import "YMoneyController.h"
#import "YTargetController.h"
#import "YGrowUpController.h"

@interface YTabbarController ()<YTabBarDelegate>
//自定义tabbar
@property (strong, nonatomic)YTabBar *yBar;
@end

@implementation YTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //添加自定义tabbar
    [self.tabBar addSubview:self.yBar];
    
    //添加子控制器
    [self addChildController];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    for (UIControl *temp in self.tabBar.subviews) {
        if ([temp isKindOfClass:[UIControl class]]) {
            [temp removeFromSuperview];
        }
    }
}
- (void)addChildController{
    
    //添加个人成长控制器
    YGrowUpController *growUpController = [[YGrowUpController alloc]init];
    //growUpController.hidesBottomBarWhenPushed = YES;
    [self creatChildControllerWithController:growUpController andTitle:@"成长" andImageName:nil andColor:growColor];
    
    //添加目标管理控制器
    YTargetController *goalController = [[YTargetController alloc]init];
    //goalController.hidesBottomBarWhenPushed = YES;
    [self creatChildControllerWithController:goalController andTitle:@"目标" andImageName:nil andColor:targetColor];

    //添加时间管理控制器
    YTimeController *timeController = [[YTimeController alloc]init];
    //timeController.hidesBottomBarWhenPushed = YES;
    [self creatChildControllerWithController:timeController andTitle:@"时间" andImageName:@"time" andColor:timeColor];
 
    //添加财富管理控制器
    YMoneyController *moneyController = [[YMoneyController alloc]init];
    //moneyController.hidesBottomBarWhenPushed = YES;
    [self creatChildControllerWithController:moneyController andTitle:@"财富" andImageName:nil andColor:moneyColor];
   
}
#pragma mark--方法
- (void)creatChildControllerWithController:(UIViewController *)controller andTitle:(NSString *)title andImageName:(NSString *)imageName andColor:(UIColor *)color{
    //controller的属性
    controller.tabBarItem.title = title;
    controller.tabBarItem.image = [UIImage imageNamed:@"time"];
    controller.title = title;
    controller.view.backgroundColor = bgColor;
    //包装导航控制器
    YNavigationController *nav = [[YNavigationController alloc]initWithRootViewController:controller];
    
    //设置导航栏的字体属性
    [nav.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:color}];
    nav.backBtnTitle = @"返回";
    nav.backBtnColor = color;
    nav.rightBtnColor =color;
    
    //设置导航栏透明
    nav.navigationBar.translucent = NO;
    
    //lineView
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, margin_44, yUIScreenWidth, 2)];
    lineView.backgroundColor = color;
    [nav.navigationBar addSubview:lineView];
    
    [self addChildViewController:nav];
    
    //添加按钮
    [self.yBar addBtnWithTitle:title andNomalColor:[UIColor whiteColor] andSelectedColor:color];

}

- (void)didSeleckedBtnTag:(NSInteger)btnTag FromLastBtnTag:(NSInteger)lastBtnTag{
    self.selectedIndex = btnTag;
}
#pragma mark--初始化
- (YTabBar *)yBar{
    if (!_yBar) {
        _yBar = [[YTabBar alloc]initWithFrame:self.tabBar.bounds];
        _yBar.delegate = self;
    }
    return _yBar;
}

@end
