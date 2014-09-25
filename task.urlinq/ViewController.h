//
//  ViewController.h
//  task.urlinq
//
//  Created by Tianming Xu on 9/23/14.
//
//

#import <UIKit/UIKit.h>
#import "imageProcessing.h"

@interface ViewController : UIViewController <UITextFieldDelegate>
@property CGSize imageRepresentationSize;
@property (strong, nonatomic) imageProcessing* imp;
@property (strong, nonatomic) UITextField* arrayLength;
@property (strong, nonatomic) UIImageView* imageView;
@property (strong, nonatomic) UILabel* label;
@property (strong, nonatomic) UIImage* image;
@end

