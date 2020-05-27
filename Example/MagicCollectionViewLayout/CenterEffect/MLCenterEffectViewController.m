//
//  MLCenterEffectViewController.m
//  MagicCollectionViewLayout_Example
//
//  Created by Sun,Shaobo on 2020/5/27.
//  Copyright © 2020 Sun,Shaobo. All rights reserved.
//

#import "MLCenterEffectViewController.h"
#import "MLCenterEffectLayout.h"
#import "MLCycleCell.h"
#define RightMagin 20
@interface MLCenterEffectViewController () <UICollectionViewDelegateFlowLayout, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MLCenterEffectLayout *layout;
@property (nonatomic, assign) CGPoint startCtrlPoint;
@property (nonatomic, assign) NSInteger datas;
@end

@implementation MLCenterEffectViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    self.datas = 12;
    [self.collectionView reloadData];
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

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(collectionView.bounds.size.width - RightMagin * 2, collectionView.bounds.size.height);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.item);
}

#pragma mark - lazy

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.frame = CGRectMake(0, 200, [UIScreen mainScreen].bounds.size.width, 200);
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MLCycleCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MLCycleCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor grayColor];
        _collectionView.contentInset = UIEdgeInsetsMake(0, RightMagin, 0, RightMagin);
    }
    return _collectionView;
}

-(MLCenterEffectLayout *)layout {
    if (!_layout) {
        _layout = [[MLCenterEffectLayout alloc] init];
        _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    return _layout;
}

@end
