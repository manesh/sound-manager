//
//  MasterViewController.m
//  SoundManager
//
//  Created by Michael Manesh on 2/18/16.
//  Copyright © 2016 Michael Manesh. All rights reserved.
//

#import "MasterViewController.h"
#import "SoundManager.h"

@interface MasterViewController ()

@property (nonatomic, weak) NSArray *filenames;

@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStylePlain target:self action:@selector(stopAudio:)];
    
    // let the manager know where to find the sound files we want loaded
    [[SoundManager sharedManager] setSoundsDirectory:@"Sounds"];
    self.filenames = [[SoundManager sharedManager] sounds];
    
    [[SoundManager sharedManager] preloadSounds:^{
        // update cells to make interactive when preloading finishes
        // TODO: update cells one-by-one as they become ready to play
        [self.tableView reloadData];
    }];
}

#pragma mark - Table View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.filenames.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    // display the cell in black if the sound is preloaded and ready to play
    if ([[SoundManager sharedManager] soundsPreloaded]) {
        cell.textLabel.textColor = [UIColor blackColor];
    }
    // otherwise, display the disabled color
    else {
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    
    // show a checkmark in the cell if the sound is currently playing
    if ([[SoundManager sharedManager] isSoundPlaying:self.filenames[indexPath.row]]) {
        [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
    }
    else {
        [cell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    // display the cell's text
    NSString *filename = self.filenames[indexPath.row];
    NSTimeInterval duration = [[SoundManager sharedManager] soundDuration:filename];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ (%.2f)", filename, duration];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // do not handle touch if sounds not yet preloaded
    if (![[SoundManager sharedManager] soundsPreloaded]) {
        return;
    }
    
    // immediately display a checkmark in the selected cell to indicate it's started playing.
    [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryCheckmark];
    
    [[SoundManager sharedManager] playSound:[self.filenames objectAtIndex:[indexPath row]] completion:^{
    [[self.tableView cellForRowAtIndexPath:indexPath] setAccessoryType:UITableViewCellAccessoryNone];
    }];

    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

#pragma mark - Buttons

- (void)stopAudio:(UIBarButtonItem *)button
{
    [[SoundManager sharedManager] stopAllSounds];
    [self.tableView reloadData];
}

@end
