//
//  SoundManager.h
//  SoundManager
//
//  Created by Michael Manesh on 2/18/16.
//  Copyright © 2016 Michael Manesh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SoundManager : NSObject

/**
 SoundManager singleton.
 */
+ (instancetype)manager;

/**
 @return A list of sound filenames that can be played (in NSString format)
 */
- (NSArray *)availableSounds;

/**
 Plays the sound that corresponds to filename
 */
- (void)playSound:(NSString *)filename;

@end
