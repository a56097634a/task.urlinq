//
//  imageProcessing.m
//  task.urlinq
//
//  Created by Tianming Xu on 9/23/14.
//
//

#import "imageProcessing.h"

@implementation imageProcessing
-(UIImage*) imageRepresentationWithSize:(CGSize)size{
    //choose the image representation randomly
    NSInteger number = (arc4random()%4)+1;
    NSString *path = [[NSString alloc] initWithFormat:@"test_%ld", (long)number];
    UIImage * originalImage = [UIImage imageNamed:path];
    //check if the image is valid
    if (originalImage == nil) {
        NSLog(@"original image is nil");
        originalImage = [UIImage imageNamed:@"no.png"];
    }
    //set up image context
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    //get and then calculate essential parameters
    CGFloat imageWidth = originalImage.size.width;
    CGFloat imageHeight = originalImage.size.height;
    CGFloat rectWidth = size.width;
    CGFloat rectHeight = size.height;
    CGFloat scaleFactorX = rectWidth/imageWidth;
    CGFloat scaleFactorY = rectHeight/imageHeight;
    CGFloat imageCentreX = rectWidth/2;
    CGFloat imageCentreY = rectHeight/2;
    //draw the circle PATH to clip the image
    CGFloat radius = rectWidth/2;
    CGContextBeginPath (context);
    CGContextAddArc (context, imageCentreX, imageCentreY, radius, 0, 2*M_PI, 0);
    CGContextClosePath (context);
    CGContextClip (context);
    //set scale factor
    CGContextScaleCTM (context, scaleFactorX, scaleFactorY);
    //draw image and return it
    CGRect rect = CGRectMake(0, 0, imageWidth, imageHeight);
    [originalImage drawInRect:rect];
    UIImage *croppedresult = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return croppedresult;
}
@end
