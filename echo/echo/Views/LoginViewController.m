//
//  LoginViewController.m
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#import "LoginViewController.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "EchoAPI.h"
#import "Helpers.h"

@interface LoginViewController ()
@property (strong, nonatomic) UIImageView *logoImageView;
@property (nonatomic, strong) UILabel *lblLogin;
@property (nonatomic, strong) UITextField *txtEmail;
@property (nonatomic, strong) UITextField *txtPassword;
@property (nonatomic, strong) UIButton *btnLogin;
@property (strong, nonatomic) AppDelegate *appDelegate;
@property (strong, nonatomic) EchoAPI *echoAPI;
@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:COLOR_THEME];
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.lblLogin];
    [self.view addSubview:self.txtEmail];
    [self.view addSubview:self.txtPassword];
    [self.view addSubview:self.btnLogin];
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    _echoAPI = [[EchoAPI alloc]init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessor
-(UIImageView *)logoImageView{
    if(!_logoImageView){
        UIImage *logo = [UIImage imageNamed:@"logo_echo.png"];
        _logoImageView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width/2) - (logo.size.width/2), 100, 466, 193)];
        _logoImageView.image = logo;
    }
    return _logoImageView;
}

-(UILabel*)lblLogin{
    if(!_lblLogin){
        _lblLogin = [[UILabel alloc]initWithFrame:CGRectMake(200, _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 100, self.view.frame.size.width - 400, 30)];
        _lblLogin.textAlignment = NSTextAlignmentCenter;
        _lblLogin.text = @"LOGIN";
        _lblLogin.font = FONT_BOLD_20;
        _lblLogin.backgroundColor = [UIColor clearColor];
    }
    return _lblLogin;
}

- (UITextField *)txtEmail {
    if (!_txtEmail) {
        _txtEmail = [[UITextField alloc] initWithFrame:CGRectMake(300, _lblLogin.frame.origin.y + _lblLogin.frame.size.height + 20, self.view.frame.size.width - 600, 30)];
        _txtEmail.textColor = [UIColor blackColor];
        _txtEmail.placeholder = @"Username";
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

-(UIButton*)btnLogin{
    if(!_btnLogin){
        _btnLogin = [[UIButton alloc] initWithFrame:CGRectMake(_txtPassword.frame.origin.x + 20, _txtPassword.frame.origin.y + _txtPassword.frame.size.height + 20, _txtPassword.frame.size.width -40, 40)];
        _btnLogin.backgroundColor = [UIColor blackColor];
        [_btnLogin setTitle:@"LOG IN" forState:UIControlStateNormal];
        [_btnLogin setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnLogin.titleLabel.font = FONT_NORMAL_16;
        _btnLogin.layer.cornerRadius = 5.0f;
        [_btnLogin addTarget:self action:@selector(loginButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnLogin;
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
        [self loginButtonAction:nil];
    }
    return YES;
}

#pragma mark - Button Actions
-(void)loginButtonAction:(id)sender {
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
        _appDelegate.currentUser = user;
        
        [self signInUser:user];
    }
}

#pragma mark - Methods
-(void)signInUser:(UserDM*)user{
    NSMutableDictionary *params = [[NSMutableDictionary alloc]init];
    [params setObject:user.email forKey:KEY_USER_EMAIL];
    [params setObject:user.password forKey:KEY_USER_PASSWORD];
    [_echoAPI signInUser:params];
}

@end
