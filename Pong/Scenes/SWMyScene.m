//
//  SWMyScene.m
//  Pong
//
//  Created by Sam Ward on 25/10/2013.
//  Copyright (c) 2013 Sam Ward. All rights reserved.
//

#import "SWMyScene.h"
#import "SWGameOverScene.h"

#import "SKColor+SWColors.h"
#import "SWBallSpriteNode.h"
#import "SWPaddleSpriteNode.h"
#import "SWScoreLabelNode.h"

@interface SWMyScene ()

@property (nonatomic, strong) SWPaddleSpriteNode *paddle;
@property (nonatomic, strong) SWBallSpriteNode *ball;
@property (nonatomic, strong) SWScoreLabelNode *scoreLabel;

@property (nonatomic) NSTimeInterval lastUpdateTime;
@property (nonatomic) NSTimeInterval dt;

@end

@implementation SWMyScene

- (void)setupBackground
{
    SKSpriteNode *background = [[SKSpriteNode alloc] initWithColor:[SKColor backgroundColor] size:self.frame.size];
    background.position = CGPointMake(self.size.width / 2, self.size.height / 2);
    background.anchorPoint = CGPointMake(0.5, 0.5);
    [self addChild:background];
}

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        static const CGFloat edgePadding = 40.0f;
        
        [self setupBackground];
        
        _paddle = [[SWPaddleSpriteNode alloc] init];
        _paddle.position = CGPointMake(self.size.width/2, edgePadding);
        [self addChild:_paddle];
        
        _ball = [[SWBallSpriteNode alloc] initWithPosition:CGPointMake(self.size.width/2, self.size.height / 2)
                                                  Velocity:CGPointMake(100, -100)];
        [self addChild:_ball];
        
        _scoreLabel = [[SWScoreLabelNode alloc] init];
        _scoreLabel.position = CGPointMake(self.size.width/2, self.size.height - 2*edgePadding);
        [self addChild:_scoreLabel];
    }
    
    return self;
}

- (void)moveGameObjects
{
    NSArray *gameObjects = @[self.paddle, self.ball];
    
    for (SWGameObject *sprite in gameObjects)
    {
        [self moveSprite:sprite velocity:sprite.velocity];
    }
    
    [self boundsCheckBall];
    [self boundsCheckPaddle];
}

- (void)update:(NSTimeInterval)currentTime
{
    if (self.lastUpdateTime) {
        self.dt = currentTime - self.lastUpdateTime;
    } else {
        self.dt = 0;
    }
    
    _lastUpdateTime = currentTime;
}

- (void)didEvaluateActions
{
    [self checkCollisions];
    
    [self moveGameObjects];
    
    [self.ball increaseVelocity];
    
}

- (void)moveSprite:(SKSpriteNode* )sprite velocity:(CGPoint)velocity
{
    CGPoint amountToMove = CGPointMake(velocity.x * self.dt,
                                       velocity.y * self.dt);
    
    sprite.position = CGPointMake(sprite.position.x + amountToMove.x,
                                  sprite.position.y + amountToMove.y);
}

#pragma mark - Touch Handling
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];

    touchLocation.y = 0;
    
    [self.paddle moveToward:touchLocation];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];
    
    touchLocation.y = 0;
    [self.paddle moveToward:touchLocation];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation = [touch locationInNode:self.scene];
    
    touchLocation.y = 0;

    self.paddle.velocity = CGPointMake(0, 0);
}

- (CGPoint)randomVelocity
{
    CGPoint newVelocity = self.ball.velocity;
    
    NSUInteger xRandomNumber = arc4random_uniform(10) + 1;
    NSUInteger yRandomNumber = arc4random_uniform(10) + 1;
    
    if (xRandomNumber % 2 == 0)
    {
        newVelocity = CGPointMake(5 * xRandomNumber, 5 * yRandomNumber);
    }
    else
    {
        newVelocity = CGPointMake(-5 * xRandomNumber, -5 * yRandomNumber);
    }
    
    return newVelocity;
}

- (void)boundsCheckBall
{
    CGPoint newPosition = self.ball.position;
    CGPoint newVelocity = self.ball.velocity;
    
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
        
        newVelocity = [self randomVelocity];
        newPosition = CGPointMake(self.size.width / 2, self.size.height / 2);
        [self.scoreLabel resetScore];
    }
    
    if (newPosition.y >= topRight.y) {
        newPosition.y = topRight.y;
        newVelocity.y = -newVelocity.y;
    }
    
    self.ball.position = newPosition;
    self.ball.velocity = newVelocity;
}

- (void)boundsCheckPaddle
{
    CGPoint newPosition = self.paddle.position;
    CGPoint newVelocity = self.paddle.velocity;
    
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

    self.paddle.position = newPosition;
    self.paddle.velocity = newVelocity;
}

- (void)checkCollisions
{
    if (CGRectIntersectsRect(self.ball.frame, self.paddle.frame)) {
        
        self.ball.velocity = CGPointMake(-self.ball.velocity.x, -self.ball.velocity.y);
        
        [self.scoreLabel increaseScore:1];
    }
}

@end
