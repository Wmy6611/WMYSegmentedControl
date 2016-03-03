//
//  WMYSegmentedControl.h
//  Workspace
//
//  Created by Wmy on 16/3/3.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WMYSegmentedControl;
@protocol WMYSegmentedControlDelegate <NSObject>
- (void)segmentControl:(WMYSegmentedControl *)segmentCtrl clickedSegmentAtIndex:(NSInteger)segmentIndex;
@end


@interface WMYSegmentedControl : UIView

@property (nonatomic, weak) id<WMYSegmentedControlDelegate> delegate;
@property (nonatomic, strong, nullable) NSArray *segments;
@property (nonatomic) NSInteger selectedSegmentIndex;

@end

NS_ASSUME_NONNULL_END