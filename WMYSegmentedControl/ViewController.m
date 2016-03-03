//
//  ViewController.m
//  WMYSegmentedControl
//
//  Created by Wmy on 16/3/3.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "ViewController.h"
#import "WMYSegmentedControl.h"

@interface ViewController () <WMYSegmentedControlDelegate>
@property (nonatomic, weak) IBOutlet WMYSegmentedControl *segCtrl;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self example];
}

- (void)example {
    
    [_segCtrl setDelegate:self];
    [_segCtrl setSegments:@[@"index0", @"index1", @"index2", @"index3", @"index4"]];
    [_segCtrl setSelectedSegmentIndex:0];
}

#pragma mark - WMYSegmentedControlDelegate

- (void)segmentControl:(WMYSegmentedControl *)segmentCtrl clickedSegmentAtIndex:(NSInteger)segmentIndex {
    NSLog(@"%lu", segmentIndex);
}

@end
