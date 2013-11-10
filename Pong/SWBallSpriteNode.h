//
//  SWBallSpriteNode.h
//  Pong
//
//  Created by Sam Ward on 27/10/2013.
//  Copyright (c) 2013 Sam Ward. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SWGameObject.h"

@interface SWBallSpriteNode : SWGameObject

- (id)initWithPosition:(CGPoint)position Velocity:(CGPoint)velocity;
-(void) increaseVelocity;

@end
