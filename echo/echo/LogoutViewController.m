//
//  LogoutViewController.m
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import "LogoutViewController.h"
#import "AppDelegate.h"
#import "EchoAPI.h"
#import "Helpers.h"

@interface LogoutViewController ()
@property (strong, nonatomic) UIImageView *logoImageView;
@property (nonatomic, strong) UIButton *btnBack;
@property (nonatomic, strong) UILabel *lblLogout;
@property (nonatomic, strong) UITextField *txtEmail;
@property (nonatomic, strong) UITextField *txtPassword;
@property (nonatomic, strong) UIButton *btnLogout;
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) EchoAPI *echoAPI;

@end

@implementation LogoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:COLOR_THEME];
    [self.view addSubview:self.btnBack];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.lblLogout];
    [self.view addSubview:self.txtEmail];
    [self.view addSubview:self.txtPassword];
    [self.view addSubview:self.btnLogout];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _echoAPI = [[EchoAPI alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessor
-(UIButton*)btnBack{
    if(!_btnBack){
        _btnBack = [[UIButton alloc] initWithFrame:CGRectMake(30, 30, 50, 50)];
        [_btnBack setImage:[UIImage imageNamed:@"backbutton.png"] forState:UIControlStateNormal];
        [_btnBack addTarget:self action:@selector(backButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBack;
}

-(UIImageView *)logoImageView{
    if(!_logoImageView){
        UIImage *logo = [UIImage imageNamed:@"logo_echo.png"];
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2) - (logo.size.width/2), 100, 466, 193)];
        _logoImageView.image = logo;
    }
    return _logoImageView;
}

-(UILabel*)lblLogout{
    if(!_lblLogout){
        _lblLogout = [[UILabel alloc]initWithFrame:CGRectMake(200, _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 100, self.view.frame.size.width - 400, 30)];
        _lblLogout.textAlignment = NSTextAlignmentCenter;
        _lblLogout.text = @"LOG OUT";
        _lblLogout.font = FONT_BOLD_20;
        _lblLogout.backgroundColor = [UIColor clearColor];
    }
    return _lblLogout;
}

- (UITextField *)txtEmail {
    if (!_txtEmail) {
        _txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(300, _lblLogout.frame.origin.y + _lblLogout.frame.size.height + 20, self.view.frame.size.width - 600, 30)];
        _txtEmail.textColor = [UIColor blackColor];
        _txtEmail.placeholder = @"Email";
        [_txtEmail setFont:FONT_NORMAL_16];
        _txtEmail.backgroundColor = [UIColor whiteColor];
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        _txtEmail.leftView = paddingView;
        _txtEmail.leftViewMode = UITextFieldViewModeAlways;
        _txtEmail.returnKeyType = UIReturnKeyNext;
        [_txtEmail becomeFirstResponder];
        _txtEmail.delegate = self;
        _txtEmail.tag = 1;
        _txtEmail.autocapitalizationType = UITextAutocapitalizationTypeNone;
    }
    
    return _txtEmail;
}

- (UITextField *)txtPassword {
    if (!_txtPassword) {
        _txtPassword = [[UITextField alloc] initWithFrame:CGRectMake(_txtEmail.frame.origin.x, _txtEmail.frame.origin.y + _txtEmail.frame.size.height + 20, _txtEmail.frame.size.width, _txtEmail.frame.size.height)];
        _txtPassword.textColor = [UIColor blackColor];
        _txtPassword.placeholder = @"Password";
        _txtPassword.secureTextEntry = YES;
        [_txtPassword setFont:FONT_NORMAL_16];
        _txtPassword.backgroundColor = [UIColor whiteColor];
        _txtPassword.returnKeyType = UIReturnKeyDone;
        _txtPassword.delegate = self;
        _txtPassword.tag = 2;
        
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
        _txtPassword.leftView = paddingView;
        _txtPassword.leftViewMode = UITextFieldViewModeAlways;
    }
    
    return _txtPassword;
}

-(UIButton*)btnLogout{
    if(!_btnLogout){
        _btnLogout = [[UIButton alloc] initWithFrame:CGRectMake(_txtPassword.frame.origin.x + 20, _txtPassword.frame.origin.y + _txtPassword.frame.size.height + 20, _txtPassword.frame.size.width -40, 40)];
        _btnLogout.backgroundColor = [UIColor blackColor];
        [_btnLogout setTitle:@"LOG OUT" forState:UIControlStateNormal];
        [_btnLogout setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnLogout.titleLabel.font = FONT_NORMAL_16;
        _btnLogout.layer.cornerRadius = 5.0f;
        [_btnLogout addTarget:self action:@selector(logoutButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLogout;
}

# pragma mark - Hide Keyboard
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField.tag==1) {
        [_txtPassword becomeFirstResponder];
    }else {
        [_txtPassword resignFirstResponder];
        [self logoutButtonAction:nil];
    }
    return YES;
}

#pragma mark - Button Actions
-(void)logoutButtonAction:(id)sender {
    NSString *email  = [_txtEmail.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *password = [_txtPassword.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
    // Validate the fields
    if(email.length==0 || password.length==0)
    {
        [Helpers alertStatus:@"All fields are required." :@"" :0];
    }else{
        UserDM *user = [[UserDM alloc] init];
        user.email = email;
        user.password = password;
        
        [self signOutUser:user];
    }
}

-(void)backButtonAction:(id)sender{
    [_appDelegate launchHomeScreen];
}

#pragma mark - Methods
-(void)signOutUser:(UserDM*)user{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:user.email forKey:KEY_USER_EMAIL];
    [params setObject:user.password forKey:KEY_USER_PASSWORD];
    [_echoAPI signOutUser:params];
}

@end
