# SStarView

A starView for iOS.

## Download

You can [download SStarView from here](https://github.com/shingwasix/SStarView).

## Screenshot

![SStarView](https://raw.githubusercontent.com/shingwasix/SStarView/master/screenshoot.png)

# Requirements

(1) iOS 6.0 and above.

(2) ARC

# Building

(1) Download the source code.

(2) Add SStarView.h and SStarView.m in your project.

(3) If your project is not supporting ARC,you need to add compiler flag "-fobjc-arc" for SStarView.m.

# Sample Code

```
//Create a 100px * 30px starView
SStarView *starView = [[SStarView alloc] initWithFrame:CGRectMake(50, 90, 100, 30)];
[self.view addSubview:starView];
starView.starCount = 2; //Set star number of starView
```

```
//Create a 220px * 30px width starView
SStarView *starView = [[SStarView alloc] initWithFrame:CGRectMake(50, 260, 220, 30)];
[self.view addSubview:starView];
starView.starCount = 5; //Set star number of starView
starView.unSelectColor = [UIColor greenColor]; //Set starView unselect color
starView.lineWidth = 0.0; //Set starView border width
[starView setUserInteractionEnabled:NO]; //Disable droping starView
```

# Profile

[CocosPods](http://cocosPods.org) is the recommended methods of installation SStarView, just add the following line to `Profile`:

```
pod 'SStarView', :git=>"https://github.com/shingwasix/SStarView.git"
```

# License

Copyright (c) 2012 waaile.com

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
