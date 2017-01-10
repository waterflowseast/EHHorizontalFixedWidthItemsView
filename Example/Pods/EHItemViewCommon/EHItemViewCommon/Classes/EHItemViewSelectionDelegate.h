//
//  EHItemViewSelectionDelegate.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/19.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#ifndef EHItemViewSelectionDelegate_h
#define EHItemViewSelectionDelegate_h

@protocol EHItemViewSelectionDelegate <NSObject>

@optional
- (void)didTapExceedingLimitInView:(UIView *)view maxSelectionsAllowed:(NSUInteger)maxSelectionsAllowed;

@end

#endif /* EHItemViewSelectionDelegate_h */
