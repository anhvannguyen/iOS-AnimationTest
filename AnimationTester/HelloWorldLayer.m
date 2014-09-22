//
//  HelloWorldLayer.m
//  AnimationTester
//
//  Created by Anh Nguyen on 1/16/13.
//  Copyright Redshift Interactive 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "RSAnimation.h"
#import "cocos2d.h"

#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super's" return value
	if( (self=[super init]) ) {
    
        // Get the window size
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        [CCMenuItemFont setFontName:@"Verdana"];
        
        // Create the buttons
        CCMenuItem *idleButton = [CCMenuItemFont itemWithString:@"Super" target:self selector:@selector(playSuper)];
        CCMenuItem *victoryButton = [CCMenuItemFont itemWithString:@"Victory" target:self selector:@selector(playVictory)];
        CCMenuItem *attackButton = [CCMenuItemFont itemWithString:@"Attack" target:self selector:@selector(playAttack)];
        // Create the menu and add the buttons to the menu
        CCMenu *menu = [CCMenu menuWithItems:idleButton, victoryButton, attackButton, nil];
        [menu alignItemsHorizontallyWithPadding:50];
        [menu setPosition:ccp(menu.contentSize.width/2, victoryButton.contentSize.height + 50)];
        [self addChild:menu];
        
        // Create the attack number buttoms
        attackCount = 1;
        attackCountLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%i", attackCount] dimensions:CGSizeMake(40, 35) hAlignment:kCCTextAlignmentCenter fontName:@"Verdana" fontSize:30];
        attackCountLabel.color = ccRED;
        attackCountLabel.position = ccp(winSize.width/2 + 250, victoryButton.contentSize.height + 50);
        [self addChild:attackCountLabel];
        
        CCMenuItem *decrementCounter = [CCMenuItemFont itemWithString:@"-" block:^(id sender) {
            if (attackCount > 1)
                attackCount--;
            [attackCountLabel setString:[NSString stringWithFormat:@"%i", attackCount]];
        }];
        CCMenuItem *incrementCounter = [CCMenuItemFont itemWithString:@"+" block:^(id sender) {
            if (attackCount < 9)
                attackCount++;
            [attackCountLabel setString:[NSString stringWithFormat:@"%i", attackCount]];
        }];
        CCMenu *counterMenu = [CCMenu menuWithItems:decrementCounter, incrementCounter, nil];
        [counterMenu alignItemsHorizontallyWithPadding:40];
        [counterMenu setPosition:ccp(menu.contentSize.width/2 + 255, victoryButton.contentSize.height + 50)];
        [self addChild:counterMenu];
        
        // Load in the image texture and use a region of the image as our initial image 
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"ken-puzzle.plist"];
        player = [[Character alloc] initWithSpriteFrameName:@"ken-puzzle-idle-01.png"];
        player.position = ccp(winSize.width/2, winSize.height/2);
        //player.scale = 2;
        [self addChild:player];
        
        
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void)playIdle {
    [player playIdleAnimation];
}

-(void)playSuper {
    [player playSuper];
}

-(void)playVictory {
    [player playVictory];
}

-(void)playAttack {
    [player playAttack:attackCount];
}

@end
