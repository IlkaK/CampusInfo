/*
 TechnikumViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header TechnikumViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of TechnikumViewController.xib, which shows the choosen map within a web view. </li>
 *      <li> Gets the delegate from MapsViewController. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> This class is called by MapsViewController and receives the delegate from there. </li>
 *      <li> MapsViewController also sets its file, file format and description. </li> *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It only passes the delegate back to MapsViewController. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

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

/*!
 * @function initWithNibName
 * Initializiation of class.
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

/*!
 * @function viewDidLoad
 * The function is included, since class inherits from UIViewController.
 * Is called first time, the view is started for initialization.
 * Is only called once, after initialization, never again.
 */
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
    [_titleNavigationLabel setTextAlignment:NSTextAlignmentCenter];
    
    
    [_descriptionLabel setTextColor:_zhawColor._zhawWhite];
    
    _descriptionNavigationItem.title = @"";
    
    [_descriptionNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    [_descriptionLabel setTextAlignment:NSTextAlignmentCenter];
    _descriptionLabel.text = _description;
    
    // web view
    NSURL        *_targetURL  = [[NSBundle mainBundle] URLForResource:_fileName withExtension:_fileFormat];
    NSURLRequest *_urlRequest = [NSURLRequest requestWithURL:_targetURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [_technikumWebView loadRequest:_urlRequest];
    _technikumWebView.scalesPageToFit=YES;
}

/*!
 * @function viewWillAppear
 * The function is included, since class inherits from UIViewController.
 * It is called every time the view is called again.
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _descriptionLabel.text = _description;
    
    // web view
    NSURL        *_targetURL  = [[NSBundle mainBundle] URLForResource:_fileName withExtension:_fileFormat];
    NSURLRequest *_urlRequest = [NSURLRequest requestWithURL:_targetURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:60.0];
    [_technikumWebView loadRequest:_urlRequest];
}

/*!
 * @function didReceiveMemoryWarning
 * The function is included per default.
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 @function moveBackToMaps
 Function is called, when back button on navigation bar is hit, to move back to maps view.
 @param sender
 */
- (void)moveBackToMaps:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];    
}

/*!
 @function viewDidUnload
 * The function is included, since class inherits from UIViewController.
 * It is called while the view is unloaded.
 */
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
