//
//  SWViewController.m
//  Pong
//
//  Created by Sam Ward on 25/10/2013.
//  Copyright (c) 2013 Sam Ward. All rights reserved.
//

#import "SWViewController.h"
#import "SWMyScene.h"

@implementation SWViewController

- (void)viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    SKView * skView = (SKView *)self.view;
    
    if (!skView.scene) {
        
        // Create and configure the scene.
        SKScene * scene = [SWMyScene sceneWithSize:skView.bounds.size];
        scene.scaleMode = SKSceneScaleModeAspectFill;
        
        // Present the scene.
        [skView presentScene:scene];
    }
}

- (BOOL)shouldAutorotate {
    
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations {
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (BOOL)prefersStatusBarHidden {
    
    return YES;
}

@end
