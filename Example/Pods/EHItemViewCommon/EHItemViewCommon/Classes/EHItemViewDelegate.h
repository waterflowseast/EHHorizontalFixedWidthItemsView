//
//  EHItemViewDelegate.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/4.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#ifndef EHItemViewDelegate_h
#define EHItemViewDelegate_h

@protocol EHItemViewDelegate <NSObject>

@optional
- (void)didTapControl:(UIControl *)control inView:(UIView *)view;
- (void)didTapToSelected:(BOOL)selected;
- (void)didTapToAnimateToSelected:(BOOL)selected;

@end


#endif /* EHItemViewDelegate_h */
