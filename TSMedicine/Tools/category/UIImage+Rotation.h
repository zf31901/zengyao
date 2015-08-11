//
//  UIImage+Rotation.h
//  Ituji
//
//  Created by 曹 君平 on 8/30/12.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Rotation)

- (UIImage *)rotate;
- (UIImage *)rotateByInterfaceOrientation:(UIInterfaceOrientation)orientation;

@end
