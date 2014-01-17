//
//  ViewController.m
//  Breakout
//
//  Created by Sonam Mehta on 1/16/14.
//  Copyright (c) 2014 Sonam Mehta. All rights reserved.
//

#import "ViewController.h"
#import "PaddleView.h"
#import "BallView.h"
#import "BlockView.h"

@interface ViewController () <UICollisionBehaviorDelegate>
{
  
    IBOutlet PaddleView *paddleView;
    IBOutlet BallView *ballView;
    UIDynamicAnimator *dynamicAnimator;
    UIPushBehavior *pushBehavior;
    UICollisionBehavior *collisionBehavior;
    UIDynamicItemBehavior *paddleDynamicBehavior;
    UIDynamicItemBehavior *ballDynamicBehavior;
    __weak IBOutlet BlockView *blockView;
    
}




@end

@implementation ViewController

-(IBAction)dragPaddle:(UIPanGestureRecognizer *)panGestureRecognizer
{
    paddleView.center = CGPointMake([panGestureRecognizer locationInView:self.view].x, paddleView.center.y);
    [dynamicAnimator updateItemUsingCurrentState:paddleView];

    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dynamicAnimator = [[UIDynamicAnimator alloc] initWithReferenceView:self.view];
    pushBehavior = [[UIPushBehavior alloc] initWithItems:@[ballView] mode:UIPushBehaviorModeInstantaneous];
    pushBehavior.pushDirection = CGVectorMake(0.5, 1.0);
    pushBehavior.active = YES;
    pushBehavior.magnitude = 0.2;
    
    [dynamicAnimator addBehavior:pushBehavior];
    
    collisionBehavior = [[UICollisionBehavior alloc] initWithItems:@[ballView, paddleView, blockView]];
    collisionBehavior.collisionDelegate = self;
    collisionBehavior.collisionMode = UICollisionBehaviorModeEverything;
    collisionBehavior.translatesReferenceBoundsIntoBoundary = YES;
    
    [dynamicAnimator addBehavior:collisionBehavior];
    
    
    paddleDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[paddleView]];
    paddleDynamicBehavior.allowsRotation = NO;
    paddleDynamicBehavior.density = 10000;
    
    [dynamicAnimator addBehavior:paddleDynamicBehavior];
    
    ballDynamicBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[ballView]];
    ballDynamicBehavior.allowsRotation = NO;
    ballDynamicBehavior.elasticity = 1;
    ballDynamicBehavior.friction = 0.0;
    ballDynamicBehavior.resistance = 0.0;
    
    [dynamicAnimator addBehavior:ballDynamicBehavior];
    
    

    
}

#pragma mark UICollisionBehaviorDelegate

-(void)collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item withBoundaryIdentifier:(id<NSCopying>)identifier atPoint:(CGPoint)p
{
    [UIView animateWithDuration:2.5 animations:^{ballView.backgroundColor = [UIColor magentaColor];}];
    [UIView animateWithDuration:2.5 animations:^{paddleView.backgroundColor = [UIColor redColor];}];
    
    if (ballView.center.y >= 550) {
        ballView.center = CGPointMake (150, 273);
    }
    [dynamicAnimator updateItemUsingCurrentState:ballView];
    
    
}

-(void) collisionBehavior:(UICollisionBehavior *)behavior beganContactForItem:(id<UIDynamicItem>)item1 withItem:(id<UIDynamicItem>)item2 atPoint:(CGPoint)p
{
    item1 = ballView;
    item2 = blockView;
    blockView.backgroundColor = [UIColor cyanColor];
    
}


@end
