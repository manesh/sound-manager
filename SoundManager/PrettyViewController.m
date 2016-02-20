//
//  PrettyViewController.m
//  SoundManager
//
//  Created by Michael Manesh on 2/19/16.
//  Copyright © 2016 Michael Manesh. All rights reserved.
//

#import "PrettyViewController.h"

#import "MasterViewController.h"
#import "SoundManager.h"
#import "SoundCell.h"

@interface PrettyViewController ()

@property (nonatomic, weak) NSArray *filenames;

@end

@implementation PrettyViewController

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // set styles
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Normal" style:UIBarButtonItemStylePlain target:self action:@selector(normalInterface:)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Stop" style:UIBarButtonItemStylePlain target:self action:@selector(stopAudio:)];
    self.navigationItem.rightBarButtonItem.tintColor = [UIColor whiteColor];
    UIImageView *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sound-manager-logo"]];
    self.navigationItem.titleView = titleView;
    
    // red mage red
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:193./255 green:39./255 blue:45./255 alpha:1];
    // red mage mid-red
    self.collectionView.backgroundColor = [UIColor colorWithRed:125./255 green:25./255 blue:29./255 alpha:1];
    
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:@"SoundCell" bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    
    // setup flowlayout
    UICollectionViewFlowLayout *flowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
    flowLayout.itemSize = CGSizeMake(100., 100.);
    flowLayout.estimatedItemSize = CGSizeMake(100., 100.);
    
    // create an evenly sized grid
    // TODO: make this look really good for all screen sizes + orientations. Optimized for iPhone/portrait currently
    CGFloat inset = (self.collectionView.frame.size.width - 300.) / 4;
    flowLayout.minimumInteritemSpacing = inset;
    flowLayout.minimumLineSpacing = inset;
    flowLayout.sectionInset = UIEdgeInsetsMake(inset, inset, inset, inset);
    
    // load sounds if they are not loaded already
    if (![[SoundManager sharedManager] soundsPreloaded])
    {
        // let the manager know where to find the sound files we want loaded
        [[SoundManager sharedManager] setSoundsDirectory:@"Sounds"];
        
        [[SoundManager sharedManager] preloadSounds:^{
            // update cells to make interactive when preloading finishes
            // TODO: update cells one-by-one as they become ready to play
            [self.collectionView reloadData];
        }];
    }
    
    self.filenames = [[SoundManager sharedManager] sounds];
    [self.collectionView reloadData];
}

- (void)normalInterface:(UIBarButtonItem *)button
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MasterViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:@"MasterViewController"];
    [self.navigationController setViewControllers:@[viewController] animated:NO];
}

- (void)stopAudio:(UIBarButtonItem *)button
{
    [[SoundManager sharedManager] stopAllSounds];
    [self.collectionView reloadData];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.filenames count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SoundCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // don't display the extension
    NSString *name = self.filenames[indexPath.row];
    NSArray *components = [name componentsSeparatedByString:@"."];
    cell.soundName.text = components[0];
    
    // show animation in the cell if the sound is currently playing
    if ([[SoundManager sharedManager] isSoundPlaying:self.filenames[indexPath.row]]) {
        [cell startPlayingAnimation];
    }
    else {
        [cell stopPlayingAnimation];
    }
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    // do not handle touch if sounds not yet preloaded
    if (![[SoundManager sharedManager] soundsPreloaded]) {
        return;
    }
    
    SoundCell *cell = (SoundCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    
    // start animation if not already playing
    if (![[SoundManager sharedManager] isSoundPlaying:self.filenames[indexPath.row]]) {
        [cell startPlayingAnimation];
    }
    
    [[SoundManager sharedManager] playSound:[self.filenames objectAtIndex:[indexPath row]] completion:^{
//        [cell stopPlayingAnimation];
    }];
}

#pragma mark <UICollectionViewDelegateFlowLayout>



@end
