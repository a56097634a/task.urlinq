//
//  ViewController.m
//  task.urlinq
//
//  Created by Tianming Xu on 9/23/14.
//
//

#import "ViewController.h"
@interface ViewController ()

@end

@implementation ViewController
@synthesize imageView, arrayLength, imp, label, image, imageRepresentationSize;
- (void)viewDidLoad {
    [super viewDidLoad];
    // adding interface
    
    arrayLength = [[UITextField alloc] initWithFrame:CGRectMake(90, 100, 200, 40)];
    arrayLength.borderStyle = UITextBorderStyleRoundedRect;
    arrayLength.textAlignment = NSTextAlignmentCenter;
    [arrayLength setDelegate:self];
    
    label = [[UILabel alloc] initWithFrame:CGRectMake(90, 60, 200, 30)];
    label.text = @"Input the length of array";
    label.textAlignment = NSTextAlignmentCenter;
    CGRect r = CGRectMake(10, 200, 355, 71);
    //get the CGSize we need to format the image
    imageRepresentationSize.height = r.size.height;
    imageRepresentationSize.width = r.size.width/5;
    imageView = [[UIImageView alloc] initWithFrame:r];
    
    [self.view addSubview:arrayLength];
    [self.view addSubview:label];
    [self.view addSubview:imageView];

}
    //action triggered by return button on the keyboard
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *string = [arrayLength text];
    //get input, only integer matters
    NSInteger i = [string integerValue];
    //set the input array
    NSMutableArray *array = [self createInputArrayWithLength:i];
//    NSLog(@"%@", array);
    //set image for imageview
    [imageView setImage:[self compositeImageWithArray:array]];
    [textField resignFirstResponder];
    
    return YES;
    
}
-(UIImage*) compositeImageWithArray:(NSMutableArray*) array{
    UIImage *tempImage;
    UIImage *compositeImage;
    imp = [[imageProcessing alloc] init];
    //composite the Image
    CGSize compositeSize = CGSizeMake(imageRepresentationSize.width * (CGFloat)5, imageRepresentationSize.height);
    UIGraphicsBeginImageContext(compositeSize);
    //put on some effect with mask on the imageView
    //maybe not the best choice, but easy to implement
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = imageView.bounds;
    gradient.locations = [NSArray arrayWithObjects:(id)[NSNumber numberWithDouble:0.65],(id)[NSNumber numberWithDouble:1], nil];
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor clearColor] CGColor],(id)[[UIColor whiteColor] CGColor], nil];
    gradient.startPoint = CGPointMake(0.2, 0);
    gradient.endPoint = CGPointMake(0, 0);
    //check is the array is nil
    if (array == nil) {
        //create backimage that fill the blank and handle the null array
        tempImage = [self createBackImageWithSize:imageRepresentationSize];
        CGFloat startX = compositeSize.width/2 - tempImage.size.width/2;
        CGFloat startY = 0.0;
        [tempImage drawInRect:CGRectMake(startX, startY, tempImage.size.width, tempImage.size.height)];
    }
    else{
        //render image representations into a image
        for (int i = 0; i < array.count; i++) {
            tempImage = [imp imageRepresentationWithSize:imageRepresentationSize];
            //spacing, get the space by several adjustments
            CGFloat space = tempImage.size.width/(array.count * 4);
//            NSLog(@"spacs:%f", space);
            CGFloat startX = compositeSize.width - (space + tempImage.size.width)*(i+1);
            CGFloat startY = 0.0;
            //Here is no-spacing stradegy:
            //CGFloat startX = compositeSize.width - tempImage.size.width*(i+1);
            [tempImage drawInRect:CGRectMake(startX, startY, tempImage.size.width, tempImage.size.height)];
        }
    }
    if (array.count == 5) {
        [imageView.layer insertSublayer:gradient atIndex:0];
    }
    else {
        imageView.layer.sublayers = nil;
    }

    compositeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return compositeImage;
}
-(NSMutableArray*) createInputArrayWithLength:(NSInteger) i{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    //consider 0 and other character as 0 that make array length 0
    if (i < 1) {
        array = nil;
        return array;
    }
    //consider int that larger than 5 as 5
    else if (i > 5) {
        i = 5;
    }
    for (NSInteger j = 1; j <= i; j++) {
        [array addObject:[NSNumber numberWithInteger:j]];
    }
    return array;
}
//create backimage similiar to image representations
-(UIImage*) createBackImageWithSize:(CGSize) size{
    UIImage* padding;
    UIImage* originalImage = [[UIImage imageNamed:@"no.png"] init];
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(size.width, size.height), NO, 0.0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGFloat imageWidth = originalImage.size.width;
    CGFloat imageHeight = originalImage.size.height;
    CGFloat rectWidth = size.width;
    CGFloat rectHeight = size.height;
    CGFloat scaleFactorX = rectWidth/imageWidth;
    CGFloat scaleFactorY = rectHeight/imageHeight;
    CGContextScaleCTM (context, scaleFactorX, scaleFactorY);
    CGRect rect = CGRectMake(0, 0, imageWidth, imageHeight);
    [originalImage drawInRect:rect];
    padding = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return padding;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
