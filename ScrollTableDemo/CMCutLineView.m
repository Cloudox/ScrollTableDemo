//
//  CMCutLineView.m
//  canmou_c
//
//  Created by JiFeng on 15/10/17.
//  Copyright © 2015年 Canmou. All rights reserved.
//

#import "CMCutLineView.h"

@interface CMCutLineView ()
@property (nonatomic, strong) UIColor *lineColor;
@property (nonatomic) BOOL isDashLine;
@property (nonatomic) CGFloat alpha;
@property (nonatomic) CGFloat lineWidth;
@end

@implementation CMCutLineView

- (instancetype)initWithFrame:(CGRect)frame lineColor:(UIColor *)lineColor alpha:(CGFloat)alpha isDashLine:(BOOL)isDashLine lineWidth:(CGFloat)lineWidth
{
    self = [super initWithFrame:frame];
    if (self) {
        self.isDashLine = isDashLine;
        self.alpha = alpha;
        self.lineColor = lineColor;
        self.lineWidth = lineWidth;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)setLineColor:(UIColor *)lineColor
{
    _lineColor = lineColor;
}

- (void)drawRect:(CGRect)rect
{
    BOOL isVertical;
    if (rect.size.width > rect.size.height) {
        isVertical = NO;
    }else {
        isVertical = YES;
    }
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
    CGContextSetLineWidth(context, self.lineWidth);
    CGContextMoveToPoint(context, 0.5 ,0.5);
    CGContextSetAlpha(context, self.alpha);
    if (self.isDashLine) {
        CGFloat dashLengths[] = {1, 1};
        CGContextSetLineDash(context, 0.0, dashLengths, 2);
        
    }
    if (isVertical) {
        CGContextAddLineToPoint(context,self.frame.size.width/2.0, self.frame.size.height);
    }else {
        CGContextAddLineToPoint(context,self.frame.size.width, self.frame.size.height/2.0);
    }
    CGContextStrokePath(context);
}

@end
