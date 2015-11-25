//
//  ViewController.m
//  LEDmap
//
//  Created by student on 25/11/2015.
//  Copyright © 2015 dungdang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *turnOnOffButton;

@end

@implementation ViewController
{
    CGFloat _WMargin;
    CGFloat _HMargin;
    int _numberOfBall;
    CGFloat _space;
    CGFloat _ballDiameter;
    BOOL check;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _WMargin= 40;
    _HMargin =200;
    _ballDiameter=24;
    //[self placeBallAtX:200 andY:200 withTag:1];
    [self checkSizeOfApp];
    [self numberOfBallvsSpace];
    
    
    
}
- (IBAction)turnOnOff:(id)sender {
    NSLog(@"Hello");
    //UIImageView* ball=[[UIImageView alloc] initWithImage:[UIImage imageNamed: @"blue"]];
    check = !check;
        [self drawWightBall:10 and:14 ballkind:check];
    
  
    
    
    
    
    //if ([ball.image isEqual:[UIImage imageNamed:@"blue"]])
    //{ball.image = [UIImage imageNamed:@"green"] ;}
    //else{ball.image = [UIImage imageNamed:@"blue"];}
}
- (void) drawWightBall: (int) numberOfBallInARow
                   and: (int) numberOfBallInACollum
              ballkind: (bool)n{
    CGFloat wspace = [self widthspaceBetweenBallCenterWhenNumberOfBallIsKnown:numberOfBallInARow];
    CGFloat hspace = [self heightSpaceBetweenBallCenterWhenNumberOFBallIsKnown:numberOfBallInACollum];
    for (int i=0; i<numberOfBallInARow; i++) {
        for (int j=0; j<numberOfBallInACollum; j++) {
            
        
            [self placeBallAtX:_WMargin + i*wspace
                          andY:_HMargin +j*hspace
                       withTag:i+j+100
                        ballkind:n];
            
        }
        
    }
    
}
- (void) placeBallAtX: (CGFloat)x
                 andY:(CGFloat)y
              withTag: (int)tag
             ballkind: (BOOL)n
{
    if (n) {
        
    UIImageView* ball=[[UIImageView alloc] initWithImage:[UIImage imageNamed: @"green"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
        [self.view addSubview: ball];}
else {
    UIImageView* ball=[[UIImageView alloc] initWithImage:[UIImage imageNamed: @"blue"]];
    ball.center = CGPointMake(x, y);
    ball.tag = tag;
    [self.view addSubview: ball];}}

    
    
    - (void) checkSizeOfApp {
    CGSize size = self.view.bounds.size;
    NSLog(@"width: %3.0f,height: %3.0f",size.width, size.height);}


- (CGFloat) widthspaceBetweenBallCenterWhenNumberOfBallIsKnown: (int) n{
    return (self.view.bounds.size.width- 2*_WMargin)/(n-1);}
-  (CGFloat) heightSpaceBetweenBallCenterWhenNumberOFBallIsKnown: (int)n{
        return (self.view.bounds.size.height- 2*_HMargin)/(n-1);}


- (void) numberOfBallvsSpace
{
    BOOL stop =false;
    int c=3;
    int r=6;
    while (!stop) {
        CGFloat wspace = [self widthspaceBetweenBallCenterWhenNumberOfBallIsKnown:c];
        CGFloat hspace =[self heightSpaceBetweenBallCenterWhenNumberOFBallIsKnown:r];
        if (wspace< _ballDiameter && hspace<_ballDiameter) {
            stop= true;
        }
        else{
            NSLog(@"Number of balls: %d, width space between ball center: %3.0f,height space:%3.0f",c,wspace,hspace);
            c++;
            r++;
        }
    };
    
}

@end
