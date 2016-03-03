//
//  WMYSegmentedControl.m
//  Workspace
//
//  Created by Wmy on 16/3/3.
//  Copyright © 2016年 Wmy. All rights reserved.
//

#import "WMYSegmentedControl.h"

@interface WMYSegmentedControl ()
@property (nonatomic, strong) UIVisualEffectView *bgVisualEffectView;
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation WMYSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self configureUI];
    }
    return self;
}

- (void)awakeFromNib {
    [self configureUI];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect rect = self.bounds;
    CGFloat selfW = rect.size.width;
    CGFloat selfH = rect.size.height;
    
    CGFloat btnW = selfW / _segments.count;
    CGFloat btnH = selfH - 1;
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)subView;
            CGFloat btnX = btn.tag * btnW;
            btn.frame = CGRectMake(btnX, 0, btnW, btnH);
        }
        
        
        if ([subView isKindOfClass:[UIView class]]) {
            UIView *line = (UIView *)subView;
            if (line.tag > 200) {
                line.frame = CGRectMake((line.tag - 200) * btnW, 10, 0.5, btnH - 20);
            }
        }
    }
    
    
}


#pragma mark - event response

- (void)responseSegmentedControlChangeSelectedIndex:(NSInteger)index {

    if (_delegate && [_delegate respondsToSelector:@selector(segmentControl:clickedSegmentAtIndex:)]) {
        [_delegate segmentControl:self clickedSegmentAtIndex:index];
    }else
        NSLog(@"you need add 'delegate' and responds selector (segmentControl:clickedSegmentAtIndex:)");
}

- (void)actionWithSegCtrl:(id)sender {
    UIButton *button = (UIButton *)sender;
    
    [self setSelectedSegmentIndex:button.tag];
}

#pragma mark - setter

- (void)setSelectedSegmentIndex:(NSInteger)selectedSegmentIndex {
    _selectedSegmentIndex = selectedSegmentIndex;
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)subView;
            if (selectedSegmentIndex == btn.tag)
            {
                btn.selected = YES;
                btn.userInteractionEnabled = NO;
                [self responseSegmentedControlChangeSelectedIndex:selectedSegmentIndex];
            }else {
                btn.selected = NO;
                btn.userInteractionEnabled = YES;
            }
        }
    }
}

- (void)setSegments:(NSArray *)segments {
    _segments = segments;
    
    if (segments.count) {
        
        // 添加btn
        for (int i = 0; i<segments.count; i++) {
            [self addSubview:[self segmentBtnWithTitleStr:segments[i] tag:i]];
        }
        
        // 添加分割线
        for (int i = 0; i<segments.count - 1; i++) {
            [self addSubview:[self lineViewWithTag:201 + i]];
        }
    }
}

#pragma mark - configureUI

- (void)configureUI {
    
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.68];

    [self addSubview:self.bgVisualEffectView];
    [self addSubview:self.bottomLine];
    
    [self addVFL];
}

#pragma mark - getter

- (UIView *)bottomLine {
    if (!_bottomLine) {

        _bottomLine = ({
            UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
            view.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.1];
            view.translatesAutoresizingMaskIntoConstraints = NO;
            view;
        });
    }
    return _bottomLine;
}

- (UIVisualEffectView *)bgVisualEffectView {
    if (_bgVisualEffectView == nil) {
        
        _bgVisualEffectView = ({
            UIVisualEffectView *visualEffectView = [[UIVisualEffectView alloc] initWithEffect:[UIBlurEffect effectWithStyle:UIBlurEffectStyleLight]];
            visualEffectView.translatesAutoresizingMaskIntoConstraints = NO;
            visualEffectView.alpha = 1.0;
            visualEffectView;
        });
    }
    return _bgVisualEffectView;
}

#pragma mark - vfl

- (void)addVFL {
    
    NSString *vfl1 = @"H:|-0-[bgVEView]-0-|";
    NSString *vfl2 = @"V:|-0-[bgVEView]-0.5-|";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl1
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:@{@"bgVEView":_bgVisualEffectView}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl2
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:@{@"bgVEView":_bgVisualEffectView}]];

    NSString *vfl3 = @"H:|-0-[bottomLine]-0-|";
    NSString *vfl4 = @"V:[bottomLine(0.5)]-0-|";
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl3
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:@{@"bottomLine":_bottomLine}]];
    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:vfl4
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:@{@"bottomLine":_bottomLine}]];
}

#pragma mark - instantiation

- (UIView *)lineViewWithTag:(NSInteger)tag {
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectZero];
    [line setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.1]];
    [line setTag:tag];
    return line;
}

- (UIButton *)segmentBtnWithTitleStr:(NSString *)title tag:(NSInteger)tag {
    
    UIButton *segment = [UIButton buttonWithType:UIButtonTypeCustom];
    
    NSMutableAttributedString *normalTitle = [[NSMutableAttributedString alloc] initWithString:title];
    [normalTitle addAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14],
                                 NSForegroundColorAttributeName:[UIColor blackColor]}
                         range:NSMakeRange(0, title.length)];
    
    NSMutableAttributedString *selectedTitle = [[NSMutableAttributedString alloc] initWithString:title];
    [selectedTitle addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16],
                                   NSForegroundColorAttributeName:[UIColor redColor]}
                           range:NSMakeRange(0, title.length)];
    
    [segment setAttributedTitle:normalTitle forState:UIControlStateNormal];
    [segment setAttributedTitle:selectedTitle forState:UIControlStateSelected];
    
    [segment setTag:tag];
    [segment addTarget:self action:@selector(actionWithSegCtrl:) forControlEvents:UIControlEventTouchUpInside];
    
    return segment;
}

@end
