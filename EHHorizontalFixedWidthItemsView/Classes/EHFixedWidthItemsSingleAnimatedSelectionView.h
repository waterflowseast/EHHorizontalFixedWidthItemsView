//
//  EHFixedWidthItemsSingleAnimatedSelectionView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/27.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EHItemViewCommon/EHItemViewDelegate.h>

@class EHFixedWidthItemsSingleAnimatedSelectionView;

@protocol EHFixedWidthItemsSingleAnimatedSelectionViewDelegate <NSObject>

@optional
- (void)didTapItemAtIndex:(NSInteger)index inView:(EHFixedWidthItemsSingleAnimatedSelectionView *)view;

@end

@class EHHorizontalFixedWidthLayout;

@interface EHFixedWidthItemsSingleAnimatedSelectionView : UIScrollView

@property (nonatomic, assign) id<EHFixedWidthItemsSingleAnimatedSelectionViewDelegate> tapDelegate;

@property (nonatomic, strong, readonly) EHHorizontalFixedWidthLayout *layout;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout;

- (CGFloat)totalHeight;
- (CGFloat)totalWidth;

- (void)makeIndexSelected:(NSInteger)index;
- (void)makeIndexSelectedWithAnimation:(NSInteger)index;

@end
