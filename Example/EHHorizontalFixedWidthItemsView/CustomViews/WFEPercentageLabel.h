//
//  WFEPercentageLabel.h
//  EHHorizontalFixedWidthItemsView
//
//  Created by Eric Huang on 17/1/15.
//  Copyright © 2017年 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EHItemViewCommon/EHItemViewDelegate.h>

@interface WFEPercentageLabel : UILabel <EHItemViewDelegate>

- (instancetype)initWithText:(NSString *)text;

@end
