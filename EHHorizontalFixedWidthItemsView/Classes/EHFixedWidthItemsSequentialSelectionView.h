//
//  EHFixedWidthItemsSequentialSelectionView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/22.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHHorizontalFixedWidthItemsView.h"
#import <EHItemViewCommon/EHItemViewDelegate.h>

@interface EHFixedWidthItemsSequentialSelectionView : EHHorizontalFixedWidthItemsView

@property (nonatomic, assign) BOOL allowsToCancel;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout;

- (void)makeIndexSelected:(NSInteger)index;

@end
