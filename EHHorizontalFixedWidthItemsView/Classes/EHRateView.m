//
//  EHRateView.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/23.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHRateView.h"
#import "EHHorizontalFixedWidthLayout.h"

@implementation EHRateView

- (instancetype)initWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage numberOfItems:(NSInteger)numberOfItems itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing {
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < numberOfItems; i++) {
        [items addObject:[[EHRateImageView alloc] initWithImage:image highlightedImage:selectedImage]];
    }
    
    self = [super initWithItems:items itemSize:itemSize insets:insets interitemSpacing:interitemSpacing];
    return self;
}

- (instancetype)initWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage layout:(EHHorizontalFixedWidthLayout *)layout {
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < layout.numberOfItems; i++) {
        [items addObject:[[EHRateImageView alloc] initWithImage:image highlightedImage:selectedImage]];
    }
    
    self = [super initWithItems:items layout:layout];
    return self;
}

- (void)resetWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage numberOfItems:(NSInteger)numberOfItems itemSize:(CGSize)itemSize insets:(UIEdgeInsets)insets interitemSpacing:(CGFloat)interitemSpacing {
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < numberOfItems; i++) {
        [items addObject:[[EHRateImageView alloc] initWithImage:image highlightedImage:selectedImage]];
    }
    
    [super resetWithItems:items itemSize:itemSize insets:insets interitemSpacing:interitemSpacing];
}

- (void)resetWithImage:(UIImage *)image selectedImage:(UIImage *)selectedImage layout:(EHHorizontalFixedWidthLayout *)layout {
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < layout.numberOfItems; i++) {
        [items addObject:[[EHRateImageView alloc] initWithImage:image highlightedImage:selectedImage]];
    }
    
    [super resetWithItems:items layout:layout];
}

@end

@implementation EHRateImageView

- (void)didTapToSelected:(BOOL)selected {
    self.highlighted = selected;
}

@end
