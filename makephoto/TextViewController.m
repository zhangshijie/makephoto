//
//  TextViewController.m
//  makephoto
//
//  Created by 张 世杰 on 12-12-7.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "TextViewController.h"
#import "DrawSomethingViewController.h"
@interface TextViewController ()

@end

@implementation TextViewController
@synthesize InputText;

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
    InputText.delegate = self;
    
   
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [self setInputText:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)CompleteInput:(id)sender {
    
    
    PPRevealSideViewController *mPPRevealSideViewController=self.presentingViewController;
    
    
    UINavigationController  *navigation=mPPRevealSideViewController.rootViewController ;
//    
    DrawSomethingViewController *viewcontroller=[navigation.viewControllers objectAtIndex:0];
    
    
    viewcontroller.CurrentInput=InputText.text;
    
     viewcontroller.backsignal=viewcontroller.BACKfromWrite;
    
     [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)BackButtonOnClick:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [InputText resignFirstResponder];
}

@end
