//
//  MKOverlayRendererView.m
//  MapOfEurope
//
//  Created by Виктор Мишустин on 10.10.16.
//  Copyright © 2016 Виктор Мишустин. All rights reserved.
//

#import "MKOverlayRendererView.h"
#import "HexColors.h"

@implementation MKOverlayRendererView

- (instancetype)initWithPolygonView:(id <MKOverlay>)overlay
{
    self = [super init];
    if (self) {
        self.overlayAlpha = 1.;
        self.overlayColor = [UIColor hx_colorWithHexRGBAString:@"B0E0E6"];
    }
    return self;
}



- (BOOL)canDrawMapRect:(MKMapRect)mapRect
             zoomScale:(MKZoomScale)zoomScale {
    return true;
}

- (void)drawMapRect:(MKMapRect)mapRect
          zoomScale:(MKZoomScale)zoomScale
          inContext:(CGContextRef)ctx {
    CGContextSetAlpha(ctx, self.overlayAlpha);
    CGContextSetFillColorWithColor(ctx, self.overlayColor.CGColor);
    CGContextFillRect(ctx, [self rectForMapRect:MKMapRectWorld]);
}


@end
