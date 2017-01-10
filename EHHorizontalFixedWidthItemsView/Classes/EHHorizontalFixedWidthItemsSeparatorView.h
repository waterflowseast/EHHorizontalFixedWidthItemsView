//
//  EHHorizontalFixedWidthItemsSeparatorView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/22.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHHorizontalFixedWidthItemsView.h"

@interface EHHorizontalFixedWidthItemsSeparatorView : EHHorizontalFixedWidthItemsView

- (instancetype)initWithItems:(NSArray<UIView *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

- (instancetype)initWithItems:(NSArray<UIView *> *)items layout:(EHHorizontalFixedWidthLayout *)layout separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

- (void)resetWithItems:(NSArray<UIView *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

- (void)resetWithItems:(NSArray<UIView *> *)items layout:(EHHorizontalFixedWidthLayout *)layout separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

@end
