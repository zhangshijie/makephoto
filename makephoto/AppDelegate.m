//
//  AppDelegate.m
//  makephoto
//
//  Created by 张 世杰 on 12-11-25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "sqlite3.h"
#import "FMDatabase.h"

@implementation AppDelegate

@synthesize window = _window,revealSideViewController=_revealSideViewController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    NSString *DB=[self readyDB:@"photosay"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;  

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"MainStoryboard"bundle:nil];
    DrawSomethingViewController *main = [storyboard instantiateViewControllerWithIdentifier:@"nc"];

    UINavigationController *nav = [[UINavigationController alloc] init];
    [nav pushViewController:main animated:YES];
    _revealSideViewController = [[PPRevealSideViewController alloc] initWithRootViewController:nav];  

    _revealSideViewController.delegate = self;
    [_revealSideViewController unloadViewControllerForSide:PPRevealSideDirectionRight];
    self.window.rootViewController = _revealSideViewController;  
    
    PP_RELEASE(main);  
    PP_RELEASE(nav);  

    self.window.backgroundColor = [UIColor whiteColor];  
    [self.window makeKeyAndVisible];  

    
   
    return YES;
}

#pragma mark - UIApplicationDelegate methods

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Unloading tests

- (void) unloadRevealFromMemory
{
    self.revealSideViewController = nil;
    self.window.rootViewController = nil;
}


#pragma mark - PPRevealSideViewController delegate

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller willPushController:(UIViewController *)pushedController {
    PPRSLog(@"%@", pushedController);
}

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller didPushController:(UIViewController *)pushedController {
    PPRSLog(@"%@", pushedController);
}

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller willPopToController:(UIViewController *)centerController {
    PPRSLog(@"%@", centerController);
}

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller didPopToController:(UIViewController *)centerController {
    PPRSLog(@"%@", centerController);
}

- (void) pprevealSideViewController:(PPRevealSideViewController *)controller didChangeCenterController:(UIViewController *)newCenterController {
    PPRSLog(@"%@", newCenterController);
}

- (BOOL) pprevealSideViewController:(PPRevealSideViewController *)controller shouldDeactivateDirectionGesture:(UIGestureRecognizer*)gesture forView:(UIView*)view {
    return NO;    
}

- (PPRevealSideDirection)pprevealSideViewController:(PPRevealSideViewController*)controller directionsAllowedForPanningOnView:(UIView*)view {
    
    if ([view isKindOfClass:NSClassFromString(@"UIWebBrowserView")]) return PPRevealSideDirectionLeft | PPRevealSideDirectionRight;
    
    return PPRevealSideDirectionLeft | PPRevealSideDirectionRight | PPRevealSideDirectionTop | PPRevealSideDirectionBottom;
}





-(NSString *) readyDB:(NSString *)dbName{
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    
    NSArray *paths=NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirtory=[paths objectAtIndex:0];
    
    NSString *writableDBPath=[documentsDirtory stringByAppendingPathComponent:dbName];
    
    FMDatabase *db=[FMDatabase databaseWithPath:writableDBPath];
    
    if(![db open]){
        
        NSLog(@"could not open db,create now!");
    
        return ;
               
    }else{
        NSLog(@"create already!");
    }
    
    [self InsertPhotosFromProject:14 withDocumentDirtory :documentsDirtory];
        
    return writableDBPath;
    
}


-(void ) InsertPhotosFromProject:(NSInteger ) mount withDocumentDirtory:(NSString *)documentsDirtory
{
    for (int i=1; i<mount; i++) 
    {
    
    //            UIImage *imagetest=[UIImage imageNamed:[NSString stringWithFormat:@"%d",i]];
    
        NSString *uniquePath=[documentsDirtory stringByAppendingPathComponent:[[NSString stringWithFormat:@"%d",i] stringByAppendingString:@".jpg"]];  
    
        BOOL blHave =[[NSFileManager defaultManager]fileExistsAtPath:uniquePath];
        
        if(blHave)
        {
            NSLog(@"already have");
            return;
        }
        
        NSString *strPathOld =[[NSBundle mainBundle]pathForResource:[NSString stringWithFormat:@"%d",i] ofType:@"jpg"];
    
        NSData *data=[NSData dataWithContentsOfFile:strPathOld];
    
        if([data writeToFile:uniquePath atomically:YES]){
        
            NSLog(@"success to write!");
        
        }else{
        
            NSLog(@"fail to write!");
        }    
    }
}

@end
