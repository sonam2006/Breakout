//
//  ViewController.h
//  Breakout
//
//  Created by Sonam Mehta on 1/16/14.
//  Copyright (c) 2014 Sonam Mehta. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UICollisionBehaviorDelegate>



-(IBAction)dragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer;

@end
