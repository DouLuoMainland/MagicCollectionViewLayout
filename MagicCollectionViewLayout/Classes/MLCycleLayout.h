//
//  MLCycleLayout.h
//  Pods-MagicCollectionViewLayout_Example
//
//  Created by Sun,Shaobo on 2020/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MLCycleLayout : UICollectionViewLayout
// 每个item的大小.
@property (nonatomic, assign) CGSize itemSize;
/// collectionView的center 到 item的center 的距离
@property (nonatomic, assign) CGFloat radius;
@end

NS_ASSUME_NONNULL_END
