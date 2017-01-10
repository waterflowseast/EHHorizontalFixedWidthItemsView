//
//  EHHorizontalFixedWidthLayout.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/16.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EHHorizontalFixedWidthLayout : NSObject

@property (nonatomic, assign, readonly) NSInteger numberOfItems;
@property (nonatomic, assign, readonly) CGSize itemSize;

@property (nonatomic, assign, readonly) UIEdgeInsets insets;
@property (nonatomic, assign, readonly) CGFloat interitemSpacing;

- (instancetype)initWithNumberOfItems:(NSInteger)numberOfItems itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (CGFloat)totalHeight;
- (CGFloat)totalWidth;

- (CGFloat)xForIndex:(NSInteger)index;
- (CGFloat)yForIndex:(NSInteger)index;

- (NSInteger)indexForLocation:(CGPoint)location;

@end
