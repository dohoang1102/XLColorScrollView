//
//  XLCSVViewController.m
//  XLColorScrollView
//
//  Created by Richard Wei on 11-12-30.
//  Copyright (c) 2011年 Xinranmsn Labs. All rights reserved.
//

#import "XLCSVViewController.h"
#import "XLColorScrollView.h"

@implementation XLCSVViewController

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    NSArray *colors = [NSArray arrayWithObjects:[UIColor blueColor],
                                                [UIColor redColor],
                                                [UIColor yellowColor],
                                                [UIColor purpleColor],
                                                [UIColor blackColor],
                                                [UIColor grayColor],
                                                [UIColor brownColor],
                                                nil];
    colorScrollView = [[XLColorScrollView alloc] initWithFrame:CGRectMake(100.0, 0.0, 80.0, 480.0) colors:colors edgeColor:[UIColor blackColor] verticalAnchorOffset:0.0];
    colorScrollView.delegate = self;
    [self.view addSubview:colorScrollView];
    
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGColorRef strokeColor = [UIColor blackColor].CGColor;
    CGContextSetStrokeColorWithColor(context, strokeColor);
    CGContextSetLineWidth(context, 2.0);
    CGFloat fillColor[] = {0.5, 0.5, 0.5, 1.0};
    CGContextSetFillColor(context, fillColor);
    CGContextAddRect(context, CGRectMake(-2.0, 200.0, 324.0, 80.0));
    CGContextDrawPath(context, kCGPathFillStroke);
    UIImage *lineImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageView *selectionView = [[UIImageView alloc] initWithImage:lineImage];
    [self.view addSubview:selectionView];
    [selectionView release];
    
    NSURL *bSoundURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"B" ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((CFURLRef)bSoundURL, &bSoundID);
    
    [super viewDidLoad];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (colorScrollView.currentIndex != colorScrollViewCurrentIndex) {
        colorScrollViewCurrentIndex = colorScrollView.currentIndex;
        AudioServicesPlaySystemSound(bSoundID);
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (decelerate) return;
    [colorScrollView scrollToNearest];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    [colorScrollView scrollToNearest];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    [colorScrollView scrollToNearest];
}

- (void)dealloc {
    AudioServicesDisposeSystemSoundID(bSoundID);
    [colorScrollView release];
    [super dealloc];
}

@end
