//
//  ZurichViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 19.08.13.
//
//

#import "ZurichViewController.h"
#import "ColorSelection.h"

@interface ZurichViewController ()

@end

@implementation ZurichViewController

@synthesize _zurichWebView;

@synthesize _titleNavigationItem;
@synthesize _titleNavigationLabel;
@synthesize _titleNavigationBar;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    
    NSURL *_targetURL = [[NSBundle mainBundle] URLForResource:@"Anfahrtsplan-Zuerich" withExtension:@"pdf"];
    
    NSURLRequest *_urlRequest = [NSURLRequest requestWithURL:_targetURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [_zurichWebView loadRequest:_urlRequest];
    _zurichWebView.scalesPageToFit=YES;
    
    UIButton *backButton = [UIButton buttonWithType:101];
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backButton.frame.size.width, backButton.frame.size.height)];
    
    [backButton addTarget:self action:@selector(moveBackToMaps:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"zurück" forState:UIControlStateNormal];
    [backButtonView addSubview:backButton];
    
    // set buttonview as custom view for bar button item
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = @"Zürich - Campus Lagerstrasse";
    _titleNavigationItem.title = @"";
    
    CGRect imageRect = CGRectMake(0, 0, _titleNavigationBar.frame.size.width, _titleNavigationBar.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [_zhawColor._zhawOriginalBlue set];
    UIRectFill(imageRect);
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_titleNavigationBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
    
    [_titleNavigationLabel setBackgroundColor:_zhawColor._zhawOriginalBlue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)moveBackToMaps:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    _zurichWebView = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    [super viewDidUnload];
}
@end
