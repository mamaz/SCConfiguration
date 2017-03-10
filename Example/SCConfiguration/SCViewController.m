//
//  SCViewController.m
//  SCConfiguration
//
//  Created by Gergő Németh on 04/10/2016.
//  Copyright (c) 2016 Gergő Németh. All rights reserved.
//

#import "SCViewController.h"
#import "SCConfiguration.h"

#define GLOBAL_ENV_STRING_KEY @"GLOBAL_ENV_STRING"
#define ENV_STRING_KEY @"ENV_STRING"
#define NEW_STRING_KEY @"NEW_STRING"
#define SINGLE_STRING_KEY @"SINGLE_STRING"

@implementation SCViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    // show values
    [self showConfigValues];

    // set keys to protected
    [[SCConfiguration sharedInstance] setAllKeyToProtected];

    // try to overwrite protected keys
    NSDictionary *newConfigValues = @{
                                      GLOBAL_ENV_STRING_KEY: @"New global env value!",
                                      ENV_STRING_KEY: @"debug or release, doesn't matter..",
                                      NEW_STRING_KEY: @"New data!",
                                      };
    [[SCConfiguration sharedInstance] overwriteConfigWithDictionary:newConfigValues];

    // show values
    [self showConfigValues];

    // remove keys from protection
    [[SCConfiguration sharedInstance] removeAllKeyFromProtection];

    // overwrite unprotected keys
    [[SCConfiguration sharedInstance] overwriteConfigWithDictionary:newConfigValues];

    // overwrite one unprotected key
    [[SCConfiguration sharedInstance] setObject:@"single string.." forKey:SINGLE_STRING_KEY];

    // remove unprotected key
    [[SCConfiguration sharedInstance] setObject:nil forKey:SINGLE_STRING_KEY];

    // show values
    [self showConfigValues];
}

#pragma mark - Private

- (void)showConfigValues {
    NSLog(@"⌄⌄⌄⌄⌄");
    NSLog(@"The '%@' key contains the following data: %@", GLOBAL_ENV_STRING_KEY, [[SCConfiguration sharedInstance] configValueForKey:GLOBAL_ENV_STRING_KEY]);
    NSLog(@"The '%@' key contains the following data: %@", ENV_STRING_KEY, [[SCConfiguration sharedInstance] configValueForKey:ENV_STRING_KEY]);
    NSLog(@"The '%@' key contains the following data: %@", NEW_STRING_KEY, [[SCConfiguration sharedInstance] configValueForKey:NEW_STRING_KEY]);
    NSLog(@"˄˄˄˄˄");
}

@end
