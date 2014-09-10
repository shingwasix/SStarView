//
//  SStarView.h
//
//  1.0.2
//
//  Created by Shingwa Six on 12-10-10.
//  Copyright (c) 2012年 waaile.com All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#import <UIKit/UIKit.h>

@interface SStarView : UIControl
@property (assign, nonatomic) NSUInteger maxStar;
@property (assign, nonatomic) NSUInteger minStar;
@property (assign, nonatomic) NSUInteger starCount;
@property (assign, nonatomic) CGFloat lineWidth;

@property (copy, nonatomic) UIColor *borderColor;
@property (copy, nonatomic) UIColor *selectColor;
@property (copy, nonatomic) UIColor *unSelectColor;
@end
