//
//  ViewController.m
//  PAGradientSample
//
//  Created by Louka Desroziers on 17/10/12.
//  Copyright (c) 2012 Louka Desroziers. All rights reserved.
//

#import "ViewController.h"

@implementation PAGradientGeometryView
@synthesize bezierPath = _bezierPath;
@synthesize gradient = _gradient;
@synthesize angle = _angle;

- (void)setBezierPath:(UIBezierPath *)bezierPath
{
    if(_bezierPath != bezierPath)
    {
        [self willChangeValueForKey:@"bezierPath"];
        [_bezierPath release];
        _bezierPath = [bezierPath retain];
        
        [self setNeedsDisplay];
        [self didChangeValueForKey:@"bezierPath"];
    }
}

- (void)setGradient:(PAGradientColor *)gradient
{
    if(_gradient != gradient)
    {
        [self willChangeValueForKey:@"gradient"];
        [_gradient release];
        _gradient = [gradient retain];
        
        [self setNeedsDisplay];
        [self didChangeValueForKey:@"gradient"];
    }
}

- (void)setAngle:(CGFloat)angle
{
    if(_angle != angle)
    {
        [self willChangeValueForKey:@"angle"];
        _angle = angle;
        [self setNeedsDisplay];
        [self didChangeValueForKey:@"angle"];
    }
}

- (void)drawRect:(CGRect)rect
{
    if([self gradient] != nil)
    {            
        [[self gradient] drawInBezierPath:([self bezierPath] == nil ? [UIBezierPath bezierPathWithRect:rect] : [self bezierPath])
                                    angle:[self angle]];
    }
    else
    {
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, [[UIColor blackColor] CGColor]);
        
        CGContextAddPath(ctx, [([self bezierPath] == nil ? [UIBezierPath bezierPathWithRect:rect] : [self bezierPath]) CGPath]);
        CGContextFillPath(ctx);
        
        CGContextRestoreGState(ctx);
        
    }
}


- (void)dealloc
{
    [_gradient release];
    [_bezierPath release];
    [super dealloc];
}

@end

@interface ViewController ()
@property (nonatomic, retain) IBOutlet UISlider *angleSlider;
@property (nonatomic, retain) IBOutlet PAGradientGeometryView *rectangleView, *ovalView, *triangleView;
@end

@implementation ViewController
@synthesize ovalView = _ovalView, rectangleView = _rectangleView, triangleView = _triangleView;
@synthesize angleSlider = _angleSlider;

- (UIBezierPath *)__triangleBezierPathForFrame:(CGRect)frame
{
    UIBezierPath *trianglePath = [UIBezierPath bezierPath];
    
    [trianglePath moveToPoint:CGPointMake(CGRectGetMinX(frame), CGRectGetMinY(frame))];
    [trianglePath addLineToPoint:CGPointMake(CGRectGetMidX(frame), CGRectGetMaxY(frame))];
    [trianglePath addLineToPoint:CGPointMake(CGRectGetMaxX(frame), CGRectGetMinY(frame))];
    [trianglePath closePath];
    
    return trianglePath;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[self angleSlider] addTarget:self
                           action:@selector(angleValueChanged:)
                 forControlEvents:UIControlEventValueChanged];
    
        
    [[self ovalView] setGradient:[PAGradientColor gradientWithColors:[NSArray arrayWithObjects:[UIColor redColor],
                                                                      [UIColor greenColor],
                                                                      [UIColor blackColor],
                                                                      [UIColor blueColor],
                                                                      [UIColor yellowColor],
                                                                      nil]]];
    [[self ovalView] setBezierPath:[UIBezierPath bezierPathWithOvalInRect:[[self ovalView] bounds]]];
    
    
    [[self rectangleView] setGradient:[PAGradientColor gradientWithColors:[NSArray arrayWithObjects:[UIColor redColor],
                                                                      [UIColor greenColor],
                                                                      [UIColor blackColor],
                                                                      [UIColor blueColor],
                                                                      [UIColor yellowColor],
                                                                      nil]]];
    [[self rectangleView] setBezierPath:nil];
    
    
    [[self triangleView] setGradient:[PAGradientColor gradientWithColors:[NSArray arrayWithObjects:[UIColor redColor],
                                                                      [UIColor greenColor],
                                                                      [UIColor blackColor],
                                                                      [UIColor blueColor],
                                                                      [UIColor yellowColor],
                                                                      nil]]];
    [[self triangleView] setBezierPath:[self __triangleBezierPathForFrame:[[self triangleView] bounds]]];

}


- (void)angleValueChanged:(UISlider *)sender
{
    [[self ovalView] setAngle:[sender value]];
    [[self rectangleView] setAngle:[sender value]];
    [[self triangleView] setAngle:[sender value]];

}


#pragma mark -
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    [_angleSlider release], _angleSlider = nil;
    [_ovalView release], _ovalView = nil;
    [_rectangleView release], _rectangleView = nil;
    [_triangleView release], _triangleView = nil;
}

- (void)dealloc
{
    [_angleSlider release];
    [_ovalView release];
    [_rectangleView release];
    [_triangleView release];
    [super dealloc];
}

@end
