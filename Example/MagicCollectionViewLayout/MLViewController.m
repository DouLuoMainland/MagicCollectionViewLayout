//
//  MLViewController.m
//  MagicCollectionViewLayout
//
//  Created by Sun,Shaobo on 05/27/2020.
//  Copyright (c) 2020 Sun,Shaobo. All rights reserved.
//

#import "MLViewController.h"
#import "MLCycleLayoutViewController.h"
#import "MLCenterEffectViewController.h"
#import "MLWaterFallViewController.h"

@interface MLViewController () <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSArray *titles;

@end

@implementation MLViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
}

- (NSArray *)titles {
    if (!_titles) {
        _titles = @[@"圆形布局",
                    @"中间元素特效",
                    @"瀑布流"];
    }
    return _titles;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellID"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellID"];
    }
    cell.textLabel.text = self.titles[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString *title = self.titles[indexPath.row];
    if ([title isEqualToString:@"圆形布局"]) {
        [self.navigationController pushViewController:[[MLCycleLayoutViewController alloc] init] animated:YES];
    } else if ([title isEqualToString:@"中间元素特效"]) {
        [self.navigationController pushViewController:[[MLCenterEffectViewController alloc] init] animated:YES];
    } else if ([title isEqualToString:@"瀑布流"]) {
        [self.navigationController pushViewController:[[MLWaterFallViewController alloc] init] animated:YES];
    }
    
}

@end
