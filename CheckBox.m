//
//  CheckBox.m
//  ProjectDemo
//
//  Created by 方远 on 2017/2/23.
//  Copyright © 2017年 方远. All rights reserved.
//

#import "CheckBox.h"

@implementation CheckBox

- (void)drawRect:(CGRect)rect {
    // Drawing code
}

- (id)init {
    self = [super init];
    if (self) {
        self.selected = false;
//        [self setButtonImage];
        [self addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
    
}

-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.selected = false;
//        [self setButtonImage];
        [self addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
    
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        self.selected = false;
//        [self setButtonImage];
        [self addTarget:self action:@selector(onClicked:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

- (void)initNormal:(UIImage *)image selectedImage:(UIImage *)simage {
    [self setImage:simage forState:UIControlStateSelected];
    [self setImage:image forState:UIControlStateNormal];
}

- (void)setButtonImage {
    Image *image = [[Image alloc] init];
    [self setImage:[image saveImage:1] forState:UIControlStateSelected];
    [self setImage:[image saveImage:0] forState:UIControlStateNormal];
}

-(void)onClicked:(id)sender{
    self.selected = !self.selected;
}

@end

@implementation Image

- (instancetype)init {
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.frame = CGRectMake(0, 0, 30, 30);
    }
    return self;
}

- (void)circleAndLineWithColor:(CGColorRef)iColor {
    UIBezierPath *_path = [UIBezierPath bezierPath];
    [_path moveToPoint:CGPointMake(5, 15)];
    [_path addLineToPoint:CGPointMake(13, 24)];
    [_path addLineToPoint:CGPointMake(28, 3)];
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = _path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;//填充颜色
    shapeLayer.strokeColor = iColor;//边框颜色
    shapeLayer.lineWidth = 1 / [UIScreen mainScreen].scale;
    shapeLayer.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:shapeLayer];
    
    CAShapeLayer *signalcircle = [CAShapeLayer layer];
    signalcircle.path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(15.0, 15.0, 20.0, 20.0) cornerRadius:10.0].CGPath;
    signalcircle.position = CGPointMake(- 10.0, - 10.0);
    signalcircle.fillColor = [UIColor clearColor].CGColor;
    signalcircle.strokeColor = iColor;
    signalcircle.lineWidth = 1 / [UIScreen mainScreen].scale;
    signalcircle.backgroundColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:signalcircle];
}

- (UIImage *)saveImage:(int)type {
    [self circleAndLineWithColor:((type == 0) ? [UIColor grayColor] : [UIColor greenColor]).CGColor];
    
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.opaque, [UIScreen mainScreen].scale);
    if ([self respondsToSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)]) {
        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:
                                    [self methodSignatureForSelector:
                                     @selector(drawViewHierarchyInRect:afterScreenUpdates:)]];
        [invocation setTarget:self];
        [invocation setSelector:@selector(drawViewHierarchyInRect:afterScreenUpdates:)];
        CGRect arg2 = self.bounds;
        BOOL arg3 = YES;
        [invocation setArgument:&arg2 atIndex:2];
        [invocation setArgument:&arg3 atIndex:3];
        [invocation invoke];
    } else { // IOS7之前的版本
        [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    }
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

@end
