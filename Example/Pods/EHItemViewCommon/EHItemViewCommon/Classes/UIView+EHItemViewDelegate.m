//
//  UIView+EHItemViewDelegate.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/4.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "UIView+EHItemViewDelegate.h"

@implementation UIView (EHItemViewDelegate)

- (id<EHItemViewDelegate>)eh_itemViewDelegate {
    return objc_getAssociatedObject(self, @selector(eh_itemViewDelegate));
}

- (void)setEh_itemViewDelegate:(id<EHItemViewDelegate>)eh_itemViewDelegate {
    objc_setAssociatedObject(self, @selector(eh_itemViewDelegate), eh_itemViewDelegate, OBJC_ASSOCIATION_ASSIGN);
}

@end
