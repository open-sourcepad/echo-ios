//
//  AppDelegate.h
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserDM.h"
#import "LoginViewController.h"
#import "QuestionViewController.h"
#import "ThankYouViewController.h"
#import "LogoutViewController.h"
#import "LoadingViewController.h"
#include<unistd.h>
#include<netdb.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

#pragma mark - Model
@property (strong, nonatomic) UserDM *currentUser;
@property (strong, nonatomic) NSMutableArray *questionArray;

#pragma mark - Controllers
@property (strong, nonatomic) LoginViewController *loginViewController;
@property (strong, nonatomic) QuestionViewController *homePage;
@property (strong, nonatomic) ThankYouViewController *thankYouPage;
@property (strong, nonatomic) LogoutViewController *logoutPage;
@property (strong, nonatomic) LoadingViewController *loadingPage;

#pragma mark - Public Methods
- (void)launchHomeScreen;
- (void)launchLoginScreen:(BOOL)animated;
- (void)logoutUser;
- (void)launchLoadingScreen;
- (void)launchThankYouScreen;

@property (nonatomic) BOOL reachable;
@end

