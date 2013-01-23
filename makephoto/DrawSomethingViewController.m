//
//  DrawSomethingViewController.m
//  makephoto
//
//  Created by 张 世杰 on 12-12-2.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "DrawSomethingViewController.h"
#import "VerticallyAlignedLabel.h"

@interface DrawSomethingViewController ()

@end

@implementation DrawSomethingViewController


@synthesize SelectedString,InsideImageViews,ImageURLs,backsignal,BACKfromCHOOSE,BACKfromNAVIGATION,BACKfromWrite,CurrentImageView,InsideUserResizableView,CGRectsOfSPUserResizableViews,TheTag,CurrentInput,myPageScrollView,boraderview,boraderViews,AllInsideUserResizableView;

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
    
    
    
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithTitle:@"Left"
                                                             style:UIBarButtonItemStylePlain
                                                            target:self
                                                            action:@selector(showLeft)];
    self.navigationItem.leftBarButtonItem = PP_AUTORELEASE(left);
    
    [self.revealSideViewController setDirectionsToShowBounce:PPRevealSideDirectionBottom | PPRevealSideDirectionLeft | PPRevealSideDirectionRight | PPRevealSideDirectionTop];
    
    PPRevealSideInteractions inter = PPRevealSideInteractionNone;
    inter |= PPRevealSideInteractionContentView;
    self.revealSideViewController.panInteractionsWhenClosed = inter;
    
    _animated = YES;
    
    [self doSomeInit];
    
    CGRect gripFrame = CGRectMake(10, 20, 300, 260);
    CGRect pageScrollViewFrame = CGRectMake(0, 0, 320, 300);
    
    boraderview = [[UIView alloc] initWithFrame:gripFrame];
    [self.boraderview setBackgroundColor:[UIColor blueColor]];    
     self.boraderViews = [[NSMutableArray alloc]init ];
    [self.boraderViews addObject:self.boraderview]; 
    myPageScrollView = [[PageScrollView alloc]initWithFrame:pageScrollViewFrame];
    myPageScrollView.scrollView.delegate=self;
    [myPageScrollView setBackgroundColor:[UIColor brownColor]];
    [myPageScrollView.scrollView setBackgroundColor:[UIColor whiteColor]];
    [myPageScrollView.scrollView insertSubview:[boraderViews objectAtIndex:0]  atIndex:0];
    currentBoradView = [self.boraderViews objectAtIndex:currentNum];
    [self.view addSubview:myPageScrollView];
}


- (void) doSomeInit
{
    currentNum=0;
    BACKfromCHOOSE=1;
    BACKfromNAVIGATION=2;
    BACKfromWrite=3;    
    TheTag=0;
    backsignal=0;
    
    _offset=240;
    
    myPreviewViewContorller= [[PreviewViewController alloc]init];
    
    
//    [self initPreviewController];
    
    InsideImageViews=[[NSMutableArray alloc]init];    
    AllInsideUserResizableView=[[NSMutableArray alloc]init];
    
    [AllInsideUserResizableView insertObject:[[NSMutableArray alloc]init] atIndex:0];
    ImageURLs= [[NSMutableArray alloc]init];
    InsideUserResizableView=[[NSMutableArray alloc]init];
    CGRectsOfSPUserResizableViews=[[NSMutableDictionary alloc]init ];
    CurrentInput=[[NSMutableArray alloc]init];
}

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


-(void)viewDidAppear:(BOOL)animated
{
    currentBoradView = [myPageScrollView.scrollView.subviews objectAtIndex:currentNum];
    if(backsignal == BACKfromCHOOSE){
        
        if( SelectedString!=nil)
        {
            [ImageURLs addObject:SelectedString];
            CGRect gripFrame = CGRectMake(50, 50, 200, 200);
            SPUserResizableView *userResizableView = [[SPUserResizableView alloc] initWithFrame:gripFrame];
            UIImageView *contentView = [[UIImageView alloc] initWithFrame:gripFrame];
            [contentView setImage: [UIImage imageWithContentsOfFile:SelectedString]];
            userResizableView.contentView = contentView;
            [userResizableView setFrame:CGRectMake(100, 0, 100,230)];
            userResizableView.delegate = self;
            userResizableView.tag=TheTag++;
            [userResizableView showEditingHandles];
            currentlyEditingView = userResizableView;
            lastEditedView = userResizableView;
            [currentBoradView addSubview:userResizableView];
//            [InsideUserResizableView addObject:userResizableView];
            [[AllInsideUserResizableView objectAtIndex:currentNum] addObject: userResizableView];
            [CGRectsOfSPUserResizableViews setObject:[NSValue valueWithCGRect: CGRectMake(userResizableView.frame.origin.x, userResizableView.frame.origin.y, userResizableView.frame.size.width, userResizableView.frame.size.height)]  forKey:[NSNumber numberWithInt: userResizableView.tag]];
            [InsideImageViews addObject:contentView];
       }
    }
    
    if(backsignal == BACKfromWrite)
    {
        if(CurrentInput!=nil)
        {        
            CGRect gripFrame = CGRectMake(50, 50, 150, 30);            
            SPUserResizableView *userResizableView = [[SPUserResizableView alloc] initWithFrame:gripFrame];            
            VerticallyAlignedLabel *contentView = [[VerticallyAlignedLabel alloc] initWithFrame:gripFrame];            
            contentView.lineBreakMode=UILineBreakModeCharacterWrap;
            contentView.font = [UIFont boldSystemFontOfSize:20.0f];
            contentView.numberOfLines = 0;            
            contentView.backgroundColor= [UIColor orangeColor];            
            [contentView setVerticalAlignment:VerticalAlignmentTop];            
            [contentView setText:CurrentInput];            
            userResizableView.contentView = contentView;            
            [userResizableView setFrame:CGRectMake(100, 100, 150,80)];            
            userResizableView.delegate = self;
            userResizableView.tag=TheTag++;     
            [userResizableView showEditingHandles];
            currentlyEditingView = userResizableView;
            lastEditedView = userResizableView;            
            [currentBoradView addSubview:userResizableView];
            [InsideImageViews addObject:contentView];
            [[AllInsideUserResizableView objectAtIndex:currentNum] addObject: userResizableView];
            
            [CGRectsOfSPUserResizableViews setObject:[NSValue valueWithCGRect: CGRectMake(userResizableView.frame.origin.x, userResizableView.frame.origin.y, userResizableView.frame.size.width, userResizableView.frame.size.height)]  forKey:[NSNumber numberWithInt: userResizableView.tag]];
        }
    }
}

- (void)userResizableViewDidBeginEditing:(SPUserResizableView *)userResizableView {
    [currentlyEditingView hideEditingHandles];
    currentlyEditingView = userResizableView;
}

- (void)userResizableViewDidEndEditing:(SPUserResizableView *)userResizableView {
    lastEditedView = userResizableView;
        
    [CGRectsOfSPUserResizableViews setObject:[NSValue valueWithCGRect: CGRectMake(userResizableView.frame.origin.x, userResizableView.frame.origin.y, userResizableView.frame.size.width, userResizableView.frame.size.height)]  forKey:[NSNumber numberWithInt: userResizableView.tag]];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([currentlyEditingView hitTest:[touch locationInView:currentlyEditingView] withEvent:nil]) {
        
        return NO;
    }
    return YES;
}

- (void)hideEditingHandles {
    // We only want the gesture recognizer to end the editing session on the last
    // edited view. We wouldn't want to dismiss an editing session in progress.
    [lastEditedView hideEditingHandles];
}

- (UIImage *)addImages:(NSMutableArray *) InsideUserResizableViews {  
   
    UIGraphicsBeginImageContext(CGSizeMake(300, 240)); 
    [currentBoradView drawRect:CGRectMake(currentBoradView.bounds.origin.x, currentBoradView.bounds.origin.y, currentBoradView.bounds.size.width, currentBoradView.bounds.size.height)];
    for (SPUserResizableView *currentImageview in InsideUserResizableViews) 
    {
        if ([currentImageview.contentView isMemberOfClass:[UIImageView class]] ) {
          
            CurrentImageView=  currentImageview.contentView;
            NSValue *CurrentValue=   [CGRectsOfSPUserResizableViews objectForKey:[NSNumber numberWithInt: currentImageview.tag]];            
            CGRect currentCGRect= [CurrentValue CGRectValue];             
            [CurrentImageView.image drawInRect:CGRectMake(currentCGRect.origin.x, currentCGRect.origin.y, currentCGRect.size.width, currentCGRect.size.height)];
       
        }else if ([currentImageview.contentView isMemberOfClass:[VerticallyAlignedLabel class]] ){
            
            UILabel *CurrentLabel =  currentImageview.contentView;
            NSValue *CurrentValue=   [CGRectsOfSPUserResizableViews objectForKey:[NSNumber numberWithInt: currentImageview.tag]];            
            CGRect currentCGRect= [CurrentValue CGRectValue];                       
            UIFont *font = [UIFont boldSystemFontOfSize:22.0f];           
            [CurrentLabel.text drawInRect:currentCGRect withFont:font lineBreakMode:UILineBreakModeCharacterWrap alignment:UITextAlignmentLeft];
        }   
    }
    UIImage *resultingImage = UIGraphicsGetImageFromCurrentImageContext();      
    UIGraphicsEndImageContext();  
    return resultingImage;  
}  

- (IBAction)ToPreview:(id)sender 
{

    mTempImageView = [[TempImageView alloc] init];
    
    for (NSInteger i=0; i<myPageScrollView.scrollView.subviews.count; i++) {
        
        CGRect outsideImageFrame=CGRectMake(0, 10+280*i, 320, 280);
        UIImageView *outsideImageview =[[UIImageView alloc]initWithFrame:outsideImageFrame];
        outsideImageview.backgroundColor = [UIColor yellowColor];
        CGRect imageFrame=CGRectMake(10, 20+260*i, 300, 260);
        UIImageView *finishedImageView =[[UIImageView alloc]initWithFrame:imageFrame];
        if (InsideImageViews.count>0) 
        {
            for (NSInteger n=0; n<((NSMutableArray *)[AllInsideUserResizableView objectAtIndex:i]).count; n++) 
            {
                 [finishedImageView setImage: [self addImages:[AllInsideUserResizableView objectAtIndex:i]] ];
            }
        }else 
        {
            [finishedImageView setBackgroundColor:[UIColor redColor]];
        }
        [finishedImageView setBackgroundColor:[UIColor redColor]];
    
        [myPreviewViewContorller.scrollview insertSubview:finishedImageView atIndex:currentNum];
        
        
        
        [mTempImageView insertImage:finishedImageView.image ];
        
        myPreviewViewContorller.scrollview.contentSize =CGSizeMake(myPreviewViewContorller.view.frame.size.width, myPreviewViewContorller.view.frame.size.height*(i+1)); 
    }
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd  target:self action:@selector(selectRightAction:)];  
    myPreviewViewContorller.navigationItem.rightBarButtonItem=rightButton;
    myPreviewViewContorller.imageToUpload.image= mTempImageView.mImage;
    
    [self.navigationController pushViewController:myPreviewViewContorller animated:YES];
    
     self.backsignal=self.BACKfromNAVIGATION;
}

- (void) selectRightAction:(id)sender
{
    [self initSinaWeibo]; 
    if([sinaweibo isAuthValid]){
        [self postImageStatusButtonPressed];
    }else{
        [self loginButtonPressed ];  
    }
}

- (void) initSinaWeibo
{
    sinaweibo = [[SinaWeibo alloc] initWithAppKey:kAppKey appSecret:kAppSecret appRedirectURI:kAppRedirectURI andDelegate:self];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *sinaweiboInfo = [defaults objectForKey:@"SinaWeiboAuthData"];
    if ([sinaweiboInfo objectForKey:@"AccessTokenKey"] && [sinaweiboInfo objectForKey:@"ExpirationDateKey"] && [sinaweiboInfo objectForKey:@"UserIDKey"])
    {
        sinaweibo.accessToken = [sinaweiboInfo objectForKey:@"AccessTokenKey"];
        sinaweibo.expirationDate = [sinaweiboInfo objectForKey:@"ExpirationDateKey"];
        sinaweibo.userID = [sinaweiboInfo objectForKey:@"UserIDKey"];
    }    
    
}

- (IBAction)addNewPage:(id)sender 
{    
    [self.myPageScrollView addIndexAtPageControl];
    
    self.myPageScrollView.scrollView.contentSize=CGSizeMake(myPageScrollView.frame.size.width*myPageScrollView.pageControl.numberOfPages,myPageScrollView.frame.size.height);
    
    //添加一个新的boraderView到scrollview里面
    CGRect gripFrame = CGRectMake(10+myPageScrollView.scrollView.bounds.size.width*(currentNum+1), 30, 300, 260);
    UIView *boradview =[[UIView  alloc] initWithFrame:gripFrame];
    if(myPageScrollView.pageControl.numberOfPages%2==0)
    {
        boradview.backgroundColor=[UIColor greenColor];
    }else 
    {
        boradview.backgroundColor=[UIColor redColor];
    }
    
    if (currentNum<myPageScrollView.scrollView.subviews.count-1) 
    {
        [self.boraderViews insertObject:boradview atIndex:currentNum+1];
        [self swapScrollViewsSubviewsToAfter:currentNum With:myPageScrollView.scrollView.subviews.count inScrollViewsSubviews:myPageScrollView.scrollView.subviews];
        [self.myPageScrollView.scrollView insertSubview:boradview atIndex:currentNum+1];
    }else 
    {
        [self.boraderViews insertObject:boradview atIndex:currentNum+1];
        [self.myPageScrollView.scrollView insertSubview:boradview atIndex:currentNum+1];
    }
    
    self.myPageScrollView.pageControl.currentPage=currentNum+1;
    [self.myPageScrollView.pageControl updateCurrentPageDisplay];
    //移动到那个页面
    currentNum++;
    currentBoradView = [myPageScrollView.scrollView.subviews objectAtIndex:currentNum];
    [self.myPageScrollView.scrollView scrollRectToVisible:gripFrame animated:YES];
    
    [AllInsideUserResizableView insertObject:[[NSMutableArray alloc]init] atIndex:currentNum];
    
}


- (IBAction)removeCurrentPage:(id)sender
{
    [AllInsideUserResizableView removeObjectAtIndex:currentNum];
    if(myPageScrollView.pageControl.numberOfPages==1)
    {
           return;
    }
    if(currentNum<self.myPageScrollView.scrollView.subviews.count-1)
    {
        [(UIView *)[myPageScrollView.scrollView.subviews objectAtIndex:currentNum] removeFromSuperview]; 
        [self swapScrollViewsSubviewsToPre:currentNum With :myPageScrollView.scrollView.subviews.count
                inScrollViewsSubviews:myPageScrollView.scrollView.subviews];
    }else {
          [(UIView *)[myPageScrollView.scrollView.subviews objectAtIndex:currentNum] removeFromSuperview]; 
    }
    if(currentNum == self.myPageScrollView.pageControl.numberOfPages-1)
    {
        currentNum--;
    }

    [self.myPageScrollView removeIndexAtPageControl];
     self.myPageScrollView.scrollView.contentSize=CGSizeMake(myPageScrollView.frame.size.width*myPageScrollView.pageControl.numberOfPages,myPageScrollView.frame.size.height);
    currentBoradView = [myPageScrollView.scrollView.subviews objectAtIndex:currentNum];
}



- (void) scrollViewDidScroll:(UIScrollView *)scrollView
{
      
    CGFloat pageWidth = scrollView.frame.size.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    currentNum=page;
    NSLog( [NSString stringWithFormat:@"%d", currentNum]);
    currentBoradView = [myPageScrollView.scrollView.subviews objectAtIndex:page];
    myPageScrollView.pageControl.currentPage = page;
}

- (void) swapScrollViewsSubviewsToPre:(NSInteger )num  With :(NSInteger )sum  inScrollViewsSubviews :(NSMutableArray *)Subviews
{
   for (NSInteger i=num; i<sum; i++) 
    {
        CGRect newFrame = CGRectOffset(((UIView *)[myPageScrollView.scrollView.subviews objectAtIndex:i]).frame, -320, 0);
        ((UIView *)[myPageScrollView.scrollView.subviews objectAtIndex:i]).frame=newFrame;
    }
    

}




- (void) swapScrollViewsSubviewsToAfter:(NSInteger )curnum  With :(NSInteger )sum  inScrollViewsSubviews :(NSMutableArray *)Subviews
{
    for (NSInteger i=sum-1; i>curnum; i--) 
    {
        CGRect newFrame = CGRectOffset(((UIView *)[myPageScrollView.scrollView.subviews objectAtIndex:i]).frame, +320, 0);
        ((UIView *)[myPageScrollView.scrollView.subviews objectAtIndex:i]).frame=newFrame;
        [Subviews replaceObjectAtIndex:i withObject: [Subviews objectAtIndex:i-1]];
    }
}


- (void)removeAuthData
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SinaWeiboAuthData"];
}

#pragma mark  setting sinaweibo
- (void)storeAuthData
{
//    SinaWeibo *sinaweibo =sinaweibo;
    
    NSDictionary *authData = [NSDictionary dictionaryWithObjectsAndKeys:
                              sinaweibo.accessToken, @"AccessTokenKey",
                              sinaweibo.expirationDate, @"ExpirationDateKey",
                              sinaweibo.userID, @"UserIDKey",
                              sinaweibo.refreshToken, @"refresh_token", nil];
    [[NSUserDefaults standardUserDefaults] setObject:authData forKey:@"SinaWeiboAuthData"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loginButtonPressed
{
    [sinaweibo logIn];
}

static int post_status_times = 0;
- (void)postStatusButtonPressed
{
    if (!postStatusText)
    {
        post_status_times ++;
        postStatusText = nil;
        postStatusText = [[NSString alloc] initWithFormat:@"test post status : %i %@", post_status_times, [NSDate date]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:[NSString stringWithFormat:@"Will post status with text \"%@\"", postStatusText]
                                                       delegate:self cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    alertView.tag = 0;
    [alertView show];
}

static int post_image_status_times = 0;
- (void)postImageStatusButtonPressed
{
    if (!postImageStatusText)
    {
        post_image_status_times ++;
        postImageStatusText = nil;
        postImageStatusText = [[NSString alloc] initWithFormat:@"test post image status : %i %@", post_image_status_times, [NSDate date]];
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                        message:[NSString stringWithFormat:@"Will post image status with text \"%@\"", postImageStatusText]
                                                       delegate:self cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"OK", nil];
    alertView.tag = 1;
    [alertView show];
}


- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if (alertView.tag == 0)
        {
            [sinaweibo requestWithURL:@"statuses/update.json"
                               params:[NSMutableDictionary dictionaryWithObjectsAndKeys:postStatusText, @"status", nil]
                           httpMethod:@"POST"
                             delegate:self];
            
        }
        else if (alertView.tag == 1)
        {
            [sinaweibo requestWithURL:@"statuses/upload.json"
                               params:[NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       postImageStatusText, @"status",
                                       myPreviewViewContorller.imageToUpload.image, @"pic", nil]
                           httpMethod:@"POST"
                             delegate:self];
        }
    }
}






#pragma mark - SinaWeibo Delegate

- (void)sinaweiboDidLogIn:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogIn userID = %@ accesstoken = %@ expirationDate = %@ refresh_token = %@", sinaweibo.userID, sinaweibo.accessToken, sinaweibo.expirationDate,sinaweibo.refreshToken);
    [self storeAuthData];
}

- (void)sinaweiboDidLogOut:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboDidLogOut");
    [self removeAuthData];
}

- (void)sinaweiboLogInDidCancel:(SinaWeibo *)sinaweibo
{
    NSLog(@"sinaweiboLogInDidCancel");
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo logInDidFailWithError:(NSError *)error
{
    NSLog(@"sinaweibo logInDidFailWithError %@", error);
}

- (void)sinaweibo:(SinaWeibo *)sinaweibo accessTokenInvalidOrExpired:(NSError *)error
{
    NSLog(@"sinaweiboAccessTokenInvalidOrExpired %@", error);
    [self removeAuthData];
}


#pragma mark - SinaWeiboRequest Delegate 

- (void)request:(SinaWeiboRequest *)request didFailWithError:(NSError *)error
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
       userInfo = nil;
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {      
        statuses = nil;
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" failed!", nil]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
        
        NSLog(@"Post status failed with error : %@", error);
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" failed!", nil]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
     
        
        NSLog(@"Post image status failed with error : %@", error);
    }
    
    

}

- (void)request:(SinaWeiboRequest *)request didFinishLoadingWithResult:(id)result
{
    if ([request.url hasSuffix:@"users/show.json"])
    {
   
        userInfo = result;
    }
    else if ([request.url hasSuffix:@"statuses/user_timeline.json"])
    {
       
        statuses = [result objectForKey:@"statuses"];
    }
    else if ([request.url hasSuffix:@"statuses/update.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
         postStatusText = nil;
    }
    else if ([request.url hasSuffix:@"statuses/upload.json"])
    {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Alert"
                                                            message:[NSString stringWithFormat:@"Post image status \"%@\" succeed!", [result objectForKey:@"text"]]
                                                           delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
        [alertView show];
         postImageStatusText = nil;
    }
    
}

- (UIImage *)reSizeImage:(UIImage *)image toSize:(CGSize)reSize

{
    UIGraphicsBeginImageContext(CGSizeMake(reSize.width, reSize.height));
    [image drawInRect:CGRectMake(0, 0, reSize.width, reSize.height)];
    UIImage *reSizeImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return reSizeImage;
    
}


- (void) showLeft
{
    TableViewController *c = [[TableViewController alloc] initWithStyleAndDrawSomething:UITableViewStylePlain with:self];
    c.view.backgroundColor=[UIColor darkGrayColor];
    c.tableView.rowHeight=100;
    c.tableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;

    
    if (NO)
        [self.revealSideViewController pushViewController:c onDirection:PPRevealSideDirectionLeft withOffset:_offset animated:_animated completion:^{
            PPRSLog(@"This is the end!");
        }];
    else // NB: we could have use directly completion method with nil parameter, but I just want to make sure the app is working without using it (pseudo regression test)
        [self.revealSideViewController pushViewController:c onDirection:PPRevealSideDirectionLeft withOffset:_offset animated:_animated];
    
    PP_RELEASE(c);
}


@end
