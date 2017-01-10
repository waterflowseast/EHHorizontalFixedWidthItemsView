//
//  UIView+EHItemViewDelegate.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/4.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "EHItemViewDelegate.h"

@interface UIView (EHItemViewDelegate)

@property (nonatomic, assign) id<EHItemViewDelegate> eh_itemViewDelegate;

@end
