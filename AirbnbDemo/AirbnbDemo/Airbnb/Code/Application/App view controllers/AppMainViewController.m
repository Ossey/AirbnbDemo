//
//  AppMainViewController.m
//  AirbnbDemo
//
//  Created by Swae on 07/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import "AppMainViewController.h"
#import "ExploreViewController.h"
#import "WishViewController.h"
#import "StoryViewController.h"
#import "InboxViewController.h"
#import "UserInformationViewController.h"
#import "AppNavigationController.h"
#import "XYTheme.h"


typedef NS_ENUM(NSInteger, XYAppTabType) {
    XYAppTabTypeExplore = 0,
    XYAppTabTypeWish,
    XYAppTabTypeStory,
    XYAppTabTypeInbox,
    XYAppTabTypeUserInfo
};


/**
 *  tabBarController 上 tabBar的个数
 *
 *  @warning 由于XYAppTabType是从0开始的，那么tabBar的个数应为最后一个(XYAppTabTypeUserInfo)+1
 *
 *  @see XYAppTabType
 */
static NSInteger XYAppTabCount = XYAppTabTypeUserInfo + 1;

@interface AppMainViewController () <UITabBarControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate>

@property (nonatomic, strong) UITabBarController *rootTabBarController;
@property (nonatomic, strong) ExploreViewController *exploreViewController;
@property (nonatomic, strong) WishViewController *wishViewController;
@property (nonatomic, strong) InboxViewController *inboxViewController;
@property (nonatomic, strong) UserInformationViewController *userInfoViewControler;
@property (nonatomic, strong) StoryViewController *storyViewController;

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
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    [self addChildViewController:tabBarController];
    [self.view insertSubview:tabBarController.view atIndex:0];
    tabBarController.view.translatesAutoresizingMaskIntoConstraints = NO;
    NSDictionary *viewDict = @{@"tableBarView": tabBarController.view};
    NSArray *tabBarConstraints = @[
                                   [NSLayoutConstraint constraintsWithVisualFormat:@"|[tableBarView]|" options:kNilOptions metrics:nil views:viewDict],
                                   [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableBarView]|" options:kNilOptions metrics:nil views:viewDict],
                                   ];
    [self.view addConstraints:[tabBarConstraints valueForKeyPath:@"@unionOfArrays.self"]];
    
    [tabBarController didMoveToParentViewController:self];
    self.rootTabBarController = tabBarController;
    
    [self setupTabBarController];
    [self configureExploreViewController];
    
}


- (void)launchAppInWindow:(UIWindow *)window {
    
    [window setRootViewController:self];
    [window makeKeyAndVisible];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillEnterForegroundWithNotification:) name:UIApplicationWillEnterForegroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidBecomeActiveWithNotification:) name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appWillResignActiveWithNotification:) name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidEnterBackgroundWithNotification:) name:UIApplicationDidEnterBackgroundNotification object:nil];

    [self displayUI];
}

/**
 *  显示主界面
 *
 *  @warning 此处应该判断是否应该显示主界面，或者显示欢迎页面
 *
 */
- (void)displayUI {
    [self loadMainUI];
}


- (void)setupTabBarController {
    self.rootTabBarController.delegate = self;
    for (XYAppTabType i = 0; i < XYAppTabCount; i++) {
        UIViewController *childVc = nil;
        switch (i) {
            case XYAppTabTypeExplore: {
                childVc = [ExploreViewController new];
                break;
            }
            case XYAppTabTypeWish: {
                childVc = [WishViewController new];
                break;
            }
            case XYAppTabTypeStory: {
                childVc = [StoryViewController new];
                break;
            }
            case XYAppTabTypeInbox: {
                childVc = [InboxViewController new];
                break;
            }
            case XYAppTabTypeUserInfo: {
                childVc = [UserInformationViewController new];
                break;
            }
            default:
                break;
        }
        AppNavigationController *navigationController = [[AppNavigationController alloc] initWithRootViewController:childVc];
        navigationController.delegate = self;
        navigationController.interactivePopGestureRecognizer.delegate = self;
        [self.rootTabBarController addChildViewController:navigationController];
    }
}

- (void)configureExploreViewController {
    UIImage *tabImage = [UIImage imageNamed:@"tab_search_icon"];
    AppNavigationController *explpreNavControler = [self navigationControllerForTabType:XYAppTabTypeExplore];
    explpreNavControler.tabBarItem.image = tabImage;
    NSString *str = XYLocalizedString(@"ios.explore.755b4d8f", @"");
    
    explpreNavControler.tabBarItem.title = str;
}

- (AppNavigationController *)navigationControllerForTabType:(XYAppTabType)tabType {
    if (tabType >= self.rootTabBarController.viewControllers.count) {
        return nil;
    }
    return (AppNavigationController *)[self.rootTabBarController viewControllers][tabType];
    
}

- (BOOL)uiIsLoaded {
    return _rootTabBarController != nil;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Notification
////////////////////////////////////////////////////////////////////////

- (void)appWillEnterForegroundWithNotification:(NSNotification *)notification {
    
}

- (void)appDidBecomeActiveWithNotification:(NSNotification *)notification {
    
}

- (void)appWillResignActiveWithNotification:(NSNotification *)notification {
    
}

- (void)appDidEnterBackgroundWithNotification:(NSNotification *)notification {
    
}

@end
