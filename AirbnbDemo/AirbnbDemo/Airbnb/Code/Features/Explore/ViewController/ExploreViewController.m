//
//  ExploreViewController.m
//  AirbnbDemo
//
//  Created by Swae on 06/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import "ExploreViewController.h"
#import "UIViewController+XYCustomNavigationBar.h"
#import "XYSearchNavigationView.h"
#import "SearchViewController.h"

@interface ExploreViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) XYTheme *theme;
@property (nonatomic, weak) UITableView *tableView;

@end

@implementation ExploreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self applyTheme:self.theme];
    
    [self setupUI];
}

- (void)setupUI {
    self.xy_navigationBar.xy_navigationBarHeight = (XYNavigationBarHeight){74.0, 64.0};
    XYSearchNavigationView *customView = [XYSearchNavigationView new];
    self.xy_navigationBar.customView = customView;
    customView.placeholderTitle = @"搜索";
    __weak typeof(self) weakSelf = self;
    customView.searchClickBlock = ^(XYSearchNavigationView *view) {
        SearchViewController *vc = [SearchViewController new];
        [weakSelf showDetailViewController:vc sender:self];
    };
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UITableViewDelegate, UITableViewDataSource
////////////////////////////////////////////////////////////////////////

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor blue10];
    return cell;
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

////////////////////////////////////////////////////////////////////////
#pragma mark -
////////////////////////////////////////////////////////////////////////

- (UITableView *)tableView {
    if (!_tableView) {
        UITableView *tableView = [[UITableView alloc] init];
        _tableView = tableView;
        tableView.delegate = self;
        tableView.dataSource = self;
        [self.view addSubview:_tableView];
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        NSDictionary *viewDict = @{@"tableView": tableView};
        NSArray *tableViewConstraints = @[
                                          [NSLayoutConstraint constraintsWithVisualFormat:@"|[tableView]|" options:kNilOptions metrics:nil views:viewDict],
                                          [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[tableView]|" options:kNilOptions metrics:nil views:viewDict]
                                          ];
        [self.view addConstraints:[tableViewConstraints valueForKeyPath:@"@unionOfArrays.self"]];
    }
    return _tableView;
}

@end
