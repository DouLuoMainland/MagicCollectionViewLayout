//
//  MLCycleLayout.m
//  Pods-MagicCollectionViewLayout_Example
//
//  Created by Sun,Shaobo on 2020/5/27.
//

#import "MLCycleLayout.h"

@interface MLCycleLayout()
@property (nonatomic, strong) NSMutableArray *layouts;
@end

@implementation MLCycleLayout

- (void)prepareLayout {
    [super prepareLayout];
    // 先把全部的都缓存起来哦
    NSMutableArray *layouts = [NSMutableArray array];
    long cellCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat collectionW = self.collectionView.bounds.size.width ;
    //    CGFloat radio = (collectionW - self.itemSize.width ) * 0.5;
    CGFloat degrees = 2 * M_PI / cellCount;
    for (int i = 0; i< cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGFloat w = self.itemSize.width;
        CGFloat h = self.itemSize.height;
        CGFloat cx = collectionW * 0.5 + sin(degrees * i) * self.radius;
        CGFloat cy = collectionW * 0.5 - cos(degrees * i) * self.radius;
        att.frame = CGRectMake(0, 0, w, h);
        att.center = CGPointMake(cx, cy);
        [layouts addObject:att];
    }
    self.layouts = layouts;
}

- (CGSize)collectionViewContentSize {
    return self.collectionView.bounds.size;
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layouts;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.layouts[indexPath.item];
}

@end

