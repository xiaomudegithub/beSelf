//
//  FTTitleSectionView.m
//  FTLoan
//
//  Created by chenchen.lcc on 15-3-11.
//  Copyright (c) 2015年 Alipay. All rights reserved.
//

#import "titleSectionView.h"
#import "SectionObject.h"

@interface titleSectionView()

@property (nonatomic, strong) yLabel *textLabel;

@end

@implementation titleSectionView

- (void)dealloc
{
    _textLabel = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = yWhite;
        _textLabel = [[yLabel alloc] init];
        _textLabel.font = [UIFont systemFontOfSize:ySectionTitleFontSize];
        _textLabel.textColor = ySectionTitleColor;
        _textLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:_textLabel];
    }
    return self;
}

- (void)setContentWithObject:(id) objectData AtSection:(NSNumber *) sectionNum
{
    SectionObject *tmpObj = [objectData objectAtIndex:[sectionNum integerValue]];
    _textLabel.text = tmpObj.titleString;
    _textLabel.frame = (CGRect){ySideInset,0,yUIScreenWidth - 2*ySideInset,tmpObj.sectionHight};
}

@end
