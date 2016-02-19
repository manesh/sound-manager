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
 Dictionary of all audio players corresponding to the sound filenames.
 */
@property (nonatomic, strong) NSDictionary *audioPlayers;

/**
 Shared audio queue for all sounds.
 */
@property (nonatomic, strong) AVQueuePlayer *queue;

@end

@implementation SoundManager

+ (instancetype)sharedManager
{
    static dispatch_once_t once;
    static id sharedInstance;
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)preloadSounds:(void(^)())completionBlock
{
    // defensive programming: crash if this method is called without first calling setSoundsDirectory:
    assert(self.sounds);
    
    dispatch_queue_t backgroundQueue = dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);

    // load audio files on background queue
    dispatch_async(backgroundQueue, ^{
        NSMutableDictionary *audioPlayers = [[NSMutableDictionary alloc] initWithCapacity:[self.sounds count]];
        
        for (NSString *filename in self.sounds) {
            NSURL *soundPath = [self.soundsPath URLByAppendingPathComponent:filename];
            AVAudioPlayer *player = [[AVAudioPlayer alloc] initWithContentsOfURL:soundPath error:nil];
            
            BOOL success = [player prepareToPlay];
            
            if (!success) {
                // TODO: handle potential out-of-memory condition if too many audio files loaded
            }
            
            [audioPlayers setObject:player forKey:filename];
        }
        
        self.audioPlayers = [[NSDictionary alloc] initWithDictionary:audioPlayers];
        
        self.soundsPreloaded = YES;
        
        // dispatch back to main queue to update UI when finished
        dispatch_async(dispatch_get_main_queue(), ^{
            if (completionBlock) {
                completionBlock();
            }
        });
        
    });

}

- (void)setSoundsDirectory:(NSString *)directory
{
    // get a list of all sounds stored in the "Sounds" directory
    NSURL *path = [[NSBundle mainBundle] bundleURL];
    self.soundsPath = [path URLByAppendingPathComponent:directory];
    self.sounds = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:self.soundsPath error:nil];
}

#pragma mark - Playing / stopping / getting info about sounds

- (void)playSound:(NSString *)filename
{
    AVAudioPlayer *player = self.audioPlayers[filename];
    [player play];
}

- (void)playSound:(NSString *)filename completion:(void (^)())completionBlock
{
    AVAudioPlayer *player = self.audioPlayers[filename];
    
    if (player.isPlaying) {
        return; // do nothing if clip already playing
    }

    // fire completion block after the duration of the audio clip
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(player.duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        if (completionBlock) {
            completionBlock();
        }
    });
    
    [player play];
}

- (NSTimeInterval)soundDuration:(NSString *)filename
{
    AVAudioPlayer *player = self.audioPlayers[filename];
    return player.duration;
}

- (BOOL)isSoundPlaying:(NSString *)filename
{
    AVAudioPlayer *player = self.audioPlayers[filename];
    return player.isPlaying;
}

- (void)stopAllSounds {
    NSArray *allPlayers = [self.audioPlayers allValues];
    for (AVAudioPlayer *player in allPlayers) {
        [player stop];
    }
}

@end
