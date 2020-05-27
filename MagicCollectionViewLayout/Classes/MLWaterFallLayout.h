//
//  MLWaterFallLayout.h
//  MagicCollectionViewLayout
//
//  Created by Sun,Shaobo on 2020/5/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MLWaterFallLayoutDelegate <NSObject>

- (CGFloat)heightForItemAtIndexPath:(NSIndexPath *)indexPath width:(CGFloat)width;

@end

@interface MLWaterFallLayout : UICollectionViewLayout
@property (nonatomic, weak) id<MLWaterFallLayoutDelegate> delegate;
@property (nonatomic, assign) NSInteger colNum; // default 2
@property (nonatomic, assign) CGFloat colMagin; // default 0
@property (nonatomic, assign) CGFloat itemMagin; // default 0
@end

NS_ASSUME_NONNULL_END
