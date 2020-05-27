//
//  MLWaterFallViewController.m
//  MagicCollectionViewLayout_Example
//
//  Created by Sun,Shaobo on 2020/5/27.
//  Copyright © 2020 Sun,Shaobo. All rights reserved.
//

#import "MLWaterFallViewController.h"
#import "MLWaterFallLayout.h"
#import "MLCycleCell.h"
#import "MJRefresh.h"

@interface MLWaterFallViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, MLWaterFallLayoutDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MLWaterFallLayout *layout;
@property (nonatomic, assign) CGPoint startCtrlPoint;
@property (nonatomic, assign) NSInteger datas;
@end

@implementation MLWaterFallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.datas = 3;
    [self.collectionView reloadData];
    [self addRefresh];
}

- (void)addRefresh {
    self.collectionView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_header endRefreshing];
            self.datas = 6;
            [self.collectionView reloadData];
        });
    }];
    
    self.collectionView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.collectionView.mj_footer endRefreshing];
            self.datas += 6;
            [self.collectionView reloadData];
        });
    }];
}

- (void)rightItemAction {
    self.datas += 1;
    [self.collectionView reloadData];
}

- (void)initUI {
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    if (@available(iOS 11.0, *)) {
        self.collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    } else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:@"+" style:UIBarButtonItemStylePlain target:self action:@selector(rightItemAction)];
    rightItem.width = 30;
    self.navigationItem.rightBarButtonItem = rightItem;
}

- (UIImage *)getResourceImage:(NSInteger)index {
    NSString *imageName = [NSString stringWithFormat:@"%02ld", index % 13];
    NSString *fileName = [[NSBundle mainBundle] pathForResource:imageName ofType:@"jpg"];
    return [UIImage imageWithContentsOfFile:fileName];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.datas;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MLCycleCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([MLCycleCell class]) forIndexPath:indexPath];
    cell.iconImageView.image = [self getResourceImage:indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.item);
}


#pragma mark - UICollectionViewDelegateFlowLayout

- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath width:(CGFloat)width {
    UIImage *indexImage = [self getResourceImage:indexPath.item];
    return indexImage.size.height / indexImage.size.width * width;
}

#pragma mark - lazy

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 100);
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MLCycleCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MLCycleCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return _collectionView;
}

-(MLWaterFallLayout *)layout {
    if (!_layout) {
        _layout = [[MLWaterFallLayout alloc] init];
        _layout.colMagin = 5;
        _layout.colNum = 3;
        _layout.itemMagin = 5;
        _layout.delegate = self;
    }
    return _layout;
}

@end
