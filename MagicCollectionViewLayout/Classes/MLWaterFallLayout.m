//
//  MLWaterFallLayout.m
//  MagicCollectionViewLayout
//
//  Created by Sun,Shaobo on 2020/5/27.
//

#import "MLWaterFallLayout.h"

@interface MLWaterFallLayout()
@property (nonatomic, strong) NSMutableArray *layouts;
@property (nonatomic, assign) CGFloat maxHeight;
@end

@implementation MLWaterFallLayout

- (instancetype)init {
    self = [super init];
    if (self) {
        self.colNum = 2;
        self.colMagin = 0;
        self.itemMagin = 0;
    }
    return self;
}

- (NSInteger)indexForMinValue:(NSArray <NSNumber *>*)array {
    NSInteger min = 0;
    for (int i = 1; i < array.count; i++) {
        if ( [array[i] floatValue] < [array[min] floatValue] ) {
            min = i;
        }
    }
    return min;
}

- (NSInteger)indexForMaxValue:(NSArray <NSNumber *>*)array {
    NSInteger max = 0;
    for (int i = 1; i < array.count; i++) {
        if ([array[i] floatValue] > [array[max] floatValue]) {
            max = i;
        }
    }
    return max;
}

- (void)prepareLayout {
    [super prepareLayout];
    
    NSMutableArray *layouts = [NSMutableArray array];
    NSMutableArray <NSNumber *>*colMinHeightArray = [NSMutableArray arrayWithCapacity:self.colNum];
    for (int i = 0; i < self.colNum; i++) {
        [colMinHeightArray addObject:@(0)];
    }
    long cellCount = [self.collectionView numberOfItemsInSection:0];
    CGFloat validWidth = self.collectionView.bounds.size.width - self.collectionView.contentInset.right - self.collectionView.contentInset.left;
    
    CGFloat cellWidth = (validWidth - self.colMagin * (self.colNum - 1)) / self.colNum;
    
    for (int i = 0; i< cellCount; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *att = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
        CGFloat cellHeight = [self.delegate heightForItemAtIndexPath:indexPath width:cellWidth];
        // 默认放在
        NSInteger minHeightColIndex = [self indexForMinValue:colMinHeightArray];
        CGFloat x = (cellWidth + self.colMagin) * minHeightColIndex;
        
        CGFloat y = [colMinHeightArray[minHeightColIndex] floatValue];
        if (y > 0) {
            y += self.itemMagin;
        }
        colMinHeightArray[minHeightColIndex] = @(y + cellHeight);
        
        att.frame = CGRectMake(x, y, cellWidth, cellHeight);
        [layouts addObject:att];
    }
    self.maxHeight = [colMinHeightArray[[self indexForMaxValue:colMinHeightArray]] floatValue];
    self.layouts = layouts;
}

- (CGSize)collectionViewContentSize {
    return CGSizeMake(0, self.maxHeight);
}

- (nullable NSArray<__kindof UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    return self.layouts;
}

- (nullable UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath {
    return self.layouts[indexPath.item];
}

@end

