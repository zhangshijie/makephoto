//
//  LeftViewController.m
//  PPRevealSideViewController
//
//  Created by Marian PAUL on 16/02/12.
//  Copyright (c) 2012 Marian PAUL aka ipodishima — iPuP SARL. All rights reserved.
//

#import "TableViewController.h"
#import "CustomCell.h"
#import "SettingViewController.h"
#import "PPRevealSideViewController.h"
@implementation TableViewController



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (id)initWithStyleAndDrawSomething:(UITableViewStyle)style  with:(DrawSomethingViewController *) mDrawSomethingViewController
{
    currentDrawSomethingViewController=mDrawSomethingViewController;
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    @try {
        [self.tableView removeObserver:self
                            forKeyPath:@"revealSideInset"];
    }
    @catch (NSException *exception) {
        
    }
    @finally {
        
    }
    
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    [self.tableView addObserver:self 
                     forKeyPath:@"revealSideInset"
                        options:NSKeyValueObservingOptionNew
                        context:NULL];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [self.tableView removeObserver:self
                        forKeyPath:@"revealSideInset"];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
//    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"revealSideInset"]) {
        UIEdgeInsets newInset = self.tableView.contentInset;
        newInset.top = self.tableView.revealSideInset.top;
        newInset.bottom = self.tableView.revealSideInset.bottom;
        self.tableView.contentInset = newInset;
    }
    else
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
}

- (void) dealloc 
{
    @try{
        [self.tableView removeObserver:self
                            forKeyPath:@"revealSideInset"];
    }@catch(id anException){
        //do nothing, obviously it wasn't attached because an exception was thrown
    }
#if !PP_ARC_ENABLED
#endif
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    CustomCell *cell = (CustomCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = PP_AUTORELEASE([[CustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier]);
      
    }
    
    cell.accessoryType=UITableViewCellAccessoryNone;
    
      
    switch (indexPath.row % 2) {
        case 0:
            cell.myLabel.text = @"制作器";
            break;
        case 1:
            cell.myLabel.text = @"设置";
            break; 
        default:
            break;
    }
    cell.revealSideInset = self.tableView.revealSideInset;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard"bundle:nil];
    
    
    switch (indexPath.row % 2) {

        case 0:
        {
            UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:currentDrawSomethingViewController];
            [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
        
        }break;
            
        case 1:
        {
            SettingViewController *c = [[SettingViewController alloc]initWithStyle:UITableViewStyleGrouped];
            UINavigationController *n = [[UINavigationController alloc] initWithRootViewController:c];
            
            [self.revealSideViewController popViewControllerWithNewCenterController:n animated:YES];
            PP_RELEASE(c);
            PP_RELEASE(n);
        } break;
        default:
            break;
    }
}

@end
