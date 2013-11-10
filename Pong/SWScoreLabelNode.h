//
//  SWScoreLabelNode.h
//  Pong
//
//  Created by Sam Ward on 10/11/2013.
//  Copyright (c) 2013 Sam Ward. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SWScoreLabelNode : SKLabelNode

- (void)increaseScore:(NSInteger)amount;
- (void)resetScore;
- (void)decreaseScore:(NSInteger)amount;

@end
