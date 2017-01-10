//
//  EHRateView.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/23.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHFixedWidthItemsSequentialSelectionView.h"

@interface EHRateView : EHFixedWidthItemsSequentialSelectionView

- (instancetype)initWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage numberOfItems:(NSInteger)numberOfItems itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (instancetype)initWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage layout:(EHHorizontalFixedWidthLayout *)layout;

- (void)resetWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage numberOfItems:(NSInteger)numberOfItems itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing;

- (void)resetWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage layout:(EHHorizontalFixedWidthLayout *)layout;

@end

@interface EHRateImageView : UIImageView <EHItemViewDelegate>

@end
