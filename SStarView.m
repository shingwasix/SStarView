//
//  SStarView.m
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

#import "SStarView.h"

@interface SStarView()
- (void)refresh;

@property (retain, nonatomic) UIImage *imgSelected;
@property (retain, nonatomic) UIImage *imgUnSelected;
@end

@implementation SStarView
@synthesize maxStar = _maxStar;
@synthesize minStar = _minStar;
@synthesize starCount = _starCount;
@synthesize lineWidth = _lineWidth;
@synthesize imgSelected = _imgSelected;
@synthesize imgUnSelected = _imgUnSelected;
@synthesize borderColor = _borderColor;
@synthesize selectColor = _selectColor;
@synthesize unSelectColor = _unSelectColor;

- (void)dealloc
{
    [_imgSelected release];
    [_imgUnSelected release];
    [_selectColor release];
    [_unSelectColor release];
    [super dealloc];
}

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
    _borderColor = [[UIColor grayColor] retain];
    _selectColor = [[UIColor colorWithRed:251.0/255 green:219.0/255 blue:0.0 alpha:1.0] retain];
    _unSelectColor = [[UIColor colorWithWhite:0.8 alpha:1.0] retain];
    
    [self refresh];
}

- (void)setMaxStar:(NSUInteger)maxStar
{
    _maxStar = maxStar;
    [self refresh];
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
    [_borderColor release];
    _borderColor = [borderColor retain];
    
    self.imgSelected = nil;
    self.imgUnSelected = nil;
    [self refresh];
}

- (void)setSelectColor:(UIColor *)selectColor
{
    if (!selectColor) {
        return;
    }
    [_selectColor release];
    _selectColor = [selectColor retain];
    
    self.imgSelected = nil;
    self.imgUnSelected = nil;
    [self refresh];
}

- (void)setUnSelectColor:(UIColor *)unSelectColor
{
    if (!unSelectColor) {
        return;
    }
    [_unSelectColor release];
    _unSelectColor = [unSelectColor copy];
    
    self.imgSelected = nil;
    self.imgUnSelected = nil;
    [self refresh];
}

- (void)didMoveToSuperview
{
    [self refresh];
}

- (UIImage *)imgSelected
{
    if (!_imgSelected) {
        self.imgSelected = [self createImgWithHeight:self.bounds.size.height color:_selectColor];
    }
    return _imgSelected;
}

- (UIImage *)imgUnSelected
{
    if (!_imgUnSelected) {
        self.imgUnSelected = [self createImgWithHeight:self.bounds.size.height color:_unSelectColor];
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
    if (![self superview]) {
        return;
    }
    
    NSArray *views = [self subviews];
    for (UIView *v in views) {
        [v removeFromSuperview];
    }
    
    if (_maxStar < 1) {
        return;
    }
    
    NSUInteger w = self.bounds.size.width / _maxStar;
    NSUInteger sh = self.bounds.size.height;
    NSUInteger x = (w - sh) / 2;
    
    for (NSUInteger i = 0; i < _maxStar; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(x, 0, sh, sh)];
        img.contentMode = UIViewContentModeCenter;
        if (i < _starCount) {
            img.image = self.imgSelected;
        } else {
            img.image = self.imgUnSelected;
        }
        [self addSubview:img];
        [img release];
        x += w;
    }
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
    if (_lineWidth > 0.0) {
        CGContextSetLineWidth(context, _lineWidth);
        CGContextSetStrokeColorWithColor(context, _borderColor.CGColor);
        CGContextStrokePath(context);
    }
    CGPathRelease(path);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    return img;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    CGFloat w = self.bounds.size.width / _maxStar;
    NSInteger count = pt.x / w + 1;
    if (count < 0) {
        count = 0;
    }
    if (count > _maxStar) {
        count = _maxStar;
    }
    self.starCount = count;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint pt = [[touches anyObject] locationInView:self];
    CGFloat w = self.bounds.size.width / _maxStar;
    NSInteger count = pt.x / w + 1;
    if (count < 0) {
        count = 0;
    }
    if (count > _maxStar) {
        count = _maxStar;
    }
    self.starCount = count;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}*/

@end
