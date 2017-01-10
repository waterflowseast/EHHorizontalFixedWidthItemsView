//
//  WFELabel.h
//  WFEDemo
//
//  Created by Eric Huang on 16/12/19.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EHItemViewCommon/EHItemViewDelegate.h>

@interface WFELabel : UILabel <EHItemViewDelegate>

- (instancetype)initWithText:(NSString *)text;

@end
