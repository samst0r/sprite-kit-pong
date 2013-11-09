//
//  SWBallSpriteNode.m
//  Pong
//
//  Created by Sam Ward on 27/10/2013.
//  Copyright (c) 2013 Sam Ward. All rights reserved.
//

#import "SWBallSpriteNode.h"

@implementation SWBallSpriteNode

- (id)init {
    
    if (self) {
    
        [self initWithColor:paddleColour size:CGSizeMake(10, 10)]
    }

    return self;
}

@end
