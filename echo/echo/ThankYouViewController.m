//
//  ThankYouViewController.m
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import "ThankYouViewController.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "EchoAPI.h"

@interface ThankYouViewController ()
@property (strong, nonatomic) UIImageView *imageView;
@property (strong, nonatomic) AppDelegate *appDelegate;
@end

@implementation ThankYouViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [self.view setBackgroundColor:COLOR_THEME];
    [self.view addSubview:self.imageView];
    [self.navigationController.navigationBar setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self performSelector:@selector(goBackToHome) withObject:nil afterDelay:2];
}

#pragma mark - Methods
- (UIImageView*)imageView{
    if(!_imageView){
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width - 400, 89)];
        _imageView.center = self.view.center;
        _imageView.image = [UIImage imageNamed:@"echo_thankyou.png"];
    }
    return _imageView;
}

-(void)goBackToHome{
    [_appDelegate launchHomeScreen];
}
@end
