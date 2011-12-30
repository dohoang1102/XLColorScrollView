//
//  XLColorScrollView.m
//  
//
//  Created by Richard Wei on 11-10-1.
//  Copyright 2011 Xinranmsn Labs. All rights reserved.
//

#import "XLColorScrollView.h"


#define kEdgeWidthToRectWidthRatio 0.025

@implementation XLColorScrollView
@synthesize verticalAnchorOffset = _verticalAnchorOffset;
@synthesize verticalContentOffset = _verticalContentOffset;
@synthesize colors = _colors;
@synthesize colorView = _colorView;
@synthesize squareLength = _squareLength;
@synthesize edgeColor = _edgeColor;

- (id)initWithFrame:(CGRect)frame colors:(NSArray *)colors edgeColor:(UIColor *)edgeColor verticalAnchorOffset:(CGFloat)verticalAnchorOffset {
    if ((self = [super initWithFrame:frame])) {
        _colors = [colors retain];
        _edgeColor = edgeColor;
        CGColorRef edgeCGColor = _edgeColor.CGColor;
        _verticalAnchorOffset = verticalAnchorOffset;
        CGSize size = frame.size;
        _squareLength = size.width;
        CGFloat height = size.height;
        _touchOffset = height * 0.5 + _verticalAnchorOffset;
        int count = _colors.count;
        self.contentSize = CGSizeMake(_squareLength, _squareLength * count + height - _squareLength);
        self.showsVerticalScrollIndicator = NO;
        self.showsHorizontalScrollIndicator = NO;
        CGFloat edgeWidth = kEdgeWidthToRectWidthRatio * _squareLength;
        UIGraphicsBeginImageContext(self.contentSize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGRect colorRect = CGRectMake(5.0f, height/2-35.0f+_verticalAnchorOffset, _squareLength-10.0f, _squareLength-10.0f);
        for (UIColor *color in _colors) {
            CGContextSetFillColorWithColor(context, color.CGColor);
            CGContextAddRect(context, colorRect);
            CGContextDrawPath(context, kCGPathFill);
            CGContextSetLineWidth(context, edgeWidth);
            CGContextSetStrokeColorWithColor(context, edgeCGColor);
            CGContextAddRect(context, colorRect);
            CGContextDrawPath(context, kCGPathStroke);
            colorRect.origin.y += _squareLength;
        }
        UIImage *colorImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        UIImageView *colorView = [[UIImageView alloc] initWithImage:colorImage];
        [self addSubview:colorView];
        [colorView release];
    }
    return self;
}

- (void)setVerticalContentOffset:(CGFloat)verticalContentOffset animated:(BOOL)animated {
    [self setContentOffset:CGPointMake(self.contentOffset.x, verticalContentOffset) animated:YES];
}

- (void)setVerticalContentOffset:(CGFloat)verticalContentOffset {
    [self setContentOffset:CGPointMake(self.contentOffset.x, verticalContentOffset)];
}

- (CGFloat)verticalContentOffset {
    return self.contentOffset.y;
}

- (void)scrollToIndex:(NSUInteger)index {
    if (index >= _colors.count) return;
    [self setContentOffset:CGPointMake(0.0, index * _squareLength) animated:YES];
}

- (NSUInteger)currentIndex {
    NSUInteger retIndex = roundf(self.verticalContentOffset/_squareLength);
    if (self.verticalContentOffset < 0) return 0;
    if (retIndex >= _colors.count) return _colors.count - 1;
    return retIndex;
}

- (void)scrollToNearest {
    [self scrollToIndex:self.currentIndex];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touches.count == 1) {
        UITouch *touch = touches.anyObject;
        _tapPoint = [touch locationInView:touch.view];
        _touchNotMoved = YES;
    }
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    _touchNotMoved = NO;
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (touches.count == 1 && _touchNotMoved) {
        UITouch *touch = touches.anyObject;
        CGPoint point = [touch locationInView:touch.view];
        if (CGPointEqualToPoint(_tapPoint, point)) {
            [self scrollToIndex:(NSUInteger)roundf((_tapPoint.y-_touchOffset)/_squareLength)];
        }
    }
    [super touchesEnded:touches withEvent:event];
}

- (void)dealloc {
    [_colors release];
    [super dealloc];
}

@end
