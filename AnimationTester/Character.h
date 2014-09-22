//
//  Character.h
//  AnimationTester
//
//  Created by Anh Nguyen on 10/16/13.
//  
//

#import "CCSprite.h"
#import "cocos2d.h"
#import "RSAnimation.h"

@interface Character : CCSprite
{
    NSMutableArray *attackActions;
}

-(void)playIdleAnimation;
-(void)playAttack:(int)attackNumber;
-(void)playVictory;
-(void)playAttackOne;
-(void)playAttackSnip;
-(void)playSuper;

@end
