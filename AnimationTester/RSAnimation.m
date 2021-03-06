//
//  RSAnimation.m
//  AnimationTester
//
//  Created by Anh Nguyen on 10/26/12.
//  Copyright (c) 2012 Redshift Interactive. All rights reserved.
//

#import "RSAnimation.h"

@implementation CCAnimation (Helper)

// Generate an animation using a series of files with consistant filenames
// example: image-01.png, image-02.png, image-03.png, etc
+(CCAnimation *) animationWithFile:(NSString *)name     // the name of the files ex: "image-"
                        frameCount:(int)frameCount      // the number of images to make the animation
                             delay:(float)delay         // the time delay between each frame animation
{
	// load the animation frames as textures and create the sprite frames
	NSMutableArray *frames = [NSMutableArray arrayWithCapacity:frameCount];
	for (int i = 1; i <= frameCount; i++)
	{
		// Assuming all animation files are named "name_i.png" with i being a consecutive number starting with 1.
		NSString* file = [NSString stringWithFormat:@"%@%02i.png", name, i];
		CCTexture2D* texture = [[CCTextureCache sharedTextureCache] addImage:file];
        
		// Assuming that image file animations always use the whole image for each animation frame.
		CGSize textureSize = texture.contentSize;
		CGRect textureRect = CGRectMake(0, 0, textureSize.width, textureSize.height);
		CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:texture rect:textureRect];
		
		[frames addObject:frame];
	}
	
	// create an animation object from all the sprite animation frames
	return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}

// Generate an animation using a an existing animation sheet and plist using Zwoptex, Texture Packer,
// or a Texture Atlus type image package tool
+(CCAnimation *) animationWithFrame:(NSString *)frameName       // the name of the sprite sheet .plist file
                      animationName:(NSString *)animationName   // the name of the animation within the texture
                         frameCount:(int)frameCount             // the number of images to make the animation
                              delay:(float)delay                // the time delay between each frame animation
{
    // load the animation frames as textures and create a sprite frame
	NSMutableArray *frames = [NSMutableArray arrayWithCapacity:frameCount];
	for (int i = 1; i <= frameCount; i++)
	{
		NSString *file = [NSString stringWithFormat:@"%@%02i.png", animationName, i];
        //NSString *file = [NSString stringWithFormat:@"%@%i.png", animationName, i];
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
         [NSString stringWithFormat:@"%@.plist", frameName]];
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file];
		[frames addObject:frame];
	}
	
	// return an animation object from all the sprite animation frames
	return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}

// Generate an animation using a sprite sheet with even spacing between frames
// example: 1 | 2 | 3 | 4   Image are even spaced in size.
//          -------------   Use, width: 4, height: 2, count: 8 for this example
//          5 | 6 | 7 | 8
+(CCAnimation *) animationWithSpriteSheet:(NSString *)fileName    // the name of the sprite sheet file
                               frameCount:(int)frameCount         // the number of frames in the sprite sheet
                          frameCountWidth:(int)frameCountWidth    // the number of frames spread out horizontally
                         frameCountHeight:(int)frameCountHeight   // the number of frames spread out vertically
                               frameWidth:(int)frameWidth         // the width of each frame in pixels
                              frameHeight:(int)frameHeight        // the height of each frame in pixels
                                    delay:(float)delay            // the time delay between each frame animation
{
    // load the spritesheet file
    CCSprite *animationSprite = [CCSprite spriteWithFile:fileName];
    
    // load the animation frames as textures and create the sprite frames
	NSMutableArray* frames = [NSMutableArray arrayWithCapacity:frameCount];
    
    int tempFrameCount = 0;
    for (int i = 0; i < frameCountHeight; i++)
    {
        for (int j = 0; j <frameCountWidth; j++)
        {
            CGRect textureRect = CGRectMake(j * frameWidth,
                                            i * frameHeight,
                                            frameWidth,
                                            frameHeight);
            CCSpriteFrame* frame = [CCSpriteFrame frameWithTexture:animationSprite.texture
                                                              rect:textureRect];
            [frames addObject:frame];
            
            // Exit loop to not add blank texture to the animation.
            // Example: Sprite sheet that has 8 frame animation arranged in a 3x3 sprite sheet.
            //          1 | 2 | 3
            //          ---------
            //          4 | 5 | 6
            //          ---------
            //          7 | 8 |  
            tempFrameCount++;
            if (tempFrameCount == frameCount)
                break;
        }
    }
    
    // create an animation object from all the sprite animation frames
	return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}

// Generate animation based on frame numbers to allow for reuse of image
+(CCAnimation *) animationWithFrame:(NSString *)frameName       // the name of the sprite sheet .plist file
                      animationName:(NSString *)animationName   // the name of the animation within the texture
                           frameSet:(NSArray *)frameSet         // number array of the order to run the frames
                              delay:(float)delay                // the time delay between each frame animation
{
    // load the animation frames as textures and create a sprite frame
	NSMutableArray *frames = [NSMutableArray arrayWithCapacity:[frameSet count]];
	for (int i = 0; i < [frameSet count]; i++)
	{
		NSString *file = [NSString stringWithFormat:@"%@%02i.png", animationName, [[frameSet objectAtIndex:i] intValue]];
        //NSString *file = [NSString stringWithFormat:@"%@%i.png", animationName, [[frameSet objectAtIndex:i] intValue]];
		[[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:
         [NSString stringWithFormat:@"%@.plist", frameName]];
		CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:file];
		[frames addObject:frame];
	}
	
	// return an animation object from all the sprite animation frames
	return [CCAnimation animationWithSpriteFrames:frames delay:delay];
}

@end
