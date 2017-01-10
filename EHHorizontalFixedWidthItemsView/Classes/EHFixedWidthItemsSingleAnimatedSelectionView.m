//
//  EHFixedWidthItemsSingleAnimatedSelectionView.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/27.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHFixedWidthItemsSingleAnimatedSelectionView.h"
#import "EHHorizontalFixedWidthLayout.h"
#import <EHItemViewCommon/UIView+EHItemViewDelegate.h>

@interface EHFixedWidthItemsSingleAnimatedSelectionView () <EHItemViewDelegate>

@property (nonatomic, strong, readwrite) EHHorizontalFixedWidthLayout *layout;
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

@end

@implementation EHFixedWidthItemsSingleAnimatedSelectionView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray<UIView<EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing {
    self = [super init];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        _layout = [[EHHorizontalFixedWidthLayout alloc] initWithNumberOfItems:items.count itemSize:itemSize insets:insets interitemSpacing:interitemSpacing];
        
        [self addToViewWithItems:items];
        _selectedIndex = -1;
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray<UIView<EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout {
    self = [super init];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        _layout = layout;
        
        [self addToViewWithItems:items];
        _selectedIndex = -1;
    }
    
    return self;
}

- (void)resetWithItems:(NSArray<UIView<EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing {
    for (UIView <EHItemViewDelegate> *item in items) {
        [self didTapView:item toSelected:NO];
    }
    
    [self removeGestureRecognizer:self.tapRecognizer];
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    _layout = [[EHHorizontalFixedWidthLayout alloc] initWithNumberOfItems:items.count itemSize:itemSize insets:insets interitemSpacing:interitemSpacing];
    
    [self addToViewWithItems:items];
    _selectedIndex = -1;
}

- (void)resetWithItems:(NSArray<UIView<EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout {
    for (UIView <EHItemViewDelegate> *item in items) {
        [self didTapView:item toSelected:NO];
    }
    
    [self removeGestureRecognizer:self.tapRecognizer];
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    _layout = layout;
    
    [self addToViewWithItems:items];
    _selectedIndex = -1;
}

- (CGFloat)totalHeight {
    return [self.layout totalHeight];
}

- (CGFloat)totalWidth {
    return [self.layout totalWidth];
}

- (void)makeIndexSelected:(NSInteger)index {
    self.selectedIndex = index;
    for (int i = 0; i < self.layout.numberOfItems; i++) {
        [self didTapView:[self itemViewAtIndex:i] toSelected:(i == index)];
    }
}

- (void)makeIndexSelectedWithAnimation:(NSInteger)index {
    if (self.selectedIndex < 0) {
        [self didTapView:[self itemViewAtIndex:index] animateToSelected:YES];
        self.selectedIndex = index;
    } else if (self.selectedIndex != index) {
        [self didTapView:[self itemViewAtIndex:self.selectedIndex] animateToSelected:NO];
        [self didTapView:[self itemViewAtIndex:index] animateToSelected:YES];
        self.selectedIndex = index;
    } else {
        [self didTapView:[self itemViewAtIndex:index] animateToSelected:NO];
        self.selectedIndex = -1;
    }
}

#pragma mark - EHItemViewDelegate

- (void)didTapControl:(UIControl *)control inView:(UIView *)view {
    [self didTapItemAtIndex:view.tag];
}

#pragma mark - event response

- (void)didTapControl:(UIControl *)sender {
    [self didTapItemAtIndex:sender.tag];
}

- (void)didTapView:(UITapGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self];
    NSInteger index = [self.layout indexForLocation:location];
    
    if (index >= 0 && index < self.layout.numberOfItems) {
        [self didTapItemAtIndex:index];
    }
}

#pragma mark - private methods

- (void)addToViewWithItems:(NSArray <UIView *> *)items {
    self.contentSize = CGSizeMake([self.layout totalWidth], [self.layout totalHeight]);
    
    for (int i = 0; i < items.count; i++) {
        UIView *itemView = items[i];
        itemView.tag = i;
        itemView.eh_itemViewDelegate = self;
        
        if (itemView.userInteractionEnabled && [itemView respondsToSelector:@selector(addTarget:action:forControlEvents:)]) {
            UIControl *itemControl = (UIControl *)itemView;
            [itemControl addTarget:self action:@selector(didTapControl:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        itemView.frame = CGRectMake([self.layout xForIndex:i],
                                    [self.layout yForIndex:i],
                                    self.layout.itemSize.width,
                                    self.layout.itemSize.height);
        [self addSubview:itemView];
    }
    
    [self addGestureRecognizer:self.tapRecognizer];
}

- (void)didTapItemAtIndex:(NSInteger)index {
    [self makeIndexSelectedWithAnimation:index];

    if ([self.tapDelegate respondsToSelector:@selector(didTapItemAtIndex:inView:)]) {
        [self.tapDelegate didTapItemAtIndex:index inView:self];
    }
}

- (void)didTapView:(UIView <EHItemViewDelegate> *)view toSelected:(BOOL)selected {
    if ([view respondsToSelector:@selector(didTapToSelected:)]) {
        [view didTapToSelected:selected];
    }
}

- (void)didTapView:(UIView <EHItemViewDelegate> *)view animateToSelected:(BOOL)selected {
    if ([view respondsToSelector:@selector(didTapToAnimateToSelected:)]) {
        [view didTapToAnimateToSelected:selected];
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

- (UITapGestureRecognizer *)tapRecognizer {
    if (!_tapRecognizer) {
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    }
    
    return _tapRecognizer;
}

@end
