//
//  QuestionViewController.m
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import "QuestionViewController.h"
#import "Constants.h"
#import "EchoAPI.h"
#import "AppDelegate.h"
#import "QuestionDM.h"

@interface QuestionViewController ()
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) EchoAPI *echoAPI;
@property (nonatomic, strong) UILabel *lblQuestion;
@property (nonatomic, strong) UIButton *answer1;
@property (nonatomic, strong) UIButton *answer2;
@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _echoAPI = [[EchoAPI alloc]init];

    [self.view setBackgroundColor:COLOR_THEME];
    [self.view addSubview:self.lblQuestion];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [self getQuestion];
}

#pragma mark - Accessor
-(UILabel*)lblQuestion{
    if(!_lblQuestion){
        _lblQuestion = [[UILabel alloc]initWithFrame:CGRectMake(200, 200, self.view.frame.size.width - 400, 50)];
        _lblQuestion.textAlignment = NSTextAlignmentCenter;
        _lblQuestion.font = FONT_BOLD_40;
        _lblQuestion.backgroundColor = [UIColor clearColor];
    }
    return _lblQuestion;
}

#pragma mark - Methods 
-(void)getQuestion{
    [_echoAPI getQuestions:^ (NSDictionary *response)
     {
         [_appDelegate.questionArray removeAllObjects];
         [_appDelegate.questionArray addObjectsFromArray:[NSMutableArray arrayWithArray:[QuestionDM getVenuesFrom:[response objectForKey:KEY_DATA]]]];
         dispatch_async(dispatch_get_main_queue(), ^{
             if(_refreshControl.refreshing)
                 [self performSelector:@selector(stopRefresh:) withObject:_refreshControl afterDelay:REFRESH_END_DELAY];
             _gridLoaded = YES;
             [self.collectionView reloadData];
             [self.activityIndicator stopAnimating];
             [self.view setUserInteractionEnabled:YES];
         });
     }];

}

-(void)loadVenues{
    _gridLoaded = YES;
    [_urbnEye getGridVenues:_pageGrid+1 completion:^ (NSDictionary *response)
     {
         [_appDelegate.venues removeAllObjects];
         [_appDelegate.venues addObjectsFromArray:[NSMutableArray arrayWithArray:[VenueDM getVenuesFrom:[response objectForKey:KEY_DATA]]]];
         dispatch_async(dispatch_get_main_queue(), ^{
             if(_refreshControl.refreshing)
                 [self performSelector:@selector(stopRefresh:) withObject:_refreshControl afterDelay:REFRESH_END_DELAY];
             _gridLoaded = YES;
             [self.collectionView reloadData];
             [self.activityIndicator stopAnimating];
             [self.view setUserInteractionEnabled:YES];
         });
     }];
}

@end
