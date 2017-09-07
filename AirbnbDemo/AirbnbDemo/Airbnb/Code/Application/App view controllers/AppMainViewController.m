//
//  AppMainViewController.m
//  AirbnbDemo
//
//  Created by Swae on 07/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import "AppMainViewController.h"
#import "XYTheme.h"

@interface AppMainViewController ()

@property (nonatomic, strong) UITabBarController *rootTabBarController;

@end

@implementation AppMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Setup

- (void)loadMainUI {
    if ([self uiIsLoaded]) {
        return;
    }
    UITabBarController *tabBar = [[UIStoryboard storyboardWithName:@"WMFTabBarUI" bundle:nil] instantiateInitialViewController];
    [self addChildViewController:tabBar];
    [self.view insertSubview:tabBar.view atIndex:0];
    tabBar.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewDict = @{@"tableBarView": tabBar.view};
    NSArray *tabBarConstraints = @[
                                   [NSLayoutConstraint constraintsWithVisualFormat:@"|[tableBarView]|" options:kNilOptions metrics:nil views:viewDict],
                                   [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableBarView]|" options:kNilOptions metrics:nil views:viewDict],
                                   ];

    
    [tabBar didMoveToParentViewController:self];
    self.rootTabBarController = tabBar;
    
//    XYTheme *theme = [[NSUserDefaults xy_userDefaults] xy_appTheme];
//    [self applyTheme:theme];
//
//    [self configureTabController];
//    [self configureExploreViewController];
//    [self configurePlacesViewController];
//    [self configureArticleListController:self.savedArticlesViewController];
//    [self configureArticleListController:self.recentArticlesViewController];
//    [self.searchViewController applyTheme:self.theme];
//    [self.settingsViewController applyTheme:self.theme];
}


- (BOOL)uiIsLoaded {
    return _rootTabBarController != nil;
}

@end
