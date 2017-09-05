//
//  AppTabBarController.m
//  AirbnbDemo
//
//  Created by Swae on 06/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import "AppTabBarController.h"
#import "ExploreViewController.h"
#import "WishViewController.h"
#import "StoryViewController.h"
#import "InboxViewController.h"
#import "UserInformationViewController.h"
#import "AppNavigationController.h"

@interface AppTabBarController ()

@end

@implementation AppTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ExploreViewController *vc1 = [ExploreViewController new];
    AppNavigationController *nav1 = [[AppNavigationController alloc] initWithRootViewController:vc1];
    ExploreViewController *vc2 = [ExploreViewController new];
    AppNavigationController *nav2 = [[AppNavigationController alloc] initWithRootViewController:vc2];
    ExploreViewController *vc3 = [ExploreViewController new];
    AppNavigationController *nav3 = [[AppNavigationController alloc] initWithRootViewController:vc3];
    ExploreViewController *vc4 = [ExploreViewController new];
    AppNavigationController *nav4 = [[AppNavigationController alloc] initWithRootViewController:vc4];
    ExploreViewController *vc5 = [ExploreViewController new];
    AppNavigationController *nav5 = [[AppNavigationController alloc] initWithRootViewController:vc5];
    [self addChildViewController:nav1];
    [self addChildViewController:nav2];
    [self addChildViewController:nav3];
    [self addChildViewController:nav4];
    [self addChildViewController:nav5];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
