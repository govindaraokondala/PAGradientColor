//
//  PAColorSpace.m
//  PAGradientSample
//
//  Created by Louka Desroziers on 17/10/12.
//  Copyright (c) 2012 Louka Desroziers. All rights reserved.
//

#import "PAColorSpace.h"

@implementation PAColorSpace
{
    CGColorSpaceRef _colorSpaceRef;
}

+ (id)deviceRGBColorSpace
{
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    PAColorSpace *colorSpace = [[[self class] alloc] initWithCGColorSpace:colorSpaceRef];
    
    CGColorSpaceRelease(colorSpaceRef);
   
    return [colorSpace autorelease];
}


+ (id)deviceCMYKColorSpace
{
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceCMYK();
    PAColorSpace *colorSpace = [[[self class] alloc] initWithCGColorSpace:colorSpaceRef];
    
    CGColorSpaceRelease(colorSpaceRef);
    
    return [colorSpace autorelease];
}

+ (id)deviceGrayColorSpace
{
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    PAColorSpace *colorSpace = [[[self class] alloc] initWithCGColorSpace:colorSpaceRef];
    
    CGColorSpaceRelease(colorSpaceRef);
    
    return [colorSpace autorelease];
}


- (id)initWithCGColorSpace:(CGColorSpaceRef)colorSpaceRef
{
    self = [super init];
    if(self)
    {
        _colorSpaceRef = CGColorSpaceRetain(colorSpaceRef);
    }
    
    return self;
}

#pragma mark - Color Space Informations

- (CGColorSpaceRef)CGColorSpace
{
    return _colorSpaceRef;
}

- (NSInteger)numberOfComponents
{
    return (NSInteger)CGColorSpaceGetNumberOfComponents([self CGColorSpace]);
}


#pragma mark - Dealloc

- (void)dealloc
{
    CGColorSpaceRelease(_colorSpaceRef);
    [super dealloc];
}

@end
