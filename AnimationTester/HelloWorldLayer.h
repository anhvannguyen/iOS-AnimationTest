//
//  HelloWorldLayer.h
//  AnimationTester
//
//  Created by Anh Nguyen on 10/22/13.
//  
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "Character.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer <GKAchievementViewControllerDelegate, GKLeaderboardViewControllerDelegate>
{
    Character *player;
    CCLabelTTF *attackCountLabel;
    int attackCount;
}

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
