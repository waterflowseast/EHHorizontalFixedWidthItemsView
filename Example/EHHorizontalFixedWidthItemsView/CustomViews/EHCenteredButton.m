//
//  EHCenteredButton.m
//  WFEDemo
//
//  Created by Eric Huang on 16/12/4.
//  Copyright © 2016年 Eric Huang. All rights reserved.
//

#import "EHCenteredButton.h"

@implementation EHCenteredButton

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // the space between the image and text
    CGFloat spacing = self.verticalSpace > 0 ? self.verticalSpace : 6.0f;
    
    // lower the text and push it left so it appears centered
    //  below the image
    CGSize imageSize = self.imageView.frame.size;
    self.titleEdgeInsets = UIEdgeInsetsMake(0.0, -imageSize.width, -(imageSize.height+spacing), 0.0);
    
    // raise the image and push it right so it appears centered
    //  above the text
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName: self.titleLabel.font}];
    self.imageEdgeInsets = UIEdgeInsetsMake(-(titleSize.height+spacing), 0.0, 0.0, -titleSize.width);
}

@end
