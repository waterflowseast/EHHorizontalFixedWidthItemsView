//
//  EHHorizontalFixedWidthItemsSelectionView.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/19.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHHorizontalFixedWidthItemsSelectionView.h"
#import "EHHorizontalFixedWidthLayout.h"

@interface EHHorizontalFixedWidthItemsSelectionView ()

@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
@property (nonatomic, strong, readwrite) NSMutableSet *selectedIndexes;

@end

@implementation EHHorizontalFixedWidthItemsSelectionView

@synthesize tapDelegate = tapDelegate_;

- (instancetype)initWithItems:(NSArray<UIView<EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing {
    self = [super initWithItems:items itemSize:itemSize insets:insets interitemSpacing:interitemSpacing];
    if (self) {
        _maxSelectionsAllowed = items.count;
        _selectedIndex = -1;
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray<UIView<EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout {
    self = [super initWithItems:items layout:layout];
    if (self) {
        _maxSelectionsAllowed = items.count;
        _selectedIndex = -1;
    }
    
    return self;
}

- (void)resetWithItems:(NSArray<UIView<EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing {
    for (UIView <EHItemViewDelegate> *item in items) {
        [self didTapView:item toSelected:NO];
    }

    [super resetWithItems:items itemSize:itemSize insets:insets interitemSpacing:interitemSpacing];
    _maxSelectionsAllowed = items.count;
    _selectedIndex = -1;
    _selectedIndexes = nil;
}

- (void)resetWithItems:(NSArray<UIView<EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout {
    for (UIView <EHItemViewDelegate> *item in items) {
        [self didTapView:item toSelected:NO];
    }
    
    [super resetWithItems:items layout:layout];
    _maxSelectionsAllowed = items.count;
    _selectedIndex = -1;
    _selectedIndexes = nil;
}

- (void)makeIndexSelected:(NSInteger)index {
    if (self.allowsMultipleSelection) {
        return;
    }
    
    self.selectedIndex = index;
    for (int i = 0; i < self.layout.numberOfItems; i++) {
        [self didTapView:[self itemViewAtIndex:i] toSelected:(i == index)];
    }
}

- (void)makeIndexesSelected:(NSSet<NSNumber *> *)indexes {
    if (!self.allowsMultipleSelection || indexes.count > self.maxSelectionsAllowed) {
        return;
    }
    
    self.selectedIndexes = [NSMutableSet setWithSet:indexes];
    for (int i = 0; i < self.layout.numberOfItems; i++) {
        [self didTapView:[self itemViewAtIndex:i] toSelected:([indexes containsObject:@(i)])];
    }
}

#pragma mark - private methods

- (void)didTapItemAtIndex:(NSInteger)index {
    if (!self.allowsMultipleSelection) {
        // single selection
        
        if (self.selectedIndex < 0) {
            [self didTapView:[self itemViewAtIndex:index] toSelected:YES];
            self.selectedIndex = index;
        } else if (self.selectedIndex != index) {
            [self didTapView:[self itemViewAtIndex:self.selectedIndex] toSelected:NO];
            [self didTapView:[self itemViewAtIndex:index] toSelected:YES];
            self.selectedIndex = index;
        } else if (self.allowsToCancelWhenSingleSelection) {
            [self didTapView:[self itemViewAtIndex:index] toSelected:NO];
            self.selectedIndex = -1;
        } else {
            return;
        }
    } else {
        // multiple selections
        
        if ([self.selectedIndexes containsObject:@(index)]) {
            [self didTapView:[self itemViewAtIndex:index] toSelected:NO];
            [self.selectedIndexes removeObject:@(index)];
        } else if (self.selectedIndexes.count < self.maxSelectionsAllowed) {
            [self didTapView:[self itemViewAtIndex:index] toSelected:YES];
            [self.selectedIndexes addObject:@(index)];
        } else {
            if ([self.tapDelegate respondsToSelector:@selector(didTapExceedingLimitInView:maxSelectionsAllowed:)]) {
                [self.tapDelegate didTapExceedingLimitInView:self maxSelectionsAllowed:self.maxSelectionsAllowed];
            }
            
            return;
        }
    }
    
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

#pragma mark - getters & setters

- (NSMutableSet *)selectedIndexes {
    if (!_selectedIndexes) {
        _selectedIndexes = [[NSMutableSet alloc] init];
    }
    
    return _selectedIndexes;
}

@end
