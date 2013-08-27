//
//  LOLProgressOverlayView.h
//  LOL Timer
//
//  Created by Sihao Lu on 8/20/13.
//  Copyright (c) 2013 Sihao Lu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LOLProgressOverlayView : UIView

/** 
 * The progress of overlay view ranged from 0.0 to 1.0.
 */
@property (nonatomic) CGFloat progress;

/**
 * Initializes and returns a newly allocated view object with the specified frame rectangle and progress.
 * @param frame The frame rectangle for the view, measured in points. The origin of the frame is relative to the superview in which you plan to add it. This method uses the frame rectangle to set the center and bounds properties accordingly.
 * @param progress The progress of overlay view.
 * @return A instance of progress overlay view.
 */
- (id)initWithFrame:(CGRect)frame progress:(CGFloat)progress;

/**
 * The color of the overlay.
 */
@property (nonatomic, strong) UIColor *overlayColor;

/**
 * The color of background mask. Only visible when the progress is not 1.0.
 */
@property (nonatomic, strong) UIColor *backgroundMaskColor;

@end

@interface UIButton (LOLProgressOverlay)

/**
 * Initialize a button with progress overlay.
 */
+ (instancetype)buttonWithProgressOverlay;

@end

@interface UIView (LOLProgressOverlay)

/** 
 * Returns the progress overlay view on current UIView instance. 
 * @discussion Will create an instance and automatically add to current view's subview list if progress overlay is created first time.
 * @return The progress overlay view.
 */
- (LOLProgressOverlayView *)progressOverlay;

/**
 * Set the progress of progress overlay view.
 * @discussion The overlay will not draw when progress is set to 1.0.
 * @param progress The progress of overlay view.
 */
- (void)setProgress:(CGFloat)progress;

/**
 * Returns the current progress of overlay view.
 * @return The progress of overlay view.
 */
- (CGFloat)progress;

/**
 * Set the overlay color and background mask color.
 * @discussion The default value of overlayColor is #0000ff with alpha 0.5. The default value of backgroundMaskColor is #0000ff with alpha 0.25.
 */
- (void)setOverlayColor:(UIColor *)overlayColor backgroundMaskColor:(UIColor *)backgroundMaskColor;

@end