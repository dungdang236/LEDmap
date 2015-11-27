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
    int _numberOfBallInARow;
    int _numberOfBallInACollum;
    CGFloat _space;
    CGFloat _ballDiameter;
    BOOL check;
    NSTimer* _timer;
    int lastonLEDc;
    int lastonLEDr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    _WMargin= 60;
    _HMargin =200;
    _ballDiameter=24;
    _numberOfBallInARow=10;
    _numberOfBallInACollum=14;
    lastonLEDc =-1;
    lastonLEDr =-1;
    //[self placeBallAtX:200 andY:200 withTag:1];
    [self checkSizeOfApp];
    [self numberOfBallvsSpace];
    
    
    
    
    
}
- (void) runningLED{
    if(lastonLEDc!=-1||lastonLEDr!=-1){
        [self turnOffLED:lastonLEDc];
        [self turnOffLED:lastonLEDr];
    }
    if (lastonLEDr!= _numberOfBallInARow-1||lastonLEDc!= _numberOfBallInACollum-1) {
        lastonLEDc++;
        lastonLEDr++;
    } else{
        lastonLEDc=0;
        lastonLEDr=0;
    }
    [self turnOnLED:lastonLEDc andColor:check];
    [self turnOnLED:lastonLEDr andColor:check];
}
- (void) turnOnLED: (int) index andColor: (bool) color{
    UIView* view =[self.view viewWithTag:index +100];
    if(view && [view isMemberOfClass:[UIImageView class]]){
        UIImageView* ball = (UIImageView*) view;
        ball.image =[UIImage imageNamed:@"green"];
    }
                   
}

- (void) turnOffLED: (int) index{
    UIView* view =[self.view viewWithTag:index +100];
    if(view && [view isMemberOfClass:[UIImageView class]]){
        UIImageView* ball = (UIImageView*) view;
        ball.image =[UIImage imageNamed:@"blue"];
    }
    
}
- (IBAction)turnOnOff:(id)sender {
    NSLog(@"Hello");
    //UIImageView* ball=[[UIImageView alloc] initWithImage:[UIImage imageNamed: @"blue"]];
    check = !check;
        [self drawWightBall:_numberOfBallInACollum and:_numberOfBallInARow ballkind:check];
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(runningLED) userInfo:nil repeats:true];
    
    
    
    
    //if ([ball.image isEqual:[UIImage imageNamed:@"blue"]])
    //{ball.image = [UIImage imageNamed:@"green"] ;}
    //else{ball.image = [UIImage imageNamed:@"blue"];}
}
- (void) drawWightBall: (int) numberOfBallInARow
                   and: (int) numberOfBallInACollum
              ballkind: (bool)n{
    CGFloat wspace = [self widthspaceBetweenBallCenterWhenNumberOfBallIsKnown:numberOfBallInARow];
    CGFloat hspace = [self heightSpaceBetweenBallCenterWhenNumberOFBallIsKnown:numberOfBallInACollum];
    for (int i=0; i<numberOfBallInACollum; i++) {
        for (int j=0; j<numberOfBallInARow; j++) {
            
        
            [self placeBallAtX:_WMargin + i*wspace
                          andY:_HMargin +j*hspace
                       withTag: i+j*numberOfBallInACollum+100
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
