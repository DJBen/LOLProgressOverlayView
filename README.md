LOLProgressOverlayView
======================

UIButton / UIView category that add a League of Legends style progress indicator overlay simply in single line of code.

Usage
----------------------
Import `LOLProgressOverlayView.h` and `.m` file into your project.

Say you have a button or a view, just type single line of code

``[button setProgress: 0.75];``
or
``[view setProgress: 0.3];``

and you see the effect.

Effect
----------------------
![Effect](https://raw.github.com/DJBen/LOLProgressOverlayView/master/LOLProgressOverlayViewExample.png)

Customizations
----------------------
You can set your own colors: `overlayColor` and `backgroundMaskColor` by using method below:

``-[UIView setOverlayColor:setBackgroundMaskColor:];``
