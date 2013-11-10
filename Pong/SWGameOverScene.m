//
//  SWGameOver.m
//  Pong
//
//  Created by Sam Ward on 25/10/2013.
//  Copyright (c) 2013 Sam Ward. All rights reserved.
//

#import "SWGameOverScene.h"

@implementation SWGameOverScene

-(instancetype)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Thonburi-Bold"];
        scoreLabel.fontSize = 32.0f;
        scoreLabel.position = CGPointMake(self.size.width/2, self.size.height/2);
        scoreLabel.text = @"Game Over!";
        [self addChild:scoreLabel];
    }
    
    return self;
}

@end
