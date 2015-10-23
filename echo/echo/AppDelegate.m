//
//  AppDelegate.m
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import "AppDelegate.h"
#import "Constants.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize currentUser = _currentUser;


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // App version
    NSString * version = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleShortVersionString"];
    NSLog(@"App Version: %@", version);
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    // An existing user is saved
    if(!launchOptions) {
        if([[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_CURRENT_USER]) {
            _currentUser = [UserDM loadCustomObjectWithKey:DEFAULT_CURRENT_USER];
            [self launchHomeScreen];
        }
        else {
            _currentUser = [[UserDM alloc] init];
            
            // Show the login screen
            [self launchLoginScreen:NO];
        }
    }else {
        if([[NSUserDefaults standardUserDefaults] objectForKey:DEFAULT_CURRENT_USER]) {
            _currentUser = [UserDM loadCustomObjectWithKey:DEFAULT_CURRENT_USER];
        }else{
            _currentUser = [[UserDM alloc] init];
            // Show the login screen
            [self launchLoginScreen:NO];
        }
    }
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Accessors
-(QuestionViewController *)homePage{
    if(!_homePage){
        _homePage = [[QuestionViewController alloc] init];
    }
    return _homePage;
}

-(LoginViewController *)loginViewController{
    if(!_loginViewController){
        _loginViewController = [[LoginViewController alloc] init];
    }
    return _loginViewController;
}

-(LogoutViewController *)logoutPage{
    if(!_logoutPage){
        _logoutPage = [[LogoutViewController alloc] init];
    }
    return _logoutPage;
}

-(ThankYouViewController *)thankYouPage{
    if(!_thankYouPage){
        _thankYouPage = [[ThankYouViewController alloc] init];
    }
    return _thankYouPage;
}

-(LoadingViewController *)loadingPage{
    if(!_loadingPage){
        _loadingPage = [[LoadingViewController alloc] init];
    }
    return _loadingPage;
}

- (NSMutableArray *)questionArray {
    if(!_questionArray)
        _questionArray = [[NSMutableArray alloc] init];
    return _questionArray;
}

#pragma mark - Methods
-(BOOL)reachable
{
    struct hostent *hostinfo;
    hostinfo = gethostbyname ("sp-echo-app.herokuapp.com");
    if (hostinfo == NULL){
        return NO;
    }
    else{
        return YES;
    }
}

-(void)launchHomeScreen{
   self.window.rootViewController = self.homePage;
}

-(void)launchLoginScreen:(BOOL)animated{
    self.window.rootViewController = self.loginViewController;
}

-(void)launchLoadingScreen{
    self.window.rootViewController = self.loadingPage;
}

-(void)launchThankYouScreen{
    self.window.rootViewController = self.thankYouPage;
}

- (void)logoutUser
{
    
    // Reset current user
    _currentUser = nil;
    _currentUser = [[UserDM alloc] init];
    
    // Reset view controllers
    _loginViewController = nil;
    _homePage = nil;
    _thankYouPage = nil;
    _logoutPage = nil;
    _loadingPage = nil;
    
    // Clear Data
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:DEFAULT_CURRENT_USER];
    [self launchLoginScreen:YES];
}


@end
