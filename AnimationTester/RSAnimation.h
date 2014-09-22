//
//  RSAnimation.h
//  AnimationTester
//
//  Created by Anh Nguyen on 10/26/12.
//  Copyright (c) 2012 Redshift Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCAnimation (Helper)

+(CCAnimation *) animationWithFile:(NSString*)name
                        frameCount:(int)frameCount
                             delay:(float)delay;

+(CCAnimation *) animationWithFrame:(NSString *)frameName
                      animationName:(NSString *)animationName
                         frameCount:(int)frameCount
                              delay:(float)delay;

+(CCAnimation *) animationWithSpriteSheet:(NSString*)fileName
                               frameCount:(int)frameCount
                          frameCountWidth:(int)frameCountWidth
                         frameCountHeight:(int)frameCountHeight
                               frameWidth:(int)frameWidth
                              frameHeight:(int)frameHeight
                                    delay:(float)delay;

+(CCAnimation *) animationWithFrame:(NSString *)frameName
                      animationName:(NSString *)animationName
                           frameSet:(NSArray *)frameSet
                              delay:(float)delay;
@end
