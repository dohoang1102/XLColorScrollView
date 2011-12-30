//
//  XLColorScrollView.h
//  
//
//  Created by Richard Wei on 11-10-1.
//  Copyright 2011 Xinranmsn Labs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface XLColorScrollView : UIScrollView {
    NSArray *_colors;
    UIImageView *_colorView;
    CGFloat _verticalAnchorOffset;
    CGFloat _touchOffset;
    CGFloat _squareLength;
    UIColor *_edgeColor;
    CGPoint _tapPoint;
    BOOL _touchNotMoved;
}

@property (nonatomic, readonly) NSArray *colors;
@property (nonatomic, readonly) UIImageView *colorView;
@property (nonatomic, readonly) CGFloat verticalAnchorOffset;
@property (nonatomic, readonly) CGFloat squareLength;
@property (nonatomic) CGFloat verticalContentOffset;
@property (nonatomic, readonly) UIColor *edgeColor;

// Initializer
- (id)initWithFrame:(CGRect)frame colors:(NSArray *)colors edgeColor:(UIColor *)edgeColor verticalAnchorOffset:(CGFloat)verticalAnchorOffset;

- (void)scrollToIndex:(NSUInteger)index;
- (NSUInteger)currentIndex;
- (void)scrollToNearest;
- (void)setVerticalContentOffset:(CGFloat)verticalContentOffset animated:(BOOL)animated;

@end
