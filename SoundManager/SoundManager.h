//
//  SoundManager.h
//  SoundManager
//
//  Created by Michael Manesh on 2/18/16.
//  Copyright © 2016 Michael Manesh. All rights reserved.
//
//  Simple class for managing sound effects. Allows you to preload all sound files in a directory
//  into memory & play them.

#import <Foundation/Foundation.h>

@interface SoundManager : NSObject

/**
 SoundManager singleton.
 */
+ (instancetype)sharedManager;

/**
 Array of all sound filenames in NSString format. nil until setSoundsDirectory: is called to initialize the manager.
 */
@property (nonatomic, strong) NSArray *sounds;

/**
 Tell the sound manager the folder which contains the audio files you want to preload.
 
 @param directory The resource directory containing all the sounds you want the sound manager to load into memory.
 */
- (void)setSoundsDirectory:(NSString *)directory;

/**
 Preload all sounds into memory asynchronously and call completionBlock when finished.
 */
- (void)preloadSounds:(void(^)())completionBlock;

/**
 YES if the sounds are all preloaded into memory and ready to play.
 */
@property (nonatomic) BOOL soundsPreloaded;

/**
 Plays the sound that corresponds to a filename. If the sound is already playing, nothing will happen.
 */
- (void)playSound:(NSString *)filename;

/**
 Stop all sounds from playing.
 */
- (void)stopAllSounds;

@end
