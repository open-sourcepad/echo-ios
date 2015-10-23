//
//  Constants.h
//  echo
//
//  Created by Ayra Panganiban on 10/23/15.
//  Copyright (c) 2015 sourcepad. All rights reserved.
//

#pragma mark - API
#define BASE_URL                    @"https://sp-echo-app.herokuapp.com/"

#pragma mark - Defaults
#define DEFAULT_CURRENT_USER        @"current user"
#define API_SIGNIN                  @"api/sign_in"
#define API_GET_QUESTION            @"api/question"
#define API_POST_ANSWER             @"api/feedback"

#pragma mark - Colors
#define RGB(r,g,b)                  [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define COLOR_THEME                 RGB(253,216,79)

#pragma mark - Fonts
#define FONT_NORMAL_16              [UIFont fontWithName:@"HelveticaNeue" size:16.0]
#define FONT_BOLD_20                [UIFont fontWithName:@"HelveticaNeue-Bold" size:20.0]
#define FONT_BOLD_40                [UIFont fontWithName:@"HelveticaNeue-Bold" size:40.0]
#define FONT_BOLD_60                [UIFont fontWithName:@"HelveticaNeue-Bold" size:60.0]

#pragma mark - Keys
#define KEY_DATA                    @"data"
#define KEY_USER_EMAIL              @"[user]email"
#define KEY_USER_PASSWORD           @"[user]password"
#define KEY_AUTH_TOKEN              @"auth_token"
#define KEY_UID                     @"uid"
#define KEY_EMAIL                   @"email"
#define KEY_PASSWORD                @"password"
#define KEY_ERRORS                  @"errors"
#define KEY_ERROR_MESSAGE           @"message"
#define KEY_IMAGE_URL               @"image_url"
#define KEY_DESCRIPTION             @"description"
#define KEY_QUESTION                @"question"
#define KEY_ID                      @"id"
#define KEY_ANSWER_ID               @"answer_id"
#define KEY_ANSWERS                 @"answers"
#define KEY_POSITION                @"position"
#define ALERT_CONNECTION_ERROR      @"The Internet connection appears to be offline."
#define KEY_SUCCESS                 @"success"
#define ALERT_ERROR                 @"An error occurred."
#define ALERT_TRY_AGAIN             @"Please try again later."
