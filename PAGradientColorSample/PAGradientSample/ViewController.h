//
//  ViewController.h
//  PAGradientSample
//
//  Created by Louka Desroziers on 17/10/12.
//  Copyright (c) 2012 Louka Desroziers. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PAGradientColor.h"

@interface PAGradientGeometryView : UIView
@property (nonatomic, assign) CGFloat           angle;
@property (nonatomic, assign) PAGradientColor   *gradient;
@property (nonatomic, retain) UIBezierPath      *bezierPath;
@end

@interface ViewController : UIViewController
@end
