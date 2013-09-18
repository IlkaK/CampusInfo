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

@synthesize _titleNavigationBar;
@synthesize _titleNavigationLabel;
@synthesize _titleNavigationItem;

@synthesize _descriptionLabel;
@synthesize _descriptionNavigationBar;
@synthesize _descriptionNavigationItem;

@synthesize _technikumWebView;

@synthesize _description;
@synthesize _fileFormat;
@synthesize _fileName;

@synthesize _zhawColor;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // initialization
    _zhawColor = [[ColorSelection alloc]init];
    
    
    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToMaps:)];
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = MapsVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    [_titleNavigationLabel setTextAlignment:UITextAlignmentCenter];
    
    
    [_descriptionLabel setTextColor:_zhawColor._zhawWhite];
    
    _descriptionNavigationItem.title = @"";
    
    [_descriptionNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    [_descriptionLabel setTextAlignment:UITextAlignmentCenter];
    _descriptionLabel.text = _description;
    
    // web view
    NSURL        *_targetURL  = [[NSBundle mainBundle] URLForResource:_fileName withExtension:_fileFormat];
    NSURLRequest *_urlRequest = [NSURLRequest requestWithURL:_targetURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [_technikumWebView loadRequest:_urlRequest];
    _technikumWebView.scalesPageToFit=YES;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _descriptionLabel.text = _description;
    
    // web view
    NSURL        *_targetURL  = [[NSBundle mainBundle] URLForResource:_fileName withExtension:_fileFormat];
    NSURLRequest *_urlRequest = [NSURLRequest requestWithURL:_targetURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [_technikumWebView loadRequest:_urlRequest];
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
    _descriptionNavigationBar = nil;
    _descriptionNavigationItem = nil;
    _descriptionLabel = nil;
    [super viewDidUnload];
}
@end
