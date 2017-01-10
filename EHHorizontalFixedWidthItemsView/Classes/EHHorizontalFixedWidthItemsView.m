//
//  EHHorizontalFixedWidthItemsView.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/16.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHHorizontalFixedWidthItemsView.h"
#import "EHHorizontalFixedWidthLayout.h"
#import <EHItemViewCommon/UIView+EHItemViewDelegate.h>

@interface EHHorizontalFixedWidthItemsView () <EHItemViewDelegate>

@property (nonatomic, strong, readwrite) EHHorizontalFixedWidthLayout *layout;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

@end

@implementation EHHorizontalFixedWidthItemsView

- (instancetype)init {
    self = [super init];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray<UIView *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing {
    self = [super init];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        _layout = [[EHHorizontalFixedWidthLayout alloc] initWithNumberOfItems:items.count itemSize:itemSize insets:insets interitemSpacing:interitemSpacing];
        
        [self addToViewWithItems:items];
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray<UIView *> *)items layout:(EHHorizontalFixedWidthLayout *)layout {
    self = [super init];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        _layout = layout;
        
        [self addToViewWithItems:items];
    }
    
    return self;
}

- (void)resetWithItems:(NSArray<UIView *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing {
    [self removeGestureRecognizer:self.tapRecognizer];
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    _layout = [[EHHorizontalFixedWidthLayout alloc] initWithNumberOfItems:items.count itemSize:itemSize insets:insets interitemSpacing:interitemSpacing];
    
    [self addToViewWithItems:items];
}

- (void)resetWithItems:(NSArray<UIView *> *)items layout:(EHHorizontalFixedWidthLayout *)layout {
    [self removeGestureRecognizer:self.tapRecognizer];
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    _layout = layout;
    
    [self addToViewWithItems:items];
}

- (CGFloat)totalHeight {
    return [self.layout totalHeight];
}

- (CGFloat)totalWidth {
    return [self.layout totalWidth];
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
    if (!self.allowsAnimationWhenTap) {
        if ([self.tapDelegate respondsToSelector:@selector(didTapItemAtIndex:inView:)]) {
            [self.tapDelegate didTapItemAtIndex:index inView:self];
        }
        
        return;
    }
    
    // animation!
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

#pragma mark - getters & setters

- (UITapGestureRecognizer *)tapRecognizer {
    if (!_tapRecognizer) {
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    }
    
    return _tapRecognizer;
}

@end
