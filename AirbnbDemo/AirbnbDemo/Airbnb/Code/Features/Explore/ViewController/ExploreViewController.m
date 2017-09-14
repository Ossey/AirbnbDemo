//
//  ExploreViewController.m
//  AirbnbDemo
//
//  Created by Swae on 06/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import "ExploreViewController.h"
#import "UIViewController+XYNavigationBar.h"
#import "XYSearchNavigationView.h"

@interface ExploreViewController ()

@property (nonatomic, strong) XYTheme *theme;

@end

@implementation ExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self applyTheme:self.theme];
    
    [self setupUI];
}

- (void)setupUI {
    
    XYSearchNavigationView *customView = [XYSearchNavigationView new];
    self.xy_navigationBar.titleView = customView;
    customView.placeholderTitle = @"搜索";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - XYThemeable

- (void)applyTheme:(XYTheme *)theme {
    self.theme = theme;
    if ([self viewIfLoaded] == nil) {
        return;
    }
    self.view.backgroundColor = theme.colors.midBackground;
    self.view.tintColor = theme.colors.link;
}


@end
