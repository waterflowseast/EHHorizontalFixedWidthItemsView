//
//  EHHorizontalFixedWidthLayout.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/16.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHHorizontalFixedWidthLayout.h"

@interface EHHorizontalFixedWidthLayout ()

@property (nonatomic, assign, readwrite) NSInteger numberOfItems;
@property (nonatomic, assign, readwrite) CGSize itemSize;

@property (nonatomic, assign, readwrite) UIEdgeInsets insets;
@property (nonatomic, assign, readwrite) CGFloat interitemSpacing;

@end

@implementation EHHorizontalFixedWidthLayout

- (instancetype)initWithNumberOfItems:(NSInteger)numberOfItems itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing {
    self = [super init];
    if (self) {
        _numberOfItems = numberOfItems;
        _itemSize = itemSize;
        _insets = insets;
        _interitemSpacing = interitemSpacing;
    }
    
    return self;
}

- (CGFloat)totalHeight {
    return self.insets.top + self.itemSize.height + self.insets.bottom;
}

- (CGFloat)totalWidth {
    return self.insets.left + self.numberOfItems * self.itemSize.width + (self.numberOfItems - 1) * self.interitemSpacing + self.insets.right;
}

- (CGFloat)xForIndex:(NSInteger)index {
    return self.insets.left + index * (self.itemSize.width + self.interitemSpacing);
}

- (CGFloat)yForIndex:(NSInteger)index {
    return self.insets.top;
}

- (NSInteger)indexForLocation:(CGPoint)location {
    if (location.x <= self.insets.left) {
        return -1; // 落在第一个item的左边界之内
    }
    
    if (location.x >= self.insets.left + self.numberOfItems * self.itemSize.width + (self.numberOfItems - 1) * self.interitemSpacing) {
        return -1; // 落在最后一个item的右边界之外
    }
    
    CGFloat tempWidth = location.x - self.insets.left;
    NSInteger count = (int)floorf(tempWidth / (self.itemSize.width + self.interitemSpacing));
    CGFloat remainingWidth = tempWidth - count * (self.itemSize.width + self.interitemSpacing);
    
    if (remainingWidth >= self.itemSize.width) {
        return -1; // 落在空隙之间
    }
    
    return count < self.numberOfItems ? count : -1;
}

@end
