//
//  ViewController.m
//  makephoto
//
//  Created by 张 世杰 on 12-11-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end



@implementation ViewController


@synthesize SelectedImageUrl;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    NSLog(@"8888888888");
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

-(void)setSelectedImageUrl:(NSMutableString *)SelectedImageUrl
{
    
}

@end
