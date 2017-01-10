//
//  EHViewController.m
//  EHHorizontalFixedWidthItemsView
//
//  Created by Eric Huang on 01/08/2017.
//  Copyright (c) 2017 Eric Huang. All rights reserved.
//

#import "EHViewController.h"
#import <Masonry/Masonry.h>

static NSString * const kDefaultCellIdentifier = @"DefaultCell";

@interface EHViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *items;

@end

@implementation EHViewController

#pragma mark - lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self configureForNavigationBar];
    [self configureForViews];
    
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kDefaultCellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kDefaultCellIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@", (long)indexPath.row+1, self.items[indexPath.row][@"title"]];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:13.0f];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    UIViewController *controller = [[NSClassFromString(self.items[indexPath.row][@"class"]) alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - event response

#pragma mark - private methods

- (void)configureForNavigationBar {
    self.navigationItem.title = @"Home";
}

- (void)configureForViews {
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
}

#pragma mark - getters & setters

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    
    return _tableView;
}

- (NSArray *)items {
    if (!_items) {
        _items = @[
                   @{@"title" : @"EHHorizontalFixedWidthItemsView & EHHorizontalFixedWidthItemsSeparatorView", @"class" : @"EHDemo1ViewController"},
                   @{@"title" : @"EHHorizontalFixedWidthItemsSelectionView", @"class" : @"EHDemo2ViewController"},
                   @{@"title" : @"EHFixedWidthItemsSequentialSelectionView & EHRateView", @"class" : @"EHDemo3ViewController"},
                   @{@"title" : @"EHFixedWidthItemsSingleAnimatedSelectionView & EHFixedWidthItemsSingleAnimatedSelectionSeparatorView", @"class" : @"EHDemo4ViewController"},
                   ];
    }
    
    return _items;
}

@end
