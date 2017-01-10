//
//  EHFixedWidthItemsSingleAnimatedSelectionSeparatorView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/27.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHFixedWidthItemsSingleAnimatedSelectionView.h"

@interface EHFixedWidthItemsSingleAnimatedSelectionSeparatorView : EHFixedWidthItemsSingleAnimatedSelectionView

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout separatorSize:(CGSize)separatorSize separatorColor:(UIColor *)separatorColor;

@end
