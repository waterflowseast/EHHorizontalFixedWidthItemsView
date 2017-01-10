//
//  WFEAnimatedLabel.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/27.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "WFEAnimatedLabel.h"

@implementation WFEAnimatedLabel

- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        self.text = text;
        self.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
        
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
    if (selected) {
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor redColor];
    } else {
        self.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    self.transform = CGAffineTransformMakeRotation(selected ? M_PI : 0);
}

- (void)didTapToAnimateToSelected:(BOOL)selected {
    if (selected) {
        self.textColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor redColor];
    } else {
        self.textColor = [UIColor blackColor];
        self.backgroundColor = [UIColor whiteColor];
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        self.transform = CGAffineTransformMakeRotation(selected ? M_PI : 0);
    }];
}

@end
