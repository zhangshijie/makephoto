//
//  FinishDrawingViewController.m
//  makephoto
//
//  Created by 张 世杰 on 12-12-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "FinishDrawingViewController.h"

@interface FinishDrawingViewController ()

@end

@implementation FinishDrawingViewController


@synthesize FinishedImageView;
@synthesize finishedImage;
@synthesize  scroll;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  
   
    
    [super viewDidLoad];
    CGRect frame= CGRectMake(10, 20, 300, 260);
    scroll =[[UIScrollView alloc]initWithFrame:frame];
	// Do any additional setup after loading the view.
    
 }

- (void)viewDidUnload
{

    
  

    [self setFinishedImageView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}



- (IBAction)publicationButtonOnClick:(id)sender {
}
@end
