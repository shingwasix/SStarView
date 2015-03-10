//
//  SStarView.m
//
//  1.0.3 (15-03-10)
//
//  Created by Shingwa Six on 12-10-10.
//  Copyright (c) 2012年 WAAILE.com All rights reserved.
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

#import "SStarView.h"

@interface SStarView()
@property (retain, nonatomic) UIImage *imgSelected;
@property (retain, nonatomic) UIImage *imgUnSelected;

- (void)refresh;
@end

@implementation SStarView
@synthesize borderColor = _borderColor;
@synthesize selectColor = _selectColor;
@synthesize unSelectColor = _unSelectColor;
@synthesize maxStar = _maxStar;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self secondPart];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self secondPart];
    }
    return self;
}

- (void)secondPart
{
    _maxStar = self.frame.size.width / self.frame.size.height;
    _lineWidth = self.frame.size.height / 20;
    _starCount = 0;
    _minStar = 0;
    
    [self refresh];
}

- (void)setMaxStar:(NSUInteger)maxStar
{
    _maxStar = maxStar;
    [self refresh];
}

- (NSUInteger)maxStar
{
    if (_maxStar < 1) {
        _maxStar = 1;
    }
    return _maxStar;
}

- (void)setMinStar:(NSUInteger)minStar
{
    _minStar = minStar;
    if (_starCount < _minStar) {
        _starCount = _minStar;
    }
    [self refresh];
}

- (void)setStarCount:(NSUInteger)starCount
{
    if (starCount > _maxStar) {
        starCount = _maxStar;
    }
    else if (starCount < _minStar) {
        starCount = _minStar;
    }
    if (starCount == _starCount) {
        return;
    }
    _starCount = starCount;
    [self refresh];
    [self sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)setBorderColor:(UIColor *)borderColor
{
    if (!borderColor) {
        return;
    }
    _borderColor = borderColor;
    
    self.imgSelected = nil;
    self.imgUnSelected = nil;
    [self refresh];
}

- (void)setSelectColor:(UIColor *)selectColor
{
    if (!selectColor) {
        return;
    }
    _selectColor = selectColor;
    
    self.imgSelected = nil;
    self.imgUnSelected = nil;
    [self refresh];
}

- (void)setUnSelectColor:(UIColor *)unSelectColor
{
    if (!unSelectColor) {
        return;
    }
    _unSelectColor = unSelectColor;
    
    self.imgSelected = nil;
    self.imgUnSelected = nil;
    [self refresh];
}

- (UIColor *)borderColor
{
    if (!_borderColor) {
        _borderColor = [UIColor grayColor];
    }
    return _borderColor;
}

- (UIColor *)selectColor
{
    if (!_selectColor) {
        _selectColor = [UIColor colorWithRed:251.0/255 green:219.0/255 blue:0.0 alpha:1.0];
    }
    return _selectColor;
}

- (UIColor *)unSelectColor
{
    if (!_unSelectColor) {
        _unSelectColor = [UIColor colorWithWhite:0.8 alpha:1.0];
    }
    return _unSelectColor;
}

- (void)didMoveToSuperview
{
    [self refresh];
}

- (UIImage *)imgSelected
{
    if (!_imgSelected) {
        _imgSelected = [self createImgWithHeight:self.bounds.size.height color:_selectColor];
    }
    return _imgSelected;
}

- (UIImage *)imgUnSelected 
{
    if (!_imgUnSelected) {
        _imgUnSelected = [self createImgWithHeight:self.bounds.size.height color:_unSelectColor];
    }
    return _imgUnSelected;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    self.imgSelected = nil;
    self.imgUnSelected = nil;
    [self refresh];
}

- (void)setLineWidth:(CGFloat)lineWidth
{
    _lineWidth = lineWidth;
    
    self.imgSelected = nil;
    self.imgUnSelected = nil;
    [self refresh];
}

- (void)refresh
{
#if !TARGET_INTERFACE_BUILDER
    if (![self superview]) {
        return;
    }
    
    NSArray *views = [self subviews];
    for (UIView *v in views) {
        [v removeFromSuperview];
    }
    
    if (self.maxStar < 1) {
        return;
    }
    
    if (self.maxStar > INFINITY) {
        return;
    }
    
    NSUInteger w = self.bounds.size.width / self.maxStar;
    NSUInteger sh = self.bounds.size.height;
    NSUInteger x = (w - sh) / 2;
    
    for (NSUInteger i = 0; i < self.maxStar; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, sh, sh)];
        img.contentMode = UIViewContentModeCenter;
        if (i < self.starCount) {
            img.image = self.imgSelected;
        } else {
            img.image = self.imgUnSelected;
        }
        [self addSubview:img];
        x += w;
    }
#endif
}

- (UIImage *)createImgWithHeight:(CGFloat)height color:(UIColor *)color
{
    CGFloat r_l = height / powf(cosf(M_PI / 10), 2) / 2;
    CGFloat r_s = (cosf(M_PI / 5) - sinf(M_PI / 5) * tanf(M_PI / 5)) * r_l * 1.3;
    CGFloat width = r_l * 2 * cosf(M_PI / 10);
    
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(width, height), NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat c_x = width / 2;
    CGFloat c_y = r_l;
    
    CGFloat angle = M_PI_2;
    CGFloat a = M_PI / 5;
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPoint points[11];
    for (NSInteger i = 0; i < sizeof(points) / sizeof(CGPoint); i++) {
        if (i % 2) {
            points[i].x = c_x + r_s * cosf(angle);
            points[i].y = c_y - r_s * sinf(angle);
        } else {
            points[i].x = c_x + r_l * cosf(angle);
            points[i].y = c_y - r_l * sinf(angle);
        }
        
        angle += a;
    }
    CGPathAddLines(path, &CGAffineTransformIdentity, points, sizeof(points) / sizeof(CGPoint));
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextAddPath(context, path);
    CGContextFillPath(context);
    CGContextAddPath(context, path);
    if (self.lineWidth > 0.0) {
        CGContextSetLineWidth(context, self.lineWidth);
        CGContextSetStrokeColorWithColor(context, self.borderColor.CGColor);
        CGContextStrokePath(context);
    }
    CGPathRelease(path);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    return img;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    CGFloat w = self.bounds.size.width / self.maxStar;
    NSInteger count = pt.x / w + 1;
    if (count < 0) {
        count = 0;
    }
    if (count > self.maxStar) {
        count = self.maxStar;
    }
    self.starCount = count;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    CGFloat w = self.bounds.size.width / self.maxStar;
    NSInteger count = pt.x / w + 1;
    if (count < 0) {
        count = 0;
    }
    if (count > self.maxStar) {
        count = self.maxStar;
    }
    self.starCount = count;
}

@end
