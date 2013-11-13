//
//  SKColor+SWColors.m
//  Pong
//
//  Created by Sam Ward on 27/10/2013.
//  Copyright (c) 2013 Sam Ward. All rights reserved.
//

#import "SKColor+SWColors.h"

#import <SpriteKit/SpriteKit.h>

@implementation SKColor (SWColors)

+ (SKColor *)backgroundColor {
    
    return [SKColor colorWithRed:0.15 green:0.15 blue:0.2 alpha:1.0];
}

+ (SKColor *)paddleColor {
    
    return [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
}

@end
