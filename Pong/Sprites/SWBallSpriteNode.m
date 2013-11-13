//
//  SWBallSpriteNode.m
//  Pong
//
//  Created by Sam Ward on 27/10/2013.
//  Copyright (c) 2013 Sam Ward. All rights reserved.
//

#import "SWBallSpriteNode.h"

#import "SKColor+SWColors.h"

@implementation SWBallSpriteNode

- (id)initWithPosition:(CGPoint)position Velocity:(CGPoint)velocity {
    self = [self initWithColor:[SKColor paddleColor] size:CGSizeMake(10, 10)];
    
    if (self) {
        
    }

    return self;
}

- (void)increaseVelocity
{
    if (self.velocity.y > 0) {
      
        self.velocity = CGPointMake(self.velocity.x, self.velocity.y + 2);
    } else {
        
        self.velocity = CGPointMake(self.velocity.x, self.velocity.y - 2);
    }
}

@end
