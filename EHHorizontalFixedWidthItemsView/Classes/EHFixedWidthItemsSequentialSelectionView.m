//
//  EHFixedWidthItemsSequentialSelectionView.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/22.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHFixedWidthItemsSequentialSelectionView.h"
#import "EHHorizontalFixedWidthLayout.h"

@interface EHFixedWidthItemsSequentialSelectionView ()

@property (nonatomic, assign, readwrite) NSInteger selectedIndex;

@end

@implementation EHFixedWidthItemsSequentialSelectionView

- (instancetype)initWithItems:(NSArray<UIView<EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing {
    self = [super initWithItems:items itemSize:itemSize insets:insets interitemSpacing:interitemSpacing];
    if (self) {
        _selectedIndex = -1;
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray<UIView<EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout {
    self = [super initWithItems:items layout:layout];
    if (self) {
        _selectedIndex = -1;
    }
    
    return self;
}

- (void)resetWithItems:(NSArray<UIView<EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing {
    for (UIView <EHItemViewDelegate> *item in items) {
        [self didTapView:item toSelected:NO];
    }
    
    [super resetWithItems:items itemSize:itemSize insets:insets interitemSpacing:interitemSpacing];
    _selectedIndex = -1;
}

- (void)resetWithItems:(NSArray<UIView<EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout {
    for (UIView <EHItemViewDelegate> *item in items) {
        [self didTapView:item toSelected:NO];
    }
    
    [super resetWithItems:items layout:layout];
    _selectedIndex = -1;
}

- (void)makeIndexSelected:(NSInteger)index {
    if (index < 0 || index >= self.layout.numberOfItems) {
        return;
    }
    
    self.selectedIndex = index;
    [self makeSequentialSelections];
}

#pragma mark - private methods

- (void)makeSequentialSelections {
    for (int i = 0; i < self.layout.numberOfItems; i++) {
        [self didTapView:[self itemViewAtIndex:i] toSelected:(i <= self.selectedIndex)];
    }
}

- (void)didTapItemAtIndex:(NSInteger)index {
    if (self.selectedIndex != index) {
        self.selectedIndex = index;
    } else if (self.allowsToCancel) {
        self.selectedIndex = -1;
    } else {
        return;
    }
    
    [self makeSequentialSelections];
    [self copyVersionOfDidTapItemAtIndex:index];
}

- (void)copyVersionOfDidTapItemAtIndex:(NSInteger)index {
    if (!self.allowsAnimationWhenTap) {
        if ([self.tapDelegate respondsToSelector:@selector(didTapItemAtIndex:inView:)]) {
            [self.tapDelegate didTapItemAtIndex:index inView:self];
        }
        
        return;
    }
    
    // animation!
    UIView *itemView = [self itemViewAtIndex:index];
    
    CGFloat duration = self.animationDuration > 0 ? self.animationDuration : 0.4;
    
    if (self.animationBlock) {
        __weak typeof(self) weakSelf = self;
        
        self.animationBlock(itemView, duration, ^(BOOL finished) {
            __strong typeof(self) strongSelf = weakSelf;
            
            if (finished && [strongSelf.tapDelegate respondsToSelector:@selector(didTapItemAtIndex:inView:)]) {
                [strongSelf.tapDelegate didTapItemAtIndex:index inView:strongSelf];
            }
        });
        
        return;
    }
    
    [UIView
     animateKeyframesWithDuration:duration
     delay:0
     options:UIViewKeyframeAnimationOptionCalculationModeLinear
     animations:^{
         [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
             itemView.transform = CGAffineTransformMakeScale(1.1, 1.1);
         }];
         
         [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
             itemView.transform = CGAffineTransformMakeScale(1.0, 1.0);
         }];
     } completion:^(BOOL finished) {
         if (finished && [self.tapDelegate respondsToSelector:@selector(didTapItemAtIndex:inView:)]) {
             [self.tapDelegate didTapItemAtIndex:index inView:self];
         }
     }];
}

- (void)didTapView:(UIView <EHItemViewDelegate> *)view toSelected:(BOOL)selected {
    if ([view respondsToSelector:@selector(didTapToSelected:)]) {
        [view didTapToSelected:selected];
    }
}

- (UIView <EHItemViewDelegate> *)itemViewAtIndex:(NSInteger)index {
    UIView *itemView = [self viewWithTag:index];
    
    // if it's myself, find it in my subviews
    if ([self isEqual:itemView]) {
        for (UIView *subView in self.subviews) {
            itemView = [subView viewWithTag:index];
            
            if (itemView) {
                break;
            }
        }
    }
    
    return (UIView <EHItemViewDelegate> *)itemView;
}

@end
