//
//  Character.m
//  AnimationTester
//
//  Created by Anh Nguyen on 10/16/13.
//  
//

#import "Character.h"

@implementation Character

-(id)initWithSpriteFrameName:(NSString *)spriteFrameName {
    
    if (self = [super initWithSpriteFrameName:spriteFrameName]) {
        attackActions = [[NSMutableArray alloc] init];
        [self setupAttacks];
        [self playIdleAnimation];
        [self scheduleUpdate];
    }
    return self;
}

// Run an animation sequence once
-(void)runSingleAnimationType:(NSString *)listName frameName:(NSString *)frameName count:(int)count delay:(float)delay
{
    CCAnimation *finiteAnimation = [CCAnimation animationWithFrame:listName animationName:frameName frameCount:count delay:delay];
    CCAction *action = [CCAnimate actionWithAnimation:finiteAnimation];
    [self stopAllActions];
    [self runAction:action];
}

// Run an animation sequence and loop it nonstop
-(void)runRepeatAnimationType:(NSString *)listName frameName:(NSString *)frameName count:(int)count delay:(float)delay
{
    CCAnimation *finiteAnimation = [CCAnimation animationWithFrame:listName animationName:frameName frameCount:count delay:delay];
    CCAnimate *animateAction = [CCAnimate actionWithAnimation:finiteAnimation];
    CCAction *action = [CCRepeatForever actionWithAction:animateAction];
    [self stopAllActions];
    [self runAction:action];
}

-(void)playIdleAnimation {
    [self stopAllActions];
    int idleSequence[] = { 1, 2, 3, 4, 3, 2, 1 };
    int idleFrameCount = sizeof(idleSequence)/sizeof(idleSequence[0]);
    NSMutableArray *idleArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < idleFrameCount; i++)
    {
        [idleArray addObject:[NSNumber numberWithInt:idleSequence[i]]];
    }
    CCAnimation *idleAnimation = [CCAnimation animationWithFrame:@"ken-puzzle"
                                                   animationName:@"ken-puzzle-idle-"
                                                        frameSet:idleArray delay:0.1];
    CCAction *idleAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:idleAnimation]];
    [self runAction:idleAction];
}

-(void)playVictory {
    [self stopAllActions];
    [self runSingleAnimationType:@"ken-puzzle" frameName:@"ken-puzzle-victory-" count:10 delay:0.1];
    
}

-(void)playAttack:(int)attackNumber {
    if (attackNumber < 1)
        return;
    // Create the order of attacks that seem to fit the best
    int sequence[] = { 7, 5, 8, 6, 1, 2, 3, 4, 9};
    
    //CCAction *action = [attackActions objectAtIndex:attackNumber-1];
    NSMutableArray *actionArray = [[NSMutableArray alloc] init];
    for (int i = 0; i <= attackNumber-1; i++) {
        [actionArray addObject:[attackActions objectAtIndex:sequence[i]-1]];
    }
    [self stopAllActions];
    //[self runAction:action];
    [self runAction:[CCSequence actionWithArray:actionArray]];
    [actionArray removeAllObjects];
}

-(void)playAttackOne {
    [self stopAllActions];
    [self runSingleAnimationType:@"ken-puzzle" frameName:@"ken-puzzle-combo-" count:25 delay:0.1];
}

-(void)playAttackSnip {
    int sample[] = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10 };
    int size = sizeof(sample)/sizeof(sample[0]);
    
    NSMutableArray *testArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < size; i++)
    {
        [testArray addObject:[NSNumber numberWithInt:sample[i]]];
    }
    
    
    CCAnimation *testAnimation = [CCAnimation animationWithFrame:@"ken-puzzle"
                                                   animationName:@"ken-puzzle-combo-"
                                                        frameSet:testArray
                                                           delay:0.1];
    CCAction *action = [CCAnimate actionWithAnimation:testAnimation];
    [self stopAllActions];
    [self runAction:action];
    
}

-(void)playSuper {
    [self stopAllActions];
    [self runSingleAnimationType:@"ken-puzzle" frameName:@"ken-puzzle-shoryureppa-" count:16 delay:0.1];
}

-(void)setupAttacks {
    // We can mix around and reuse certain image frame to cut back on redrawing certain image or
    // possibly from new animation depending on how the images are drawn
    
    // Hard numbers are used because these image are pulled off the internet and out together,
    // and there wasn't a better naming convention setup.
    
    // Setup frame numbers
    int attack1[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }; // ken-puzzle-combo set 1
    int attack2[] = { 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25 }; // ken-puzzle-combo set 2
    int attack3[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15 }; // ken-puzzle-100lbs
    int attack4[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 }; // ken-puzzle-donkeykick
    int attack5[] = { 1, 2, 3, 4, 5, 6, 7, 8, 9 }; // ken-puzzle-attacks set 1
    int attack6[] = { 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22 }; // ken-puzzle-attacks set 2
    int attack7[] = { 23, 24, 25, 26, 27, 28, 29, 30, 31, 39, 40, 41 }; // ken-puzzle-attacks set 3
    int attack8[] = { 23, 24, 25, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41 };  // ken puzzle-attacks set 4
    int attack9[] = { 11, 12, 13, 12, 11, 10, 11, 12, 13, 12, 11, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22 }; // ken-puzzle-attacks modified 2
    
    
    // Convert frame numbers to NSMutable Array
    int size1Attack = sizeof(attack1)/sizeof(attack1[0]);
    NSMutableArray *attack1Array = [[NSMutableArray alloc] init];
    for (int i = 0; i < size1Attack; i++)
    {
        [attack1Array addObject:[NSNumber numberWithInt:attack1[i]]];
    }
    
    int size2Attack = sizeof(attack2)/sizeof(attack2[0]);
    NSMutableArray *attack2Array = [[NSMutableArray alloc] init];
    for (int i = 0; i < size2Attack; i++)
    {
        [attack2Array addObject:[NSNumber numberWithInt:attack2[i]]];
    }
    
    int size3Attack = sizeof(attack3)/sizeof(attack3[0]);
    NSMutableArray *attack3Array = [[NSMutableArray alloc] init];
    for (int i = 0; i < size3Attack; i++)
    {
        [attack3Array addObject:[NSNumber numberWithInt:attack3[i]]];
    }
    
    int size4Attack = sizeof(attack4)/sizeof(attack4[0]);
    NSMutableArray *attack4Array = [[NSMutableArray alloc] init];
    for (int i = 0; i < size4Attack; i++)
    {
        [attack4Array addObject:[NSNumber numberWithInt:attack4[i]]];
    }
    
    int size5Attack = sizeof(attack5)/sizeof(attack5[0]);
    NSMutableArray *attack5Array = [[NSMutableArray alloc] init];
    for (int i = 0; i < size5Attack; i++)
    {
        [attack5Array addObject:[NSNumber numberWithInt:attack5[i]]];
    }
    
    int size6Attack = sizeof(attack6)/sizeof(attack6[0]);
    NSMutableArray *attack6Array = [[NSMutableArray alloc] init];
    for (int i = 0; i < size6Attack; i++)
    {
        [attack6Array addObject:[NSNumber numberWithInt:attack6[i]]];
    }
    
    int size7Attack = sizeof(attack7)/sizeof(attack7[0]);
    NSMutableArray *attack7Array = [[NSMutableArray alloc] init];
    for (int i = 0; i < size7Attack; i++)
    {
        [attack7Array addObject:[NSNumber numberWithInt:attack7[i]]];
    }
    
    int size8Attack = sizeof(attack8)/sizeof(attack8[0]);
    NSMutableArray *attack8Array = [[NSMutableArray alloc] init];
    for (int i = 0; i < size8Attack; i++)
    {
        [attack8Array addObject:[NSNumber numberWithInt:attack8[i]]];
    }
    
    int size9Attack = sizeof(attack9)/sizeof(attack9[0]);
    NSMutableArray *attack9Array = [[NSMutableArray alloc] init];
    for (int i = 0; i < size9Attack; i++)
    {
        [attack9Array addObject:[NSNumber numberWithInt:attack9[i]]];
    }
    
    // Create Animation/Action and add it to the action array.
    CCAnimation *attack1Animation = [CCAnimation animationWithFrame:@"ken-puzzle"
                                                      animationName:@"ken-puzzle-combo-"
                                                           frameSet:attack1Array delay:0.1];
    CCAction *actionAttack1 = [CCAnimate actionWithAnimation:attack1Animation];
    [attackActions addObject: actionAttack1];
    
    CCAnimation *attack2Animation = [CCAnimation animationWithFrame:@"ken-puzzle"
                                                      animationName:@"ken-puzzle-combo-"
                                                           frameSet:attack2Array delay:0.1];
    CCAction *actionAttack2 = [CCAnimate actionWithAnimation:attack2Animation];
    [attackActions addObject: actionAttack2];
    
    CCAnimation *attack3Animation = [CCAnimation animationWithFrame:@"ken-puzzle"
                                                      animationName:@"ken-puzzle-100lb-"
                                                           frameSet:attack3Array delay:0.1];
    CCAction *actionAttack3 = [CCAnimate actionWithAnimation:attack3Animation];
    [attackActions addObject: actionAttack3];
    
    CCAnimation *attack4Animation = [CCAnimation animationWithFrame:@"ken-puzzle"
                                                      animationName:@"ken-donkeykick-"
                                                           frameSet:attack4Array delay:0.1];
    CCAction *actionAttack4 = [CCAnimate actionWithAnimation:attack4Animation];
    [attackActions addObject: actionAttack4];
    
    CCAnimation *attack5Animation = [CCAnimation animationWithFrame:@"ken-puzzle"
                                                      animationName:@"ken-puzzle-attacks-"
                                                           frameSet:attack5Array delay:0.1];
    CCAction *actionAttack5 = [CCAnimate actionWithAnimation:attack5Animation];
    [attackActions addObject: actionAttack5];
    
    CCAnimation *attack6Animation = [CCAnimation animationWithFrame:@"ken-puzzle"
                                                      animationName:@"ken-puzzle-attacks-"
                                                           frameSet:attack6Array delay:0.1];
    CCAction *actionAttack6 = [CCAnimate actionWithAnimation:attack6Animation];
    [attackActions addObject: actionAttack6];
    
    CCAnimation *attack7Animation = [CCAnimation animationWithFrame:@"ken-puzzle"
                                                      animationName:@"ken-puzzle-attacks-"
                                                           frameSet:attack7Array delay:0.1];
    CCAction *actionAttack7 = [CCAnimate actionWithAnimation:attack7Animation];
    [attackActions addObject: actionAttack7];
    
    CCAnimation *attack8Animation = [CCAnimation animationWithFrame:@"ken-puzzle"
                                                      animationName:@"ken-puzzle-attacks-"
                                                           frameSet:attack8Array delay:0.1];
    CCAction *actionAttack8 = [CCAnimate actionWithAnimation:attack8Animation];
    [attackActions addObject: actionAttack8];
    
    CCAnimation *attack9Animation = [CCAnimation animationWithFrame:@"ken-puzzle"
                                                      animationName:@"ken-puzzle-attacks-"
                                                           frameSet:attack9Array delay:0.1];
    CCAction *actionAttack9 = [CCAnimate actionWithAnimation:attack9Animation];
    [attackActions addObject: actionAttack9];
    
}

-(void)update:(ccTime)dt {
    // Run the idle animation when nothing is happen, otherwise we will get only a still image
    if ([self numberOfRunningActions] == 0) {
        [self playIdleAnimation];
    }
}

@end
