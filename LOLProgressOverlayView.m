//
//  LOLProgressOverlayView.m
//  LOL Timer
//
//  Created by Sihao Lu on 8/20/13.
//  Copyright (c) 2013 Sihao Lu. All rights reserved.
//

#import "LOLProgressOverlayView.h"

// This value is the default tag value of overlay view.
// You can change this value freely as long as it remains different from all tags of your custom subviews.
#define kLOLProgressOverlayViewTag 1023

static inline double radians (double degrees) { return degrees * M_PI/180; }

@implementation LOLProgressOverlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:[UIColor clearColor]];
        [self setDefaultColors];
        self.tag = kLOLProgressOverlayViewTag;
        self.userInteractionEnabled = NO;
        
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame progress:(CGFloat)progress {
    self = [self initWithFrame:frame];
    if (self) {
        _progress = progress;
    }
    return self;
}

- (void)setDefaultColors {
    _overlayColor = [[UIColor blueColor] colorWithAlphaComponent:0.5];
    _backgroundMaskColor = [[UIColor blueColor] colorWithAlphaComponent:0.25];
}

- (void)setProgress:(CGFloat)progress {
    if (progress < 0.0) {
        _progress = 0.0;
    } else if (progress >= 1.0) {
        _progress = 1.0;
    } else {
        _progress = progress;
    }
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();

    // Limit drawing to rect
    CGContextSaveGState(context);
    CGContextAddPath(context, CGPathCreateWithRect(rect, NULL));
    CGContextRestoreGState(context);
    CGContextClip(context);
    
    if (self.progress < 0.0 || self.progress >= 1.0) return;
    
    // Add a light blue background mask
    CGContextAddPath(context, CGPathCreateWithRect(rect, NULL));
    CGContextSetFillColorWithColor(context, [self.backgroundMaskColor CGColor]);
    CGContextFillPath(context);
    
    // Create fan shape
    CGFloat startAngle = radians(-90);
    CGFloat endAngle = radians(-90 - (1.0 - self.progress) * 360);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddArc(path, NULL, self.bounds.size.width / 2, self.bounds.size.height / 2, MAX(self.bounds.size.width / 2, self.bounds.size.height / 2) * sqrtf(2), startAngle, endAngle, 1);
    CGPathAddLineToPoint(path, NULL, self.bounds.size.width / 2, self.bounds.size.height / 2);
    CGPathCloseSubpath(path);
    
    CGContextAddPath(context, path);
    
    // Fill path with color
    CGContextSetFillColorWithColor(context, [self.overlayColor CGColor]);

    // Set path stroke
    CGContextSetStrokeColorWithColor(context, [[[UIColor whiteColor] colorWithAlphaComponent:0.5] CGColor]);
    CGContextSetLineWidth(context, 1.0);
    CGContextDrawPath(context, kCGPathFillStroke);
    
    // Release path
    CFRelease(path);
}

@end

@implementation UIButton (LOLProgressOverlay)

+ (instancetype)buttonWithProgressOverlay {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    LOLProgressOverlayView *progressOverlay = [[LOLProgressOverlayView alloc] initWithFrame:button.bounds];
    [button insertSubview:progressOverlay belowSubview:button.titleLabel];
    return button;
}

- (LOLProgressOverlayView *)progressOverlay {
    LOLProgressOverlayView *progressOverlay = (LOLProgressOverlayView *)[self viewWithTag:kLOLProgressOverlayViewTag];
    if (!progressOverlay) {
        progressOverlay = [[LOLProgressOverlayView alloc] initWithFrame:self.bounds];
        [self insertSubview:progressOverlay belowSubview:self.titleLabel];
    }
    return progressOverlay;
}

@end

@implementation UIView (LOLProgressOverlay)

- (LOLProgressOverlayView *)progressOverlay {
    UIView *view = [self viewWithTag:kLOLProgressOverlayViewTag];
    if (view && ![view isKindOfClass:[LOLProgressOverlayView class]]) {
        NSLog(@"Warning! You have a subview of tag %d which is the same as default tag of LOLProgressOverlayView. Please either change your view's tag or change the default tag value of LOLProgressOverlayView.", kLOLProgressOverlayViewTag);
        return nil;
    }
    LOLProgressOverlayView *progressOverlay = (LOLProgressOverlayView *)view;
    if (!progressOverlay) {
        progressOverlay = [[LOLProgressOverlayView alloc] initWithFrame:self.bounds];
        [self addSubview:progressOverlay];
    }
    return progressOverlay;
}

- (void)setProgress:(CGFloat)progress {
    LOLProgressOverlayView *progressOverlay = [self progressOverlay];
    [progressOverlay setProgress:progress];
}

- (CGFloat)progress {
    LOLProgressOverlayView *progressOverlay = [self progressOverlay];
    return progressOverlay.progress;
}

- (void)setOverlayColor:(UIColor *)overlayColor backgroundMaskColor:(UIColor *)backgroundMaskColor {
    [[self progressOverlay] setOverlayColor:overlayColor];
    [[self progressOverlay] setBackgroundMaskColor:backgroundMaskColor];
    [[self progressOverlay] setNeedsDisplay];
}

@end