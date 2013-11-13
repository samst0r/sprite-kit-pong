//
//  SWGameObjects.h
//  Pong
//
//  Created by Sam Ward on 10/11/2013.
//  Copyright (c) 2013 Sam Ward. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface SWGameObject : SKSpriteNode

@property (nonatomic) CGPoint velocity;

- (void)moveToward:(CGPoint)location;

@end
