//
//  EHDemo3ViewController.m
//  EHHorizontalFixedWidthItemsView
//
//  Created by Eric Huang on 17/1/10.
//  Copyright © 2017年 Eric Huang. All rights reserved.
//

#import "EHDemo3ViewController.h"
#import <Masonry/Masonry.h>
#import <EHHorizontalFixedWidthItemsView/EHFixedWidthItemsSequentialSelectionView.h>
#import <EHHorizontalFixedWidthItemsView/EHRateView.h>
#import "WFELabel.h"

static CGFloat const kLabelWidth = 68.0f;
static CGFloat const kLabelHeight = 30.0f;
static CGFloat const kMinimumInteritemSpacing = 5.0f;
static CGFloat const kImageWidth = 32.0f;
static CGFloat const kImageHeight = 32.0f;

@interface EHDemo3ViewController () <EHHorizontalFixedWidthItemsViewDelegate>

@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) NSArray *fixedLabels;
@property (nonatomic, strong) EHFixedWidthItemsSequentialSelectionView *fixedView;
@property (nonatomic, strong) EHRateView *rateView;

@end

@implementation EHDemo3ViewController

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
    
    [self.view addSubview:self.rateView];
    [self.rateView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.fixedView.mas_bottom).offset(30.0f);
        make.left.equalTo(self.view);
        make.width.mas_equalTo([self.rateView totalWidth]);
        make.height.mas_equalTo([self.rateView totalHeight]);
    }];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark - EHHorizontalFixedWidthItemsViewDelegate

- (void)didTapItemAtIndex:(NSInteger)index inView:(UIView *)view {
    if ([view isKindOfClass:[EHRateView class]]) {
        EHRateView *rateView = (EHRateView *)view;
        NSLog(@"==> index: %ld, selected index: %ld", (long)index, (long)rateView.selectedIndex);
    } else {
        NSLog(@"===> index: %ld, word: %@", (long)index, self.words[index]);
    }
}

#pragma mark - private methods

- (void)configureForNavigationBar {
    self.navigationItem.title = @"EHFixedWidthItemsSequentialSelectionView & EHRateView";
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

- (EHFixedWidthItemsSequentialSelectionView *)fixedView {
    if (!_fixedView) {
        _fixedView = [[EHFixedWidthItemsSequentialSelectionView alloc] initWithItems:self.fixedLabels itemSize:CGSizeMake(kLabelWidth, kLabelHeight) insets:UIEdgeInsetsMake(15, 15, 15, 15) interitemSpacing:kMinimumInteritemSpacing];
        _fixedView.allowsToCancel = YES;
        _fixedView.tapDelegate = self;
        _fixedView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
    }
    
    return _fixedView;
}

- (EHRateView *)rateView {
    if (!_rateView) {
        _rateView = [[EHRateView alloc] initWithImage:[UIImage imageNamed:@"star"] selectedImage:[UIImage imageNamed:@"selected-star"] numberOfItems:5 itemSize:CGSizeMake(kImageWidth, kImageHeight) insets:UIEdgeInsetsZero interitemSpacing:kMinimumInteritemSpacing];
        _rateView.allowsToCancel = YES;
        _rateView.tapDelegate = self;
        _rateView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
    }
    
    return _rateView;
}

@end
