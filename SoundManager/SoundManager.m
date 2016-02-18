//
//  SoundManager.m
//  SoundManager
//
//  Created by Michael Manesh on 2/18/16.
//  Copyright © 2016 Michael Manesh. All rights reserved.
//
//  This class is responsible for playing sounds.
//

#import "SoundManager.h"
#import <AVFoundation/AVFoundation.h>

@interface SoundManager ()

/**
 Base path to sounds directory.
 */
@property (nonatomic, strong) NSURL *soundsPath;

/**
 Cached array of all sounds.
 */
@property (nonatomic, strong) NSArray *sounds;

/**
 Shared audio player for all sounds.
 */
@property (nonatomic, strong) AVAudioPlayer *player;

@end

@implementation SoundManager

+ (instancetype)manager {
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (NSArray *)availableSounds {
    
    if (!self.sounds) {
        // get a list of all sounds stored in the "Sounds" directory
        NSURL *path = [[NSBundle mainBundle] bundleURL];
        self.soundsPath = [path URLByAppendingPathComponent:@"Sounds"];
        self.sounds = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.soundsPath error:nil];
    }
    
    return self.sounds;
}

- (void)playSound:(NSString *)filename {
    NSURL *soundPath = [self.soundsPath URLByAppendingPathComponent:filename];
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundPath
                                                                   error:nil];
    [self.player prepareToPlay];
    [self.player play];
}

@end
