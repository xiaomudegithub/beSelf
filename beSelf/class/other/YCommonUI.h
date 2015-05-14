//
//  YCommonUI.h
//  beSelf1
//
//  Created by 木 on 15/4/7.
//  Copyright (c) 2015年 木. All rights reserved.
//

#ifndef beSelf1_YCommonUI_h
#define beSelf1_YCommonUI_h

//==================== 公共控件布局 ==================

/**
 *  通用页面左右间距
 */
#define ySideInset 15

/**
 *  通用Section之间 组与组之间的间距
 */
#define ySectionSpace 33

/**
 *  通用标题栏和第一列之间的间距
 */
#define yViewTopInset 15



//==================== 公共控件列表，输入框 ===========

/**
 *  通用分割线背景色
 */
#define yLineColor [UIColor lightGrayColor]

/**
 *  通用分割线宽度
 */
#define yLineFont 1

/**
 *  通用单行列表高度
 */
#define yCellHeight 44

/**
 *  列表和输入框的小图标宽度
 */
#define ySmallIconWidth 24

/**
 *  列表和输入框的大图标宽度
 */
#define yBigIconWidth 40

/**
 *  通用列表标题字体大小
 */
#define yCellTitleFontSize 16

/**
 *  通用列表标题字体颜色
 */
#define yCellTitleColor [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f]


/**
 *  通用列表副标题文字、文本说明内容字体大小
 */
#define yCellSubTitleFontSize 14

/**
 *  通用列表副标题文字、文本说明内容字体颜色
 */
#define yCellSubTitleColor [UIColor colorWithRed:143.0f/255.0f green:143.0f/255.0f blue:149.0f/255.0f alpha:1.0f]

/**
 *  列表输入框输入字体大小
 */
#define yTextFieldTextFontSize 16

/**
 *  列表输入框输入字体颜色
 */
#define yTextFieldTextColor [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f]

/**
 *  列表输入框暗文字大小
 */
#define yTextFieldPlaceholdFontSize 15

/**
 *  列表输入框暗文字颜色
 */
#define yTextFieldPlaceholdColor [UIColor colorWithRGB:0xcccccc]

/**
 *  列表分组标题字体大小
 */
#define ySectionTitleFontSize 14

/**
 *  列表分组标题字体颜色
 */
#define ySectionTitleColor [UIColor colorWithRed:143.0f/255.0f green:143.0f/255.0f blue:149.0f/255.0f alpha:1.0f]

/**
 *  列表备注说明文案字号
 */
#define yFooterTextFontSize 14

/**
 *  列表备注说明文案颜色
 */
#define yFooterTextColor [UIColor colorWithRGB:0x8f8f95]
//==================== 设备宽高 ===========
#define yUIScreenWidth [UIScreen mainScreen].bounds.size.width
#define yUIScreenHeight [UIScreen mainScreen].bounds.size.height
//=======================工具宏===================
#define UIColorWithRGB(r, g, b) [UIColor colorWithRed:(r) / 255.f green:(g) / 255.f blue:(b) / 255.f alpha:1.f]
#define IsMock 0
#define YLog  NSLog
#define mData [[mockData alloc]init]
#define yCache [[cacheTool alloc]init]
#define yImage [[imageTool alloc]init]
//=======================颜色宏====================
#define growColor UIColorWithRGB(87, 186, 249)
#define targetColor UIColorWithRGB(255,149,0)
#define timeColor UIColorWithRGB(90,212,39)
#define moneyColor UIColorWithRGB(255, 219,76)
#define bgColor UIColorWithRGB(255,255,255)
#define yWhite [UIColor whiteColor];
//========================label==================
#define labelHeigh_14 14
#define labelHeigh_16 16
#define labelHeigh_30 30
//========================SegmentedControl==========
#define segHeight 30
//=======================margin=====================
#define margin_20 20
#define margin_64 64
//=======================btn=====================
//width
#define btnWidth_44 44
//height
#define btnHeight_30 30


#endif
