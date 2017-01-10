//
//  EHHorizontalFixedWidthLayout+SeparatorPosition.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/22.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHHorizontalFixedWidthLayout+SeparatorPosition.h"

@implementation EHHorizontalFixedWidthLayout (SeparatorPosition)

- (CGFloat)centerXForSeparatorAtIndex:(NSInteger)index {
    if (index < 1 || index >= self.numberOfItems) {
        return 0;
    }
    
    return [self xForIndex:index] - self.interitemSpacing / 2.0f;
}

- (CGFloat)centerYForSeparatorAtIndex:(NSInteger)index {
    if (index < 1 || index >= self.numberOfItems) {
        return 0;
    }
    
    return [self yForIndex:index] + self.itemSize.height / 2.0f;
}

@end
