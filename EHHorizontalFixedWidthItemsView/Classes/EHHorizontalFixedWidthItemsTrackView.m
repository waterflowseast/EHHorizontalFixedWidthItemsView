//
//  EHHorizontalFixedWidthItemsTrackView.m
//  Pods
//
//  Created by Eric Huang on 17/1/14.
//
//

#import "EHHorizontalFixedWidthItemsTrackView.h"
#import "EHHorizontalFixedWidthLayout.h"
#import <EHItemViewCommon/UIView+EHItemViewDelegate.h>

static NSTimeInterval const kAnimationDuration = 0.35;

@interface EHHorizontalFixedWidthItemsTrackView () <EHItemViewDelegate>

@property (nonatomic, strong, readwrite) EHHorizontalFixedWidthLayout *layout;
@property (nonatomic, assign, readwrite) NSInteger selectedIndex;
@property (nonatomic, assign, readwrite) CGFloat trackHeight;
@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;
@property (nonatomic, strong) UIView *trackView;

@end

@implementation EHHorizontalFixedWidthItemsTrackView

- (void)commonInit {
    self.showsHorizontalScrollIndicator = NO;
    _trackWidthPercent = 1.0f;
    _trackCornerRadius = 0;
    _trackColor = [UIColor redColor];
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self commonInit];
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing trackHeight:(CGFloat)trackHeight {
    self = [super init];
    if (self) {
        [self commonInit];

        _layout = [[EHHorizontalFixedWidthLayout alloc] initWithNumberOfItems:items.count itemSize:itemSize insets:insets interitemSpacing:interitemSpacing];
        _trackHeight = trackHeight;

        [self addToViewWithItems:items];
        _selectedIndex = 0;
        [self addTrackView];
        
        [self didTapView:[self itemViewAtIndex:_selectedIndex] toSelected:YES];
    }
    
    return self;
}

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout trackHeight:(CGFloat)trackHeight {
    self = [super init];
    if (self) {
        [self commonInit];
        
        _layout = layout;
        _trackHeight = trackHeight;
        
        [self addToViewWithItems:items];
        _selectedIndex = 0;
        [self addTrackView];
        
        [self didTapView:[self itemViewAtIndex:_selectedIndex] toSelected:YES];
    }
    
    return self;
}

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing trackHeight:(CGFloat)trackHeight {
    [self removeGestureRecognizer:self.tapRecognizer];
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    _layout = [[EHHorizontalFixedWidthLayout alloc] initWithNumberOfItems:items.count itemSize:itemSize insets:insets interitemSpacing:interitemSpacing];
    _trackHeight = trackHeight;
    
    [self addToViewWithItems:items];
    _selectedIndex = 0;
    [self addTrackView];
    
    for (int i = 0; i < self.layout.numberOfItems; i++) {
        [self didTapView:[self itemViewAtIndex:i] toSelected:(i == self.selectedIndex)];
    }
}

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout trackHeight:(CGFloat)trackHeight {
    [self removeGestureRecognizer:self.tapRecognizer];
    for (UIView *subview in self.subviews) {
        [subview removeFromSuperview];
    }
    
    _layout = layout;
    _trackHeight = trackHeight;
    
    [self addToViewWithItems:items];
    _selectedIndex = 0;
    [self addTrackView];
    
    for (int i = 0; i < self.layout.numberOfItems; i++) {
        [self didTapView:[self itemViewAtIndex:i] toSelected:(i == self.selectedIndex)];
    }
}

- (CGFloat)totalHeight {
    return [self.layout totalHeight] + self.trackHeight;
}

- (CGFloat)totalWidth {
    return [self.layout totalWidth];
}

- (void)makeIndexSelectedWithAnimation:(NSInteger)index {
    if (self.selectedIndex != index) {
        [self didTapView:[self itemViewAtIndex:self.selectedIndex] animateToSelected:NO];
        [self didTapView:[self itemViewAtIndex:index] animateToSelected:YES];

        self.selectedIndex = index;
        [UIView animateWithDuration:kAnimationDuration animations:^{
            self.trackView.transform = CGAffineTransformMakeTranslation([self translationXForTrackAtIndex:self.selectedIndex], 0);
        }];
    }
}

- (void)slidingToDirection:(EHHorizontalFixedWidthItemsTrackViewSlideDirection)direction percentage:(CGFloat)percentage {
    [self didSlideView:[self itemViewAtIndex:self.selectedIndex] reactInPercentage:(1 - percentage)];

    CGFloat translationX = 0;
    if (direction == EHHorizontalFixedWidthItemsTrackViewSlideDirectionNext) {
        translationX = [self translationXForTrackAtIndex:self.selectedIndex] + (self.layout.itemSize.width + self.layout.interitemSpacing) * percentage;
        
        if (self.selectedIndex != self.layout.numberOfItems - 1) {
            [self didSlideView:[self itemViewAtIndex:(self.selectedIndex + 1)] reactInPercentage:percentage];
        }
    } else {
        translationX = [self translationXForTrackAtIndex:self.selectedIndex] - (self.layout.itemSize.width + self.layout.interitemSpacing) * percentage;
        
        if (self.selectedIndex != 0) {
            [self didSlideView:[self itemViewAtIndex:(self.selectedIndex - 1)] reactInPercentage:percentage];
        }
    }
    
    self.trackView.transform = CGAffineTransformMakeTranslation(translationX, 0);
}

- (void)slideToDirection:(EHHorizontalFixedWidthItemsTrackViewSlideDirection)direction {
    [self didTapView:[self itemViewAtIndex:self.selectedIndex] animateToSelected:NO];
    
    CGFloat translationX = 0;
    if (direction == EHHorizontalFixedWidthItemsTrackViewSlideDirectionNext) {
        translationX = [self translationXForTrackAtIndex:(self.selectedIndex + 1)];
        [self didTapView:[self itemViewAtIndex:(self.selectedIndex + 1)] animateToSelected:YES];
        self.selectedIndex += 1;
    } else {
        translationX = [self translationXForTrackAtIndex:(self.selectedIndex - 1)];
        [self didTapView:[self itemViewAtIndex:(self.selectedIndex - 1)] animateToSelected:YES];
        self.selectedIndex -= 1;
    }
    
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.trackView.transform = CGAffineTransformMakeTranslation(translationX, 0);
    }];
}

- (void)slideBackFromDirection:(EHHorizontalFixedWidthItemsTrackViewSlideDirection)direction {
    [self didTapView:[self itemViewAtIndex:self.selectedIndex] animateToSelected:YES];

    if (direction == EHHorizontalFixedWidthItemsTrackViewSlideDirectionNext) {
        if (self.selectedIndex != self.layout.numberOfItems - 1) {
            [self didTapView:[self itemViewAtIndex:(self.selectedIndex + 1)] animateToSelected:NO];
        }
    } else {
        if (self.selectedIndex != 0) {
            [self didTapView:[self itemViewAtIndex:(self.selectedIndex - 1)] animateToSelected:NO];
        }
    }

    CGFloat translationX = [self translationXForTrackAtIndex:self.selectedIndex];
    [UIView animateWithDuration:kAnimationDuration animations:^{
        self.trackView.transform = CGAffineTransformMakeTranslation(translationX, 0);
    }];
}

- (void)scrollToMiddleOfFrameForItemViewAtIndex:(NSInteger)index {
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat minEffectiveX = width / 2.0f;
    CGFloat maxEffectiveX = [self.layout totalWidth] - width + width / 2.0f;

    CGFloat x = [self.layout xForIndex:index] + self.layout.itemSize.width / 2.0f;
    CGFloat offsetX = 0;

    if (x < minEffectiveX) {
        offsetX = minEffectiveX - width / 2.0f;
    } else if (x > maxEffectiveX) {
        offsetX = maxEffectiveX - width / 2.0f;
    } else {
        offsetX = x - width / 2.0f;
    }

    [self setContentOffset:CGPointMake(offsetX, 0) animated:YES];
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
    self.contentSize = CGSizeMake([self totalWidth], [self totalHeight]);
    
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

- (void)addTrackView {
    self.trackView.frame = CGRectMake(0,
                                      [self.layout totalHeight],
                                      self.layout.itemSize.width * self.trackWidthPercent,
                                      self.trackHeight);
    self.trackView.transform = CGAffineTransformMakeTranslation([self translationXForTrackAtIndex:self.selectedIndex], 0);

    [self addSubview:self.trackView];
}

- (CGFloat)translationXForTrackAtIndex:(NSInteger)index {
    return [self.layout xForIndex:index] + (1 - self.trackWidthPercent) * self.layout.itemSize.width / 2.0f;
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

- (void)didSlideView:(UIView <EHItemViewDelegate> *)view reactInPercentage:(CGFloat)percentage {
    if ([view respondsToSelector:@selector(didReactInPercentage:)]) {
        [view didReactInPercentage:percentage];
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

- (void)setTrackWidthPercent:(CGFloat)trackWidthPercent {
    if (trackWidthPercent < 0 || trackWidthPercent > 1.0f) {
        return;
    }
    
    _trackWidthPercent = trackWidthPercent;
    CGFloat trackWidth = trackWidthPercent * _layout.itemSize.width;
    
    CGRect frame = _trackView.frame;
    frame.size.width = trackWidth;
    _trackView.frame = frame;
    
    _trackView.transform = CGAffineTransformMakeTranslation([self translationXForTrackAtIndex:self.selectedIndex], 0);
}

- (void)setTrackCornerRadius:(CGFloat)trackCornerRadius {
    _trackCornerRadius = trackCornerRadius;
    _trackView.layer.cornerRadius = trackCornerRadius;
}

- (void)setTrackColor:(UIColor *)trackColor {
    _trackColor = trackColor;
    _trackView.backgroundColor = trackColor;
}

- (UIView *)trackView {
    if (!_trackView) {
        _trackView = [[UIView alloc] init];
        _trackView.clipsToBounds = YES;
        _trackView.layer.cornerRadius = _trackCornerRadius;
        _trackView.backgroundColor = _trackColor;
    }
    
    return _trackView;
}

- (UITapGestureRecognizer *)tapRecognizer {
    if (!_tapRecognizer) {
        _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapView:)];
    }
    
    return _tapRecognizer;
}

@end
