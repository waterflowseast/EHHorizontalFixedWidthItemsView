//
//  EHDemo4ViewController.m
//  EHHorizontalFixedWidthItemsView
//
//  Created by Eric Huang on 17/1/10.
//  Copyright © 2017年 Eric Huang. All rights reserved.
//

#import "EHDemo4ViewController.h"
#import <Masonry/Masonry.h>
#import <EHHorizontalFixedWidthItemsView/EHFixedWidthItemsSingleAnimatedSelectionView.h>
#import <EHHorizontalFixedWidthItemsView/EHFixedWidthItemsSingleAnimatedSelectionSeparatorView.h>
#import "WFEAnimatedLabel.h"

static CGFloat const kLabelWidth = 68.0f;
static CGFloat const kLabelHeight = 30.0f;
static CGFloat const kMinimumInteritemSpacing = 20.0f;
static CGFloat const kSeparatorMinimumInteritemSpacing = 40.0f;
static CGFloat const kSeparatorWidth = 2.0f;
static CGFloat const kSeparatorHeight = 16.0f;

@interface EHDemo4ViewController () <EHFixedWidthItemsSingleAnimatedSelectionViewDelegate>

@property (nonatomic, strong) NSArray *words;
@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) NSArray *separatorLabels;
@property (nonatomic, strong) EHFixedWidthItemsSingleAnimatedSelectionView *labelsView;
@property (nonatomic, strong) EHFixedWidthItemsSingleAnimatedSelectionSeparatorView *separatorLabelsView;

@end

@implementation EHDemo4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self configureForNavigationBar];
    [self configureForViews];
    
    [self.view addSubview:self.labelsView];
    [self.labelsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.and.left.and.right.equalTo(self.view);
        make.height.mas_equalTo([self.labelsView totalHeight]);
    }];
    
    [self.view addSubview:self.separatorLabelsView];
    [self.separatorLabelsView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.and.right.equalTo(self.view);
        make.top.equalTo(self.labelsView.mas_bottom).offset(30.0f);
        make.height.mas_equalTo([self.separatorLabelsView totalHeight]);
    }];
}

- (BOOL)hidesBottomBarWhenPushed {
    return YES;
}

#pragma mark - EHHorizontalFixedWidthItemsViewDelegate

- (void)didTapItemAtIndex:(NSInteger)index inView:(UIView *)view {
    NSArray *viewNames = @[@"labelsView", @"separatorLabelsView"];
    NSLog(@"===> %@ index: %ld, word: %@", viewNames[view.tag], (long)index, self.words[index]);
}

#pragma mark - event response

#pragma mark - private methods

- (void)configureForNavigationBar {
    self.navigationItem.title = @"EHFixedWidthItemsSingleAnimatedSelectionView & EHFixedWidthItemsSingleAnimatedSelectionSeparatorView";
}

- (void)configureForViews {
    self.view.backgroundColor = [UIColor whiteColor];
}

- (UIColor *)randomColor {
    NSArray *colors = @[
                        [UIColor redColor],
                        [UIColor greenColor],
                        [UIColor blueColor],
                        [UIColor yellowColor]
                        ];
    return colors[arc4random_uniform(4)];
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

- (NSArray *)labels {
    if (!_labels) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i = 0; i < self.words.count; i++) {
            WFEAnimatedLabel *label = [[WFEAnimatedLabel alloc] initWithText:self.words[i]];
            
            [mutableArray addObject:label];
        }
        
        _labels = [mutableArray copy];
    }
    
    return _labels;
}

- (NSArray *)separatorLabels {
    if (!_separatorLabels) {
        NSMutableArray *mutableArray = [NSMutableArray array];
        
        for (int i = 0; i < self.words.count; i++) {
            WFEAnimatedLabel *label = [[WFEAnimatedLabel alloc] initWithText:self.words[i]];
            
            [mutableArray addObject:label];
        }
        
        _separatorLabels = [mutableArray copy];
    }
    
    return _separatorLabels;
}

- (EHFixedWidthItemsSingleAnimatedSelectionView *)labelsView {
    if (!_labelsView) {
        _labelsView = [[EHFixedWidthItemsSingleAnimatedSelectionView alloc] initWithItems:self.labels itemSize:CGSizeMake(kLabelWidth, kLabelHeight) insets:UIEdgeInsetsMake(15, 15, 15, 15) interitemSpacing:kMinimumInteritemSpacing];
        _labelsView.tapDelegate = self;
        _labelsView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
        _labelsView.tag = 0;
    }
    
    return _labelsView;
}

- (EHFixedWidthItemsSingleAnimatedSelectionSeparatorView *)separatorLabelsView {
    if (!_separatorLabelsView) {
        UIColor *separatorColor = [UIColor lightGrayColor];
        _separatorLabelsView = [[EHFixedWidthItemsSingleAnimatedSelectionSeparatorView alloc] initWithItems:self.separatorLabels itemSize:CGSizeMake(kLabelWidth, kLabelHeight) insets:UIEdgeInsetsMake(15, 15, 15, 15) interitemSpacing:kSeparatorMinimumInteritemSpacing separatorSize:CGSizeMake(kSeparatorWidth, kSeparatorHeight) separatorColor:separatorColor];
        _separatorLabelsView.tapDelegate = self;
        _separatorLabelsView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1.0f];
        _separatorLabelsView.tag = 1;
    }
    
    return _separatorLabelsView;
}

@end
