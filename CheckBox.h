//
//  CheckBox.h
//  ProjectDemo
//
//  Created by 方远 on 2017/2/23.
//  Copyright © 2017年 方远. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CheckBox : UIButton

- (void)initNormal:(UIImage *)image selectedImage:(UIImage *)simage;

@end

@interface Image : UIView

- (UIImage *)saveImage:(int)type;

@end
