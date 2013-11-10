//
//  SWPaddleSpriteNode.m
//  Pong
//
//  Created by Sam Ward on 10/11/2013.
//  Copyright (c) 2013 Sam Ward. All rights reserved.
//

#import "SWPaddleSpriteNode.h"
#import "SKColor+SWColors.h"

@implementation SWPaddleSpriteNode

- (id)init {
    
    self = [self initWithColor:[SKColor paddleColor] size:CGSizeMake(50, 10)];
    
    if (self) {
        self.anchorPoint = CGPointMake(0.5,0.5);
    }
    
    return self;
}

@end
