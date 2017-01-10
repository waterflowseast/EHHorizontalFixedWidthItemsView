//
//  EHHorizontalFixedWidthItemsView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/16.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EHItemViewCommon/EHTypeDefs.h>

@class EHHorizontalFixedWidthItemsView;

@protocol EHHorizontalFixedWidthItemsViewDelegate <NSObject>

@optional
- (void)didTapItemAtIndex:(NSInteger)index inView:(EHHorizontalFixedWidthItemsView *)view;

@end

@class EHHorizontalFixedWidthLayout;

@interface EHHorizontalFixedWidthItemsView : UIScrollView

@property (nonatomic, assign) BOOL allowsAnimationWhenTap;
@property (nonatomic, assign) NSTimeInterval animationDuration;
@property (nonatomic, copy) void (^animationBlock)(UIView *itemView, NSTimeInterval animationDuration, EHAnimationCompletionBlock animationCompletion);
@property (nonatomic, assign) id<EHHorizontalFixedWidthItemsViewDelegate> tapDelegate;

@property (nonatomic, strong, readonly) EHHorizontalFixedWidthLayout *layout;

- (instancetype)initWithItems:(NSArray <UIView *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (instancetype)initWithItems:(NSArray <UIView *> *)items layout:(EHHorizontalFixedWidthLayout *)layout;

- (void)resetWithItems:(NSArray <UIView *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (void)resetWithItems:(NSArray <UIView *> *)items layout:(EHHorizontalFixedWidthLayout *)layout;

- (CGFloat)totalHeight;
- (CGFloat)totalWidth;

@end
