//
//  SWGameObjects.m
//  Pong
//
//  Created by Sam Ward on 10/11/2013.
//  Copyright (c) 2013 Sam Ward. All rights reserved.
//

#import "SWGameObject.h"

@implementation SWGameObject

static const float MOVE_POINTS_PER_SEC = 100.0;

- (void)moveToward:(CGPoint)location
{
    CGPoint offset = CGPointMake(location.x - self.position.x, location.y - self.position.y);
    CGFloat length = sqrtf(offset.x * offset.x + offset.y * offset.y);
    
    CGPoint direction = CGPointMake(offset.x / length, offset.y / length);
    self.velocity = CGPointMake(direction.x * (2 * MOVE_POINTS_PER_SEC),
                                0);
}

@end
