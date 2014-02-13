//
//  CaculateViewController.m
//  0x0026
//
//  Created by Xummer on 13-10-12.
//  Copyright (c) 2013年 Xummer. All rights reserved.
//

#import "CaculateViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface CaculateViewController ()
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet UIButton *actionButton;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *inputSegment;
@property (weak, nonatomic) IBOutlet UIImageView *centerImage;

@end

@implementation CaculateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [[self class] dwMakeCircleOnView:_centerImage];
    _centerImage.image = [UIImage imageNamed:@"H4ck_Suit"];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAction:(id)sender {
    [_inputTextField resignFirstResponder];
    if (_inputTextField.text.length > 0) {
        
        NSUInteger radix = 0;
        switch (_inputSegment.selectedSegmentIndex) {
            case 0:
                radix = 10;
                break;
            case 1:
                radix = 16;
                break;
            default:
                break;
        }
        
        
        unsigned long resInt = strtoul([_inputTextField.text UTF8String],0,radix);
        printf("%lu", sizeof(resInt));
        [self caculate0x:resInt];
    }
}

- (void)caculate0x:(unsigned long)aInt {
    
    NSString *rStr =
     [NSString stringWithFormat:@"hex    %lx\ndec    %lu\nascii %@", aInt, aInt, [[self class] longIntToASCII:aInt]];
    [_resultLabel setText:rStr];
}

+ (NSString *)longIntToASCII:(unsigned long)aInt {
    NSString *tStr = [NSString stringWithFormat:@"%lu", aInt];
    NSString *rStr = @"";
    
    while (tStr.length >= 2) {
        NSString *newStr = [tStr substringToIndex:2];
        tStr = [tStr substringFromIndex:2];
        
        rStr = [rStr stringByAppendingString:[NSString stringWithFormat:@"%c", [newStr integerValue]]];
    }
    
    if (tStr.length == 1) {
        rStr = [rStr stringByAppendingFormat:@".[%@]",tStr];
    }
    
    return rStr;
}

+ (void)dwMakeCircleOnView:(UIView *)tView {
    CGSize size = tView.bounds.size;
    
    CGFloat radius = size.width * .5f;
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, size.width, radius);
    CGPathAddArc(path, NULL, size.width-radius, size.height-radius, radius, 0.0, M_PI*2, YES);
    CGPathCloseSubpath(path);
    [shapeLayer setPath:path];
    CFRelease(path);
    
    tView.layer.mask = shapeLayer;
}

@end
