//
//  EHHorizontalFixedWidthItemsSelectionView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/19.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHHorizontalFixedWidthItemsView.h"
#import <EHItemViewCommon/EHItemViewDelegate.h>
#import <EHItemViewCommon/EHItemViewSelectionDelegate.h>

@interface EHHorizontalFixedWidthItemsSelectionView : EHHorizontalFixedWidthItemsView

@property (nonatomic, assign) BOOL allowsMultipleSelection;
@property (nonatomic, assign) BOOL allowsToCancelWhenSingleSelection;
@property (nonatomic, assign) NSUInteger maxSelectionsAllowed;
@property (nonatomic, assign) id<EHHorizontalFixedWidthItemsViewDelegate, EHItemViewSelectionDelegate> tapDelegate;

@property (nonatomic, assign, readonly) NSInteger selectedIndex;
@property (nonatomic, strong, readonly) NSMutableSet *selectedIndexes;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout;

- (void)makeIndexSelected:(NSInteger)index;
- (void)makeIndexesSelected:(NSSet <NSNumber *> *)indexes;

@end
