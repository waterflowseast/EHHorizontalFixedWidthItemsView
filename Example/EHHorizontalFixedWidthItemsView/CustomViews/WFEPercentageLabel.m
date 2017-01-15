//
//  WFEPercentageLabel.m
//  EHHorizontalFixedWidthItemsView
//
//  Created by Eric Huang on 17/1/15.
//  Copyright © 2017年 Eric Huang. All rights reserved.
//

#import "WFEPercentageLabel.h"

@implementation WFEPercentageLabel

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        self.text = text;
        self.textColor = [UIColor grayColor];
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        
        self.clipsToBounds = YES;
        self.layer.borderWidth = 1.0f;
        self.layer.borderColor = [UIColor redColor].CGColor;
        self.layer.cornerRadius = 3.0f;
        self.font = [UIFont systemFontOfSize:13.0f];
        self.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

- (void)didTapToSelected:(BOOL)selected {
    UIColor *color;
    CGFloat scale = 0;
    
    if (selected) {
        color = [UIColor redColor];
        scale = 1.2f;
    } else {
        color = [UIColor whiteColor];
        scale = 1.0f;
    }

    self.layer.backgroundColor = color.CGColor;
    self.transform = CGAffineTransformMakeScale(scale, scale);
}

- (void)didTapToAnimateToSelected:(BOOL)selected {
    UIColor *color;
    CGFloat scale = 0;

    if (selected) {
        color = [UIColor redColor];
        scale = 1.2f;
    } else {
        color = [UIColor whiteColor];
        scale = 1.0f;
    }
    
    [UIView animateWithDuration:0.35 animations:^{
        self.layer.backgroundColor = color.CGColor;
        self.transform = CGAffineTransformMakeScale(scale, scale);
    }];
}

- (void)didReactInPercentage:(CGFloat)percentage {
    UIColor *color = [self colorInPercentage:percentage];
    CGFloat scale = 1 + percentage * 0.2;
    
    self.layer.backgroundColor = color.CGColor;
    self.transform = CGAffineTransformMakeScale(scale, scale);
}

- (UIColor *)colorInPercentage:(CGFloat)percentage {
    CGFloat red0, green0, blue0, alpha0;
    CGFloat red1, green1, blue1, alpha1;
    CGFloat red, green, blue, alpha;
    
    [[UIColor whiteColor] getRed:&red0 green:&green0 blue:&blue0 alpha:&alpha0];
    [[UIColor redColor] getRed:&red1 green:&green1 blue:&blue1 alpha:&alpha1];
    
    red = (1 - percentage) * red0 + percentage * red1;
    green = (1 - percentage) * green0 + percentage * green1;
    blue = (1 - percentage) * blue0 + percentage * blue1;
    alpha = (1 - percentage) * alpha0 + percentage * alpha1;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
