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
    // TODO: make the cells unresponsive to touch when sounds not loaded
    else {
        cell.textLabel.textColor = [UIColor lightGrayColor];
    }
    
    cell.textLabel.text = self.filenames[[indexPath row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[SoundManager sharedManager] playSound:[self.filenames objectAtIndex:[indexPath row]]];
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
}

@end
