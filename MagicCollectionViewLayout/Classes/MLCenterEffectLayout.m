//
//  MLCenterEffectLayout.m
//  MagicCollectionViewLayout
//
//  Created by Sun,Shaobo on 2020/5/27.
//

#import "MLCenterEffectLayout.h"

@implementation MLCenterEffectLayout

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *layouts = [super layoutAttributesForElementsInRect:rect];
    CGFloat offsize = self.collectionView.contentOffset.x;
    CGFloat cWidth = self.collectionView.bounds.size.width;
    CGFloat realCenterX = offsize + cWidth * 0.5;
    for (UICollectionViewLayoutAttributes *attr in layouts) {
        CGFloat scale = 1;
        if (fabs(attr.center.x - realCenterX) <= cWidth) {
            scale = 1 - fabs(attr.center.x - realCenterX) / cWidth;
        }
        CGFloat scaleW = 0.8 + 0.2 * scale;
        CGFloat scaleH = 0.2 + 0.8 * scale;
        attr.transform = CGAffineTransformMakeScale(scaleW, scaleH);
        attr.alpha = scaleH;
    }
    return layouts;
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity {
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;
    NSArray *array = [super layoutAttributesForElementsInRect:rect];
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array) {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX)) {
            minDelta = attrs.center.x - centerX;
        }
    }
    proposedContentOffset.x += minDelta;
    return proposedContentOffset;
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds {
    return YES;
}

@end
