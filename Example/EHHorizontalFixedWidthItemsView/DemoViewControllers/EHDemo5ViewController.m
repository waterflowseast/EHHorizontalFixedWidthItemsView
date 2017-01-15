//
//  EHDemo5ViewController.m
//  EHHorizontalFixedWidthItemsView
//
//  Created by Eric Huang on 17/1/15.
//  Copyright © 2017年 Eric Huang. All rights reserved.
//

#import "EHDemo5ViewController.h"
#import <Masonry/Masonry.h>
#import <EHHorizontalFixedWidthItemsView/EHHorizontalFixedWidthItemsTrackView.h>
#import <EHHorizontalFixedWidthItemsView/EHHorizontalFixedWidthLayout.h>
#import "WFEPercentageLabel.h"

static CGFloat const kLabelWidth = 68.0f;
static CGFloat const kLabelHeight = 30.0f;
static CGFloat const kMinimumInteritemSpacing = 20.0f;
static CGFloat const kTrackHeight = 6.0f;
static CGFloat const kTrackWidthPercent = 0.3f;

@interface EHDemo5ViewController () <EHHorizontalFixedWidthItemsTrackViewDelegate>

@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) NSArray *fixedLabels;
@property (nonatomic, strong) EHHorizontalFixedWidthItemsTrackView *fixedView;
@property (nonatomic, strong) UIPanGestureRecognizer *pan;

@end

@implementation EHDemo5ViewController

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
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"changeTrack" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(didClickButton) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:button];
    [button mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    UILabel *label = [[UILabel alloc] init];
    label.text = @"you can pan to slide";
    label.textColor = [UIColor grayColor];
    
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.fixedView.mas_bottom).offset(100.0f);
    }];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark - EHHorizontalFixedWidthItemsTrackViewDelegate

- (void)didTapItemAtIndex:(NSInteger)index inView:(EHHorizontalFixedWidthItemsTrackView *)view {
    NSLog(@"===> index: %ld, word: %@", (long)index, self.words[index]);

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.fixedView scrollToMiddleOfFrameForItemViewAtIndex:index];
    });
}

#pragma mark - event response

- (void)didClickButton {
    self.fixedView.trackColor = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1.0];
    self.fixedView.trackCornerRadius = arc4random_uniform((int)kTrackHeight/2.0f + 1);
    self.fixedView.trackWidthPercent = arc4random_uniform(255)/255.0;
}

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender {
    CGFloat translationX = [sender translationInView:sender.view].x;
    EHHorizontalFixedWidthItemsTrackViewSlideDirection direction = translationX > 0 ? EHHorizontalFixedWidthItemsTrackViewSlideDirectionPrevious : EHHorizontalFixedWidthItemsTrackViewSlideDirectionNext;
    CGFloat ratio = fabs(translationX) / CGRectGetWidth([UIScreen mainScreen].bounds);
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        [self.fixedView slidingToDirection:direction percentage:ratio];
        return;
    }
    
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.fixedView.selectedIndex == 0 && direction == EHHorizontalFixedWidthItemsTrackViewSlideDirectionPrevious) {
            [self.fixedView slideBackFromDirection:direction];
            [self scrollFixedView];
            return;
        }

        if (self.fixedView.selectedIndex == self.fixedView.layout.numberOfItems - 1 && direction == EHHorizontalFixedWidthItemsTrackViewSlideDirectionNext) {
            [self.fixedView slideBackFromDirection:direction];
            [self scrollFixedView];
            return;
        }

        if (ratio > 0.5) {
            [self.fixedView slideToDirection:direction];
        } else {
            [self.fixedView slideBackFromDirection:direction];
        }
        
        [self scrollFixedView];
    }
}

#pragma mark - private methods

- (void)configureForNavigationBar {
    self.navigationItem.title = @"EHHorizontalFixedWidthItemsTrackView";
}

- (void)configureForViews {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addGestureRecognizer:self.pan];
}

- (void)scrollFixedView {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.35 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.fixedView scrollToMiddleOfFrameForItemViewAtIndex:self.fixedView.selectedIndex];
    });
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
            WFEPercentageLabel *label = [[WFEPercentageLabel alloc] initWithText:self.words[i]];
            
            [mutableArray addObject:label];
        }
        
        _fixedLabels = [mutableArray copy];
    }
    
    return _fixedLabels;
}

- (EHHorizontalFixedWidthItemsTrackView *)fixedView {
    if (!_fixedView) {
        _fixedView = [[EHHorizontalFixedWidthItemsTrackView alloc] initWithItems:self.fixedLabels itemSize:CGSizeMake(kLabelWidth, kLabelHeight) insets:UIEdgeInsetsMake(15, 15, 10, 15) interitemSpacing:kMinimumInteritemSpacing trackHeight:kTrackHeight];

        _fixedView.tapDelegate = self;
        _fixedView.trackWidthPercent = kTrackWidthPercent;
        _fixedView.trackCornerRadius = kTrackHeight / 2.0f;
        _fixedView.trackColor = [UIColor blueColor];
        _fixedView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
    }
    
    return _fixedView;
}

- (UIPanGestureRecognizer *)pan {
    if (!_pan) {
        _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognized:)];
    }
    
    return _pan;
}

@end
