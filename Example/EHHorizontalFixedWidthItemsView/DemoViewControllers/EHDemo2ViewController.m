//
//  EHDemo2ViewController.m
//  EHHorizontalFixedWidthItemsView
//
//  Created by Eric Huang on 17/1/10.
//  Copyright © 2017年 Eric Huang. All rights reserved.
//

#import "EHDemo2ViewController.h"
#import <Masonry/Masonry.h>
#import <EHHorizontalFixedWidthItemsView/EHHorizontalFixedWidthItemsSelectionView.h>
#import "WFELabel.h"

static CGFloat const kLabelWidth = 68.0f;
static CGFloat const kLabelHeight = 30.0f;
static CGFloat const kMinimumInteritemSpacing = 20.0f;

@interface EHDemo2ViewController () <EHHorizontalFixedWidthItemsViewDelegate, EHItemViewSelectionDelegate>

@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) NSArray *fixedLabels;
@property (nonatomic, strong) EHHorizontalFixedWidthItemsSelectionView *fixedView;

@end

@implementation EHDemo2ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self configureForNavigationBar];
    [self configureForViews];
    
    [self.view addSubview:self.fixedView];
    [self.fixedView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.mas_equalTo([self.fixedView totalHeight]);
    }];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark - EHHorizontalFixedWidthItemsViewDelegate

- (void)didTapItemAtIndex:(NSInteger)index inView:(UIView *)view {
    NSLog(@"===> index: %ld, word: %@", (long)index, self.words[index]);
}

#pragma mark - EHItemViewSelectionDelegate

- (void)didTapExceedingLimitInView:(UIView *)view maxSelectionsAllowed:(NSUInteger)maxSelectionsAllowed {
    NSLog(@"===> exceeding max: %ld", (long)maxSelectionsAllowed);
}

#pragma mark - private methods

- (void)configureForNavigationBar {
    self.navigationItem.title = @"EHHorizontalFixedWidthItemsSelectionView";
}

- (void)configureForViews {
    self.view.backgroundColor = [UIColor whiteColor];
}

#pragma mark - getters & setters

- (NSArray *)words {
    if (!_words) {
        _words = @[
                   @"照片", @"拍摄", @"小视频", @"视频聊天",
                   @"红包", @"转账", @"位置", @"收藏",
                   @"个人名片", @"语音输入", @"卡券"
                   ];
    }
    
    return _words;
}

- (NSArray *)fixedLabels {
    if (!_fixedLabels) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i = 0; i < self.words.count; i++) {
            WFELabel *label = [[WFELabel alloc] initWithText:self.words[i]];
            
            [mutableArray addObject:label];
        }
        
        _fixedLabels = [mutableArray copy];
    }
    
    return _fixedLabels;
}

- (EHHorizontalFixedWidthItemsSelectionView *)fixedView {
    if (!_fixedView) {
        _fixedView = [[EHHorizontalFixedWidthItemsSelectionView alloc] initWithItems:self.fixedLabels itemSize:CGSizeMake(kLabelWidth, kLabelHeight) insets:UIEdgeInsetsMake(15, 15, 15, 15) interitemSpacing:kMinimumInteritemSpacing];
        _fixedView.allowsAnimationWhenTap = YES;
        _fixedView.animationDuration = 0.4f;
        _fixedView.allowsMultipleSelection = YES;
        _fixedView.maxSelectionsAllowed = 3;
        
        _fixedView.animationBlock = ^(UIView *itemView, NSTimeInterval animationDuration, EHAnimationCompletionBlock animationCompletion) {
            [UIView
             animateKeyframesWithDuration:animationDuration
             delay:0
             options:UIViewKeyframeAnimationOptionCalculationModeLinear
             animations:^{
                 [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations:^{
                     itemView.transform = CGAffineTransformMakeTranslation(10.0f, 0);
                 }];
                 
                 [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.4 animations:^{
                     itemView.transform = CGAffineTransformMakeTranslation(-10.0f, 0);
                 }];
                 
                 [UIView addKeyframeWithRelativeStartTime:0.7 relativeDuration:0.3 animations:^{
                     itemView.transform = CGAffineTransformMakeTranslation(0, 0);
                 }];
             } completion:animationCompletion];
        };
        
        _fixedView.tapDelegate = self;
        _fixedView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
    }
    
    return _fixedView;
}

@end
