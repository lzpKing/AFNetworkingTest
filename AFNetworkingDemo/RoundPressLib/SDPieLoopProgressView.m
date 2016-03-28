//
//  SDPieLoopProgressView.m
//  SDProgressView
//
//  Created by aier on 15-2-20.
//  Copyright (c) 2015年 GSD. All rights reserved.
//

#import "SDPieLoopProgressView.h"

@implementation SDPieLoopProgressView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGFloat xCenter = rect.size.width * 0.5;
    CGFloat yCenter = rect.size.height * 0.5;
    CGFloat radius = MIN(rect.size.width * 0.5, rect.size.height * 0.5) - SDProgressViewItemMargin * 0.2;
    
    // 进度环边框
    [[UIColor clearColor] set];
    CGFloat w = radius * 2 + 1;
    CGFloat h = w;
    CGFloat x = (rect.size.width - w) * 0.5;
    CGFloat y = (rect.size.height - h) * 0.5;
    CGContextAddEllipseInRect(ctx, CGRectMake(x, y, w, h));
    CGContextStrokePath(ctx);
    
    // 进度环
    if ([_delegate isEqualToString:@"0"]) {
        [SDProgressViewBackgroundColor set];
    }
    if ([_delegate isEqualToString: @"1"]) {
        [SDProgressViewBackgroundColor set];
    }
    if ([_delegate isEqualToString:@"2"]) {
        [SDProgressViewBackgroundColor set];
    }
    if ([_delegate isEqualToString:@"3"]) {
        [SDColorMaker(192, 192, 192, 0.5) set];
    }
    if ([_delegate isEqualToString:@"4"]) {
        [SDColorMaker(192, 192, 192, 0.5) set];
    }
    if ([_delegate isEqualToString:@"5"]) {
        [SDColorMaker(192, 192, 192, 0.5) set];
    }

    CGContextMoveToPoint(ctx, xCenter, yCenter);
    CGContextAddLineToPoint(ctx, xCenter, 0);
    CGFloat to = - M_PI * 0.5 + self.progress * M_PI * 2 + 0.001; // 初始值
    CGContextAddArc(ctx, xCenter, yCenter, radius, - M_PI * 0.5, to, 0);
    CGContextClosePath(ctx);
    CGContextFillPath(ctx);
    
    // 遮罩
    if ([_delegate isEqualToString:@"0"]) {
        [SDColorMaker(250, 111, 53, 1) set];
    }
    if ([_delegate isEqualToString: @"1"]) {
        [SDColorMaker(30, 156, 215, 1) set];
    }
    if ([_delegate isEqualToString:@"2"]) {
        [SDColorMaker(75, 198, 255, 1) set];
    }
    if ([_delegate isEqualToString:@"3"]) {
        [SDColorMaker(192, 192, 192, 1) set];
    }
    if ([_delegate isEqualToString:@"4"]) {
        [SDColorMaker(192, 192, 192, 1) set];
    }
    if ([_delegate isEqualToString:@"5"]) {
        [SDColorMaker(192, 192, 192, 1) set];
    }
    CGFloat maskW = (radius - 5) * 2;
    CGFloat maskH = maskW;
    CGFloat maskX = (rect.size.width - maskW) * 0.5;
    CGFloat maskY = (rect.size.height - maskH) * 0.5;
    CGContextAddEllipseInRect(ctx, CGRectMake(maskX, maskY, maskW, maskH));
    CGContextFillPath(ctx);
    
//    // 遮罩边框
//    [SDColorMaker(250, 111, 222, 1) set];
//    CGFloat borderW = maskW + 1;
//    CGFloat borderH = borderW;
//    CGFloat borderX = (rect.size.width - borderW) * 0.5;
//    CGFloat borderY = (rect.size.height - borderH) * 0.5;
//    CGContextAddEllipseInRect(ctx, CGRectMake(borderX, borderY, borderW, borderH));
//    CGContextStrokePath(ctx);
    
    
    
    // 进度数字
    NSMutableDictionary *attributes = [NSMutableDictionary dictionary];
    attributes[NSFontAttributeName] = [UIFont boldSystemFontOfSize:20 * SDProgressViewFontScale];
    attributes[NSForegroundColorAttributeName] = [UIColor whiteColor];
    if ([_delegate isEqualToString:@"0"]) {
        [self setCenterProgressText:@"待开放" withAttributes:attributes];
    }
    if ([_delegate isEqualToString: @"1"]) {
        [self setCenterProgressText:@"投标" withAttributes:attributes];
    }
    if ([_delegate isEqualToString:@"2"]) {
        [self setCenterProgressText:@"满标" withAttributes:attributes];
    }
    if ([_delegate isEqualToString:@"3"]) {
        [self setCenterProgressText:@"流标" withAttributes:attributes];
    }
    if ([_delegate isEqualToString:@"4"]) {
        [self setCenterProgressText:@"还款中" withAttributes:attributes];
    }
    if ([_delegate isEqualToString:@"5"]) {
        [self setCenterProgressText:@"结束" withAttributes:attributes];
    }
}

@end
