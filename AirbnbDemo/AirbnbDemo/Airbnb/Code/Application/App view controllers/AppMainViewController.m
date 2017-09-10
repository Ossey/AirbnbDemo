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
#import "UIViewController+XYNavigationBar.h"


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

@interface AppMainViewController () <UITabBarControllerDelegate, UINavigationControllerDelegate, UIGestureRecognizerDelegate, XYThemeable>

@property (nonatomic, strong) UITabBarController *rootTabBarController;
@property (nonatomic, strong) ExploreViewController *exploreViewController;
@property (nonatomic, strong) WishViewController *wishViewController;
@property (nonatomic, strong) InboxViewController *inboxViewController;
@property (nonatomic, strong) UserInformationViewController *userInfoViewControler;
@property (nonatomic, strong) StoryViewController *storyViewController;
@property (nonatomic, strong) XYTheme *theme;

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
    [self configureWishViewController];
    [self configureStroyViewController];
    [self configureInboxViewController];
    [self configureUserInfoController];
    
    [self applyTheme:[XYTheme standard]];
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
                self.exploreViewController = (ExploreViewController *)childVc;
                break;
            }
            case XYAppTabTypeWish: {
                childVc = [WishViewController new];
                self.wishViewController = (WishViewController *)childVc;
                break;
            }
            case XYAppTabTypeStory: {
                childVc = [StoryViewController new];
                self.storyViewController = (StoryViewController *)childVc;
                break;
            }
            case XYAppTabTypeInbox: {
                childVc = [InboxViewController new];
                self.inboxViewController = (InboxViewController *)childVc;
                break;
            }
            case XYAppTabTypeUserInfo: {
                childVc = [UserInformationViewController new];
                self.userInfoViewControler = (UserInformationViewController *)childVc;
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
    AppNavigationController *navigationController = [self navigationControllerForTabType:XYAppTabTypeExplore];
    navigationController.tabBarItem.image = tabImage;
    NSString *str = XYLocalizedString(@"ios.explore.823bb461", @"");
    navigationController.tabBarItem.title = str;
    self.exploreViewController.xy_navigationBar.title = str;
    self.exploreViewController.xy_navigationBar.titleColor = [UIColor blackColor];
}

- (void)configureWishViewController {
    UIImage *tabImage = [UIImage imageNamed:@"tab_stories_icon"];
    AppNavigationController *navigationController = [self navigationControllerForTabType:XYAppTabTypeWish];
    navigationController.tabBarItem.image = tabImage;
    NSString *str = XYLocalizedString(@"ios.wishlist.cfa36f00", @"");
    navigationController.tabBarItem.title = str;
}

- (void)configureStroyViewController {
    UIImage *tabImage = [UIImage imageNamed:@"tab_saved_icon"];
    AppNavigationController *navigationController = [self navigationControllerForTabType:XYAppTabTypeStory];
    navigationController.tabBarItem.image = tabImage;
    NSString *str = XYLocalizedString(@"ios.stories.f43edcad", @"");
    navigationController.tabBarItem.title = str;
}

- (void)configureInboxViewController {
    UIImage *tabImage = [UIImage imageNamed:@"tab_inbox_icon"];
    AppNavigationController *navigationController = [self navigationControllerForTabType:XYAppTabTypeInbox];
    navigationController.tabBarItem.image = tabImage;
    NSString *str = XYLocalizedString(@"ios.inbox.d6600ac1", @"");
    navigationController.tabBarItem.title = str;
}

- (void)configureUserInfoController {
    UIImage *tabImage = [UIImage imageNamed:@"tab_profile_icon"];
    AppNavigationController *navigationController = [self navigationControllerForTabType:XYAppTabTypeUserInfo];
    navigationController.tabBarItem.image = tabImage;
    NSString *str = XYLocalizedString(@"ios.me.baa8eb5b", @"");
    navigationController.tabBarItem.title = str;
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

#pragma mark - Themeable

- (void)applyTheme:(XYTheme *)theme toNavigationControllers:(NSArray<UINavigationController *> *)navigationControllers {
    NSMutableSet<UINavigationBar *> *navigationBars = [NSMutableSet setWithCapacity:navigationControllers.count + 1];
    NSMutableSet<UIToolbar *> *toolbars = [NSMutableSet setWithCapacity:navigationControllers.count + 1];
    NSMutableSet<UINavigationController *> *foundNavigationControllers = [NSMutableSet setWithCapacity:1];
    
    for (UINavigationController *nc in navigationControllers) {
        for (UIViewController *vc in nc.viewControllers) {
            if ([vc conformsToProtocol:@protocol(XYThemeable)]) {
                [(id<XYThemeable>)vc applyTheme:theme];
            }
            if ([vc.presentedViewController isKindOfClass:[UINavigationController class]]) {
                [foundNavigationControllers addObject:(UINavigationController *)vc.presentedViewController];
            }
        }
        
        if ([nc.presentedViewController isKindOfClass:[UINavigationController class]]) {
            [foundNavigationControllers addObject:(UINavigationController *)nc.presentedViewController];
        }
        
        UIToolbar *toolbar = nc.toolbar;
        if (toolbar) {
            [toolbars addObject:toolbar];
        }
        
        UINavigationBar *navbar = nc.navigationBar;
        if (navbar) {
            [navigationBars addObject:navbar];
        }
        
        if ([nc conformsToProtocol:@protocol(XYThemeable)]) {
            [(id<XYThemeable>)nc applyTheme:theme];
        }
        
        nc.view.tintColor = theme.colors.link;
    }
    
    // Navigation bars
    
    [navigationBars addObject:[UINavigationBar appearance]];
    UIImage *chromeBackgroundImage = [UIImage xy_imageFromColor:theme.colors.chromeBackground];
    NSDictionary *navBarTitleTextAttributes = @{NSForegroundColorAttributeName: theme.colors.chromeText};
    UIImage *backChevron = [[UIImage xy_imageFlippedForRTLLayoutDirectionNamed:@"icon_chevron_large_left"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    for (UINavigationBar *navigationBar in navigationBars) {
        navigationBar.barTintColor = theme.colors.chromeBackground;
        navigationBar.translucent = NO;
        navigationBar.tintColor = theme.colors.chromeText;
        [navigationBar setBackgroundImage:chromeBackgroundImage forBarMetrics:UIBarMetricsDefault];
        [navigationBar setTitleTextAttributes:navBarTitleTextAttributes];
        [navigationBar setBackIndicatorImage:backChevron];
        [navigationBar setBackIndicatorTransitionMaskImage:backChevron];
    }
    
    // Tool bars
    for (UIToolbar *toolbar in toolbars) {
        toolbar.barTintColor = theme.colors.chromeBackground;
        [toolbar setShadowImage:[UIImage imageNamed:@"tabbar-shadow"] forToolbarPosition:UIBarPositionAny];
        [toolbar setTranslucent:NO];
    }
    
    [[UITextField appearanceWhenContainedInInstancesOfClasses:@[[UISearchBar class]]] setTextColor:theme.colors.primaryText];
    
    if ([foundNavigationControllers count] > 0) {
        [self applyTheme:theme toNavigationControllers:[foundNavigationControllers allObjects]];
    }
}

- (void)applyTheme:(XYTheme *)theme {
    self.theme = theme;
    
    self.view.backgroundColor = theme.colors.baseBackground;
    self.view.tintColor = theme.colors.link;
    
    [self.exploreViewController applyTheme:theme];
    
    // Navigation controllers
    NSMutableArray<UINavigationController *> *navigationControllers = [NSMutableArray arrayWithObjects:[self navigationControllerForTabType:XYAppTabTypeExplore], [self navigationControllerForTabType:XYAppTabTypeWish], [self navigationControllerForTabType:XYAppTabTypeStory], [self navigationControllerForTabType:XYAppTabTypeInbox], [self navigationControllerForTabType:XYAppTabTypeUserInfo], nil];
    
    [self applyTheme:theme toNavigationControllers:navigationControllers];
    
    // Tab bars
    
    NSArray<UITabBar *> *tabBars = @[self.rootTabBarController.tabBar, [UITabBar appearance]];
    NSMutableArray<UITabBarItem *> *tabBarItems = [NSMutableArray arrayWithCapacity:5];
    for (UITabBar *tabBar in tabBars) {
        tabBar.barTintColor = theme.colors.chromeBackground;
        [tabBar setTintColor:theme.colors.destructive];
        if (@available(iOS 10.0, *)) {
            [tabBar setUnselectedItemTintColor:theme.colors.unselected];
        }
        tabBar.translucent = NO;
        tabBar.shadowImage = [UIImage imageNamed:@"tabbar-shadow"];
        if (tabBar.items.count > 0) {
            [tabBarItems addObjectsFromArray:tabBar.items];
        }
    }
    
    // Tab bar items
    [tabBarItems addObject:[UITabBarItem appearance]];
    UIFont *tabBarItemFont = [UIFont preferredFontForTextStyle:UIFontTextStyleCaption2];
    NSDictionary *tabBarTitleTextAttributes = @{NSForegroundColorAttributeName: theme.colors.secondaryText, NSFontAttributeName: tabBarItemFont};
    NSDictionary *tabBarSelectedTitleTextAttributes = @{NSForegroundColorAttributeName: theme.colors.destructive, NSFontAttributeName: tabBarItemFont};
    for (UITabBarItem *item in tabBarItems) {
        [item setTitleTextAttributes:tabBarTitleTextAttributes forState:UIControlStateNormal];
        [item setTitleTextAttributes:tabBarSelectedTitleTextAttributes forState:UIControlStateSelected];
        
    }
    
    [[UISwitch appearance] setOnTintColor:theme.colors.accent];
    
    [self setNeedsStatusBarAppearanceUpdate];
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

////////////////////////////////////////////////////////////////////////
#pragma mark - UIGestureRecognizerDelegate
////////////////////////////////////////////////////////////////////////

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    for (XYAppTabType i = 0; i < XYAppTabCount; i++) {
        UINavigationController *navigationController = [self navigationControllerForTabType:i];
        if (navigationController.interactivePopGestureRecognizer == gestureRecognizer) {
            return navigationController.viewControllers.count > 1;
        }
    }
    return YES;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return ![gestureRecognizer isMemberOfClass:[UIScreenEdgePanGestureRecognizer class]];
}

@end
