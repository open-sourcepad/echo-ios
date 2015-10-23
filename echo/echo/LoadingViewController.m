//
//  LoadingViewController.m
//  echo
//
//  Created by Ayra Panganiban on 10/24/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import "LoadingViewController.h"
#import "Constants.h"

@interface LoadingViewController ()
@property (nonatomic, strong) FLAnimatedImageView *loaderView;
@end

@implementation LoadingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:COLOR_LOADER];
    [self.view addSubview:self.loaderView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(FLAnimatedImageView*)loaderView{
    if(!_loaderView){
        if (!_loaderView) {
            _loaderView = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
            _loaderView.center = self.view.center;
            _loaderView.contentMode = UIViewContentModeScaleAspectFill;
            _loaderView.clipsToBounds = YES;
            NSURL *url = [[NSBundle mainBundle] URLForResource:@"echo_loading" withExtension:@"gif"];
            NSData *data = [NSData dataWithContentsOfURL:url];
            FLAnimatedImage *animatedImage1 = [FLAnimatedImage animatedImageWithGIFData:data];
            self.loaderView.animatedImage = animatedImage1;
        }
    }
    return _loaderView;
}
@end
