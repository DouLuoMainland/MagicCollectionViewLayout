//
//  MLCycleLayoutViewController.m
//  MagicCollectionViewLayout_Example
//
//  Created by Sun,Shaobo on 2020/5/27.
//  Copyright © 2020 Sun,Shaobo. All rights reserved.
//

#import "MLCycleLayoutViewController.h"
#import "MLCycleLayout.h"
#import "MLCycleCell.h"
#define CellWidth 50
@interface MLCycleLayoutViewController () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MLCycleLayout *layout;
@property (nonatomic, assign) CGPoint startCtrlPoint;
@property (nonatomic, assign) NSInteger datas;
@end

@implementation MLCycleLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initUI];
    [self.collectionView reloadData];
    [self addRotateEffect];
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
    cell.layer.cornerRadius = CellWidth * 0.5;
    cell.layer.masksToBounds = YES;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%ld",(long)indexPath.item);
}

#pragma mark - lazy

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.frame = CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.width);
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MLCycleCell class]) bundle:nil] forCellWithReuseIdentifier:NSStringFromClass([MLCycleCell class])];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor grayColor];
    }
    return _collectionView;
}

-(MLCycleLayout *)layout {
    if (!_layout) {
        _layout = [[MLCycleLayout alloc] init];
        _layout.itemSize = CGSizeMake(CellWidth, CellWidth);
        _layout.radius = [UIScreen mainScreen].bounds.size.width * 0.5 - CellWidth * 0.5 - 10;
    }
    return _layout;
}

- (void)addRotateEffect {
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.collectionView addGestureRecognizer:pan];
    self.collectionView.layer.cornerRadius = self.collectionView.bounds.size.width * 0.5;
    self.collectionView.layer.masksToBounds = YES;
}

- (void)panAction:(UIPanGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        self.startCtrlPoint = [sender locationInView:sender.view.superview];
        return;
    }
    CGPoint ctrlPoint = [sender locationInView:sender.view.superview];
    [self rotateAroundOPointWithCtrlPoint:ctrlPoint];
    self.startCtrlPoint = ctrlPoint;
}

- (void)rotateAroundOPointWithCtrlPoint:(CGPoint)ctrlPoint {
    float angle = atan2(self.collectionView.center.y - ctrlPoint.y, self.collectionView.center.x - ctrlPoint.x);
    float lastAngle = atan2(self.collectionView.center.y - self.startCtrlPoint.y,  self.collectionView.center.x - self.startCtrlPoint.x );
    angle = angle - lastAngle;
    self.collectionView.transform = CGAffineTransformRotate(self.collectionView.transform, angle);
    [self.collectionView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[MLCycleCell class]]) {
            obj.transform = CGAffineTransformRotate(obj.transform, -angle);
        }
    }];
}

@end
