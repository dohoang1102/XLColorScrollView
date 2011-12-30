//
//  XLCSVViewController.h
//  XLColorScrollView
//
//  Created by Richard Wei on 11-12-30.
//  Copyright (c) 2011年 Xinranmsn Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>

@class XLColorScrollView;

@interface XLCSVViewController : UIViewController <UIScrollViewDelegate> {
    XLColorScrollView *colorScrollView;
    SystemSoundID bSoundID;
    NSUInteger colorScrollViewCurrentIndex;
}

@end
