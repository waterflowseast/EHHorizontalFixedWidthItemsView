//
//  WFELabel.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/19.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "WFELabel.h"

@implementation WFELabel

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
}

@end
