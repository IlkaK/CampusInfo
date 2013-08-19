//
//  ZurichViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 19.08.13.
//
//

#import "ZurichViewController.h"

@interface ZurichViewController ()

@end

@implementation ZurichViewController
@synthesize _titleLabel;
@synthesize _zurichWebView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSURL *_targetURL = [[NSBundle mainBundle] URLForResource:@"Anfahrtsplan-Zuerich" withExtension:@"pdf"];
    
    NSURLRequest *_urlRequest = [NSURLRequest requestWithURL:_targetURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [_zurichWebView loadRequest:_urlRequest];
    _zurichWebView.scalesPageToFit=YES;
    
    UIColor *_backgroundColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];
    
    [_titleLabel setBackgroundColor:_backgroundColor];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)moveBackToMaps:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload {
    _titleLabel = nil;
    _zurichWebView = nil;
    [super viewDidUnload];
}
@end
