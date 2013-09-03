//
//  TechnikumViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 19.08.13.
//
//

#import "TechnikumViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

@interface TechnikumViewController ()

@end

@implementation TechnikumViewController

@synthesize _technikumWebView;

@synthesize _titleNavigationBar;
@synthesize _titleNavigationLabel;
@synthesize _titleNavigationItem;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initialization
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    
    
    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToMaps:)];
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = TechnikumVCTitle;
    _titleNavigationItem.title = @"";
    
    CGRect imageRect = CGRectMake(0, 0, _titleNavigationBar.frame.size.width, _titleNavigationBar.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [_zhawColor._zhawOriginalBlue set];
    UIRectFill(imageRect);
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_titleNavigationBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
    
    [_titleNavigationLabel setBackgroundColor:_zhawColor._zhawOriginalBlue];
    
    
    // web view
    NSURL        *_targetURL  = [[NSBundle mainBundle] URLForResource:TechnikumVCFileName withExtension:TechnikumVCFileFormat];
    NSURLRequest *_urlRequest = [NSURLRequest requestWithURL:_targetURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    
    [_technikumWebView loadRequest:_urlRequest];
    _technikumWebView.scalesPageToFit=YES;
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
    _technikumWebView = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    [super viewDidUnload];
}
@end
