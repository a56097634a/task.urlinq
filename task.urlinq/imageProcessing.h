//
//  imageProcessing.h
//  task.urlinq
//
//  Created by Tianming Xu on 9/23/14.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import <math.h>
@interface imageProcessing : NSObject
-(UIImage*) imageRepresentationWithSize:(CGSize)size;
@property (strong, nonatomic) NSObject* object;
@end
