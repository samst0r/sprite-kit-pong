//
//  SWMyScene.m
//  Pong
//
//  Created by Sam Ward on 25/10/2013.
//  Copyright (c) 2013 Sam Ward. All rights reserved.
//

#import "SWMyScene.h"
#import "SWGameOverScene.h"

static const float MOVE_POINTS_PER_SEC = 240.0;

static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b) {
    
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint CGPointSubtract(const CGPoint a,
                                      const CGPoint b) {
    
    return CGPointMake(a.x - b.x, a.y - b.y);
}

static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b) {
    
    return CGPointMake(a.x * b, a.y * b);
}

static inline CGFloat CGPointLength(const CGPoint a) {
    
    return sqrtf(a.x * a.x + a.y * a.y);
}

@interface SWMyScene ()

@property (nonatomic, copy) SKLabelNode *scoreLabel;

@end

@implementation SWMyScene {
    
    SKSpriteNode *_paddle;
    SKSpriteNode *_ball;
    
    NSNumber *score;
    
    CGPoint _velocity;
    CGPoint _ballVelocity;
    
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _dt;
    
}

-(id)initWithSize:(CGSize)size {
    
    if (self = [super initWithSize:size]) {
        
        static const CGFloat edgePadding = 40.0f;
        
        SKColor *backgroundColour = [SKColor colorWithRed:0.15 green:0.15 blue:0.2 alpha:1.0];
        SKColor *paddleColour = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        
        SKSpriteNode *background = [[SKSpriteNode alloc] initWithColor:backgroundColour size:self.frame.size];
        background.position = CGPointMake(self.size.width / 2, self.size.height / 2);
        background.anchorPoint = CGPointMake(0.5, 0.5);
        
        
        [self addChild:background];
        
        _paddle = [[SKSpriteNode alloc] initWithColor:paddleColour size:CGSizeMake(50, 10)];
        _paddle.position = CGPointMake(self.size.width/2, edgePadding);
        _paddle.anchorPoint = CGPointMake(0.5,0.5);
        
        [self addChild:_paddle];
        
        _ball = [[SKSpriteNode alloc] initWithColor:paddleColour size:CGSizeMake(10, 10)];
        _ball.position = CGPointMake(self.size.width/2, self.size.height / 2);
        
        [self addChild:_ball];
        
        _ballVelocity = CGPointMake(100, -100);
        
        _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Thonburi-Bold"];
        _scoreLabel.fontSize = 32.0f;
        _scoreLabel.position = CGPointMake(self.size.width/2, self.size.height - 2*edgePadding);
        
        [self resetScore];
        
        [self addChild:_scoreLabel];
        
        SKScene * gameOverScene = [[SWGameOverScene alloc] initWithSize:self.size];
        
        SKTransition *reveal = [SKTransition flipHorizontalWithDuration:0.5];
        [self.view presentScene:gameOverScene transition:reveal];

//        SKEmitterNode *_emitterNode = [SKEmitterNode new];
//        _emitterNode.particleBirthRate = 80.0;
//        _emitterNode.particleColor = [SKColor whiteColor];
//        _em
//        _emitterNode.particleSpeed = -450;
//        _emitterNode.particleSpeedRange = 150;
//        _emitterNode.particleLifetime = 2.0;
//        _emitterNode.particleScale = 0.2;
//        _emitterNode.particleAlpha = 0.75;
//        _emitterNode.particleAlphaRange = 0.5;
//        _emitterNode.particleColorBlendFactor = 1;
//        _emitterNode.particleScale = 0.2;
//        _emitterNode.particleScaleRange = 0.5;
//        _emitterNode.position = CGPointMake(CGRectGetWidth(self.frame) / 2, CGRectGetHeight(self.frame) + 10);
//        _emitterNode.particlePositionRange = CGVectorMake(CGRectGetMaxX(self.frame), 0);
//        [self addChild:_emitterNode];
        
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime {
    
    if (_lastUpdateTime) {
        _dt = currentTime - _lastUpdateTime;
    } else {
        _dt = 0;
    }
    _lastUpdateTime = currentTime;
    
    [self moveSprite:_paddle velocity:_velocity];
    [self moveSprite:_ball velocity:_ballVelocity];
    
    [self boundsCheckPaddle];
    [self boundsCheckBall];
    
    [self checkCollisions];
    
    if (_ballVelocity.y > 0) {
        _ballVelocity.y++;
    } else {
        _ballVelocity.y--;
    }
}

- (void)moveSprite:(SKSpriteNode* )sprite velocity:(CGPoint)velocity {
    
    CGPoint amountToMove = CGPointMake(velocity.x * _dt,
                                       velocity.y * _dt);
    
    sprite.position = CGPointMake(sprite.position.x + amountToMove.x,
                                  sprite.position.y + amountToMove.y);
}

- (void)rotateSprite:(SKSpriteNode *)sprite toFace:(CGPoint)direction
{
    sprite.zRotation = atan2f(direction.y, direction.x);
}

- (void)movePaddleToward:(CGPoint)location {
    
    CGPoint offset = CGPointMake(location.x - _paddle.position.x, location.y - _paddle.position.y);
    CGFloat length = sqrtf(offset.x * offset.x + offset.y * offset.y);
    
    CGPoint direction = CGPointMake(offset.x / length, offset.y / length);
    _velocity = CGPointMake(direction.x * (2*MOVE_POINTS_PER_SEC),
                            0);
}

#pragma mark - Touch Handling
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];

    touchLocation.y = 0;
    [self movePaddleToward:touchLocation];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];
    
    touchLocation.y = 0;
    [self movePaddleToward:touchLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];
    
    touchLocation.y = 0;

    _velocity = CGPointMake(0, 0);
}

- (void)boundsCheckBall {
    
    CGPoint newPosition = _ball.position;
    CGPoint newVelocity = _ballVelocity;
    
    CGPoint bottomLeft = CGPointZero;
    CGPoint topRight = CGPointMake(self.size.width,
                                   self.size.height);
    
    if (newPosition.x <= bottomLeft.x) {
        newPosition.x = bottomLeft.x;
        newVelocity.x = -newVelocity.x;
    }
    if (newPosition.x >= topRight.x) {
        newPosition.x = topRight.x;
        newVelocity.x = -newVelocity.x;
    }
    if (newPosition.y <= bottomLeft.y) {
        newPosition = CGPointMake(self.size.width / 2, self.size.height / 2);
        newVelocity = CGPointMake(40, 0);
        
        [self resetScore];
    }
    if (newPosition.y >= topRight.y) {
        newPosition.y = topRight.y;
        newVelocity.y = -newVelocity.y;
    }
    
    _ball.position = newPosition;
    _ballVelocity = newVelocity;
}

- (void)boundsCheckPaddle {
    
    CGPoint newPosition = _paddle.position;
    CGPoint newVelocity = _velocity;
    
    CGPoint bottomLeft = CGPointZero;
    CGPoint topRight = CGPointMake(self.size.width,
                                   self.size.height);
    
    if (newPosition.x <= bottomLeft.x) {
        newPosition.x = bottomLeft.x;
        newVelocity.x = -newVelocity.x;
    }
    if (newPosition.x >= topRight.x) {
        newPosition.x = topRight.x;
        newVelocity.x = -newVelocity.x;
    }
    if (newPosition.y <= bottomLeft.y) {
        newPosition.y = bottomLeft.y;
        newVelocity.y = -newVelocity.y;
    }
    
    if (newPosition.y >= topRight.y) {
        newPosition.y = topRight.y;
        newVelocity.y = -newVelocity.y;
    }

    _paddle.position = newPosition;
    _velocity = newVelocity;
}

- (void)increaseScore:(NSInteger)amount {
    
    score = [NSNumber numberWithInteger:score.integerValue + amount];
    self.scoreLabel.text = score.stringValue;
}

- (void)resetScore {
    
    score = 0;
    self.scoreLabel.text = score.stringValue;
}

- (void)decreaseScore:(NSInteger)amount {
    
    score = [NSNumber numberWithInteger:score.integerValue - amount];
    self.scoreLabel.text = score.stringValue;
}

- (void)checkCollisions {
    
    if (CGRectIntersectsRect(_ball.frame, _paddle.frame)) {
        
        _ballVelocity = CGPointMake(-_ballVelocity.x, -_ballVelocity.y);
        
        [self increaseScore:1];
    }
}

@end
