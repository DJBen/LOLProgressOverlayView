# LOLProgressOverlayView

[![Version](http://cocoapod-badges.herokuapp.com/v/LOLProgressOverlayView/badge.png)](http://cocoadocs.org/docsets/LOLProgressOverlayView)
[![Platform](http://cocoapod-badges.herokuapp.com/p/LOLProgressOverlayView/badge.png)](http://cocoadocs.org/docsets/LOLProgressOverlayView)

UIButton / UIView category that add a progress indicator overlay simply with single line of code.

## Usage

To run the example project; clone the repo, and run `pod install` from the Project directory first, or simply import `LOLProgressOverlayView.h` and `.m` file into your project.

Say you have a button or a view, just type single line of code

``[button setProgress: 0.75];``
or
``[view setProgress: 0.3];``

and you see the effect.

## Effect
![Effect](https://raw.github.com/DJBen/LOLProgressOverlayView/master/LOLProgressOverlayViewExample.png)

## Customizations

You can set your own colors: `overlayColor` and `backgroundMaskColor` by using method below:

``-[UIView setOverlayColor:setBackgroundMaskColor:];``

## Requirements

iOS 6 and above.

## Installation

LOLProgressOverlayView is available through [CocoaPods](http://cocoapods.org), to install
it simply add the following line to your Podfile:

    pod "LOLProgressOverlayView"

## Author

DJ.Ben, lsh32768@gmail.com

## License

LOLProgressOverlayView is available under the MIT license. See the LICENSE file for more info.

