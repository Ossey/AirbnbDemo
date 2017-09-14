//
//  XYSearchNavigationView.m
//  AirbnbDemo
//
//  Created by Swae on 09/09/2017.
//  Copyright © 2017 Ossey. All rights reserved.
//

#import "XYSearchNavigationView.h"

@interface XYSearchNavigationView ()

@property (nonatomic, weak) UIImageView *searchIconView;
@property (nonatomic, weak) UILabel *placeholderLbael;

@end

@implementation XYSearchNavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    
    self.searchIconView.translatesAutoresizingMaskIntoConstraints = NO;
    self.placeholderLbael.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSLayoutConstraint *searchIconTopConstraint = [NSLayoutConstraint constraintWithItem:self.searchIconView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:15.0];
    NSLayoutConstraint *searchIconHeightConstraint = [NSLayoutConstraint constraintWithItem:self.searchIconView attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.searchIconView attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0];
    NSLayoutConstraint *searchIconBottomConstraint = [NSLayoutConstraint constraintWithItem:self.searchIconView attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-15.0];
     NSLayoutConstraint *placeholderLbaelTopConstraint = [NSLayoutConstraint constraintWithItem:self.placeholderLbael attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0];
    NSLayoutConstraint *placeholderLbaelBottomConstraint = [NSLayoutConstraint constraintWithItem:self.placeholderLbael attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeBottom multiplier:1.0 constant:0.0];
    NSDictionary *viewDict = @{@"searchIconView": self.searchIconView, @"placeholderLbael": self.placeholderLbael};
    NSArray *viewConstraintsH = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(15.0)-[searchIconView]-(15.0)-[placeholderLbael]-(15.0)-|" options:kNilOptions metrics:nil views:viewDict];
    NSArray *allConstrains = @[@[searchIconTopConstraint, searchIconHeightConstraint, searchIconBottomConstraint, placeholderLbaelBottomConstraint, placeholderLbaelTopConstraint],viewConstraintsH];
    
    [self addConstraints:[allConstrains valueForKeyPath:@"@unionOfArrays.self"]];
    
}

- (void)setPlaceholderTitle:(NSString *)placeholderTitle {
    _placeholderLbael.text = placeholderTitle;
}

- (NSString *)placeholderTitle {
    return _placeholderLbael.text;
}

- (UIImageView *)searchIconView {
    if (!_searchIconView) {
        UIImageView *imageView = [[UIImageView alloc] init];
        [self addSubview:imageView];
        _searchIconView = imageView;
        imageView.image = [UIImage imageNamed:@"new_explore_search_icon"];
    }
    return _searchIconView;
}

- (UILabel *)placeholderLbael {
    if (!_placeholderLbael) {
        UILabel *label = [[UILabel alloc] init];
        [self addSubview:label];
        _placeholderLbael = label;
    }
    return _placeholderLbael;
}

@end
