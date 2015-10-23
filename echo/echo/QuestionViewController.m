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
#import <SDWebImage/UIImageView+WebCache.h>

@interface QuestionViewController ()
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) EchoAPI *echoAPI;
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) UILabel *lblQuestion;
@property (nonatomic, strong) UIView *twoAnsView;
@property (nonatomic, strong) UIView *threeAnsView;
@property (nonatomic, strong) UIButton *answer1;
@property (nonatomic, strong) UIButton *answer2;
@property (nonatomic, strong) UIButton *answer3;
@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _echoAPI = [[EchoAPI alloc]init];

    [self.view setBackgroundColor:COLOR_THEME];
    [self.view addSubview:self.activityIndicator];
    [self.view addSubview:self.lblQuestion];
    
    UISwipeGestureRecognizer *swipeLeft = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipeLeft:)];
    swipeLeft.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:swipeLeft];
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

-(UIView*)twoAnsView{
    if(!_twoAnsView){
        _twoAnsView = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2) - 225, _lblQuestion.frame.origin.y + _lblQuestion.frame.size.height + 50, 450, self.view.frame.size.height/2)];
        [_twoAnsView setBackgroundColor:[UIColor clearColor]];
        [_twoAnsView addSubview:self.answer1];
        [_twoAnsView addSubview:self.answer2];
    }
    return _twoAnsView;
}

-(UIView*)threeAnsView{
    if(!_threeAnsView){
        _threeAnsView = [[UIView alloc]initWithFrame:CGRectMake((self.view.frame.size.width/2) - 350, _lblQuestion.frame.origin.y + _lblQuestion.frame.size.height + 50, 700, self.view.frame.size.height/2)];
        [_threeAnsView setBackgroundColor:[UIColor clearColor]];
        [_threeAnsView addSubview:self.answer1];
        [_threeAnsView addSubview:self.answer2];
        [_threeAnsView addSubview:self.answer3];
    }
    return _threeAnsView;
}

- (UIActivityIndicatorView *)activityIndicator {
    if(!_activityIndicator) {
        _activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        _activityIndicator.color = [UIColor whiteColor];
        _activityIndicator.center = self.view.center;
        _activityIndicator.hidesWhenStopped = YES;
    }
    return _activityIndicator;
}

-(UIButton*)answer1{
    if(!_answer1){
        _answer1 = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
        _answer1.backgroundColor = [UIColor whiteColor];
        _answer1.clipsToBounds = YES;
        _answer1.layer.cornerRadius = 200/2;
        _answer1.layer.borderColor = [UIColor blackColor].CGColor;
        _answer1.layer.borderWidth =1.0;
        [_answer1 addTarget:self
                     action:@selector(btnSubmitAction:)
           forControlEvents:UIControlEventTouchUpInside];

    }
    return _answer1;
    
}

-(UIButton*)answer2{
    if(!_answer2){
        _answer2 = [[UIButton alloc] initWithFrame:CGRectMake(_answer1.frame.origin.x + _answer1.frame.size.width + 50, _answer1.frame.origin.y, 200, 200)];
        _answer2.backgroundColor = [UIColor whiteColor];
        _answer2.clipsToBounds = YES;
        _answer2.layer.cornerRadius = 200/2;
        _answer2.layer.borderColor = [UIColor blackColor].CGColor;
        _answer2.layer.borderWidth =1.0;
        [_answer2 addTarget:self
                      action:@selector(btnSubmitAction:)
            forControlEvents:UIControlEventTouchUpInside];
    }
    return _answer2;
}

-(UIButton*)answer3{
    if(!_answer3){
        _answer3 = [[UIButton alloc] initWithFrame:CGRectMake(_answer2.frame.origin.x + _answer2.frame.size.width + 50, _answer2.frame.origin.y, 200, 200)];
        _answer3.backgroundColor = [UIColor whiteColor];
        _answer3.clipsToBounds = YES;
        _answer3.layer.cornerRadius = 200/2;
        _answer3.layer.borderColor = [UIColor blackColor].CGColor;
        _answer3.layer.borderWidth =1.0;
        [_answer3 addTarget:self
                     action:@selector(btnSubmitAction:)
           forControlEvents:UIControlEventTouchUpInside];

    }
    return _answer3;
}

#pragma mark - Methods 
-(void)getQuestion{
    [self.activityIndicator startAnimating];
    [_echoAPI getQuestions:^ (NSDictionary *response)
     {
         [_appDelegate.questionArray removeAllObjects];
         [_appDelegate.questionArray addObjectsFromArray:[QuestionDM getQuestionsFrom:[response objectForKey:KEY_DATA]]];
         dispatch_async(dispatch_get_main_queue(), ^{
             for(QuestionDM *question in _appDelegate.questionArray){
                [self.lblQuestion setText:question.questionDesc];
                 if([question.answerArray count] == 2){
                     [self.view addSubview:self.twoAnsView];
                     for(AnswerDM *answer in question.answerArray){
                         NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: answer.imageUrl]];
                         if(answer.positionID == 1){
                           [self.answer1 setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                            self.answer1.tag = answer.answerID;
                         }
                         if(answer.positionID == 2){
                            [self.answer2 setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                            self.answer2.tag = answer.answerID;
                         }
                     }
                     
                 }else if([question.answerArray count] == 3){
                     [self.view addSubview:self.threeAnsView];
                     for(AnswerDM *answer in question.answerArray){
                         NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: answer.imageUrl]];
                         if(answer.positionID == 1){
                             [self.answer1 setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                             self.answer1.tag = answer.answerID;
                         }
                         if(answer.positionID == 2){
                             [self.answer2 setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                             self.answer2.tag = answer.answerID;
                         }
                         if(answer.positionID == 3){
                             [self.answer3 setImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
                             self.answer3.tag = answer.answerID;
                         }
                     }
                     
                 }
             }
             [self.activityIndicator stopAnimating];
             [self.view setUserInteractionEnabled:YES];
         });
     }];
}

-(void)btnSubmitAction:(UIButton*)sender{
    UIButton *button = (UIButton *)sender;
    NSInteger tagValue = button.tag;
    NSLog(@"ACCESS %i", tagValue);
    [_appDelegate launchLoadingScreen];
    double delayInSeconds = 3.0;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        [_appDelegate launchThankYouScreen];
    });
    
    _echoAPI = [[EchoAPI alloc]init];
    [_echoAPI postAnswer:tagValue
              completion: ^ (NSDictionary *response)
     {}];
}

- (void)swipeLeft:(UISwipeGestureRecognizer *)swipeRecogniser
{
    [_appDelegate launchLogoutScreen];
}
@end
