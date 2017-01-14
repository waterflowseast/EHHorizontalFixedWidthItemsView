//
//  EHHorizontalFixedWidthItemsTrackView.h
//  Pods
//
//  Created by Eric Huang on 17/1/14.
//
//

#import <UIKit/UIKit.h>
#import <EHItemViewCommon/EHItemViewDelegate.h>

#ifndef EHHorizontalFixedWidthItemsTrackView_H
#define EHHorizontalFixedWidthItemsTrackView_H

typedef NS_ENUM(NSInteger, EHHorizontalFixedWidthItemsTrackViewSlideDirection) {
    EHHorizontalFixedWidthItemsTrackViewSlideDirectionNext,
    EHHorizontalFixedWidthItemsTrackViewSlideDirectionPrevious
};

#endif

@class EHHorizontalFixedWidthItemsTrackView;

@protocol EHHorizontalFixedWidthItemsTrackViewDelegate <NSObject>

@optional
- (void)didTapItemAtIndex:(NSInteger)index inView:(EHHorizontalFixedWidthItemsTrackView *)view;

@end

@class EHHorizontalFixedWidthLayout;

@interface EHHorizontalFixedWidthItemsTrackView : UIScrollView

@property (nonatomic, assign) id<EHHorizontalFixedWidthItemsTrackViewDelegate> tapDelegate;

@property (nonatomic, strong, readonly) EHHorizontalFixedWidthLayout *layout;
@property (nonatomic, assign, readonly) NSInteger selectedIndex;

@property (nonatomic, assign, readonly) CGFloat trackHeight;
@property (nonatomic, assign) CGFloat trackWidthPercent;
@property (nonatomic, assign) CGFloat trackCornerRadius;
@property (nonatomic, strong) UIColor *trackColor;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing trackHeight:(CGFloat)trackHeight;

- (instancetype)initWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout trackHeight:(CGFloat)trackHeight;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing trackHeight:(CGFloat)trackHeight;

- (void)resetWithItems:(NSArray<UIView <EHItemViewDelegate> *> *)items layout:(EHHorizontalFixedWidthLayout *)layout trackHeight:(CGFloat)trackHeight;

- (CGFloat)totalHeight;
- (CGFloat)totalWidth;

- (void)makeIndexSelectedWithAnimation:(NSInteger)index;
- (void)slidingToDirection:(EHHorizontalFixedWidthItemsTrackViewSlideDirection)direction percentage:(CGFloat)percentage;
- (void)slideToDirection:(EHHorizontalFixedWidthItemsTrackViewSlideDirection)direction;
- (void)slideBackFromDirection:(EHHorizontalFixedWidthItemsTrackViewSlideDirection)direction;

- (void)scrollToMiddleOfFrameForItemViewAtIndex:(NSInteger)index;

@end
