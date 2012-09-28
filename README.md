# MBAcionSheet

## Overview

**MBActionSheet** is a Multiple Button ActionSheet to mimic the cocoa control UIActionSheet. Basically, it can have multi buttons on a line as the screen shot displayed. 

The usage of MBActionSheet is almost the same as the UIActionSheet; adding the delegate protocol into the interface and implement the protocol method; using the tag and button index to distingush which sheet and button were pressed. The only difference is you must specify the other buttons' line count and how many buttons you would like to have on each line. Please refer to the sample project.

Also the funtionalities of MBActionSheet is very similar with the UIActionSheet. It will slide into the screen from the bottom and slide out inversely. The background is 40% transparent. If there is navigation bar, the bar will be transparent and disabled when MBActionSheet is on the screen.

![Screen Shot](https://github.com/russj/MBActionSheet/blob/master/Screen%20Shot.png?raw=true)

##Requirements
* iOS 5.0 and above
* Xcode 4.2 and above (MBActionSheet uses ARC.)
* Frameworks: Foundation, UIKit, CoreGraphics
* Support iPhone5 


##License
This code is distributed under the terms and conditions of the MIT license.

Copyright (c) 2012 Lei Jing (Russell.jing@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

## Release Note

### Version 0.1 
28.9.2012

