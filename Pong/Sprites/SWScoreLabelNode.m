//
//  SWScoreLabelNode.m
//  Pong
//
//  Created by Sam Ward on 10/11/2013.
//  Copyright (c) 2013 Sam Ward. All rights reserved.
//

#import "SWScoreLabelNode.h"

@interface SWScoreLabelNode ()

@property (nonatomic) NSInteger score;

@end

@implementation SWScoreLabelNode

-(id)init {
    self = [super init];
    
    if (self) {
        self.fontSize = 32.0f;
        self.fontName = @"Thonburi-Bold";
    }
    
    return self;
}


- (void)increaseScore:(NSInteger)amount
{
    self.score = self.score + amount;
    self.text = @(self.score).stringValue ;
}

- (void)resetScore
{
//    SKAction *wait = [SKAction waitForDuration:1.0];
//    SKAction *mySceneBlock = [SKAction runBlock:^{
//        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
//        [self.view presentScene:[[SWMyScene alloc] initWithSize:self.size] transition: reveal];
//    }];
//    
//    SKAction *gameOverBlock = [SKAction runBlock:^{
//        SWGameOverScene *gameOverScene = [[SWGameOverScene alloc] initWithSize:self.size];
//        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
//        [self.view presentScene:gameOverScene transition: reveal];
//    }];
//    
//    [self runAction:[SKAction sequence:@[wait, gameOverBlock, mySceneBlock]]];
//    
    self.score = 0;
    self.text = @(self.score).stringValue;
}

- (void)decreaseScore:(NSInteger)amount
{
    self.score = self.score - amount;
    self.text = @(self.score).stringValue;
}


@end
