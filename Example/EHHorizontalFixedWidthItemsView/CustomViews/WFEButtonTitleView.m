//
//  WFEButtonTitleView.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/4.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "WFEButtonTitleView.h"
#import <Masonry/Masonry.h>
#import <YYCategories/UIImage+YYAdd.h>
#import <EHItemViewCommon/UIView+EHItemViewDelegate.h>

@interface WFEButtonTitleView ()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *label;

@end

@implementation WFEButtonTitleView

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title {
    self = [super init];
    if (self) {
        [self.button setImage:image forState:UIControlStateNormal];
        self.label.text = title;
        
        [self addSubview:self.button];
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self);
            make.centerX.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(60.0f, 60.0f));
        }];
        
        [self addSubview:self.label];
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.bottom.equalTo(self);
        }];
    }
    
    return self;
}

#pragma mark - event response

- (void)didTapButton:(UIButton *)sender {
    if ([self.eh_itemViewDelegate respondsToSelector:@selector(didTapControl:inView:)]) {
        [self.eh_itemViewDelegate didTapControl:sender inView:self];
    }
}

#pragma mark - getters & setters

- (UIButton *)button {
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeSystem];
        [_button setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        _button.clipsToBounds = YES;
        _button.layer.cornerRadius = 10.0f;
        _button.layer.borderWidth = 1.0f;
        _button.layer.borderColor = [UIColor colorWithRed:222/255.0 green:222/255.0 blue:222/255.0 alpha:1.0f].CGColor;
        [_button addTarget:self action:@selector(didTapButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _button;
}

- (UILabel *)label {
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor colorWithRed:102/255.0 green:102/255.0 blue:102/255.0 alpha:1.0f];
        _label.font = [UIFont systemFontOfSize:12.0f];
    }
    
    return _label;
}

@end
