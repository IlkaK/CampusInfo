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
@synthesize _titleNavigationItem;
@synthesize _titleLabel;
@synthesize _descriptionLabel;

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
 * @function prefersStatusBarHidden
 * Used to hide the iOS status bar with time and battery symbol.
 */
-(BOOL) prefersStatusBarHidden
{
    return YES;
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
    
    //----
    UIBarButtonItem *_backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStyleBordered target:self action:@selector(moveBackToMaps:)];
    [_backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:_zhawColor._zhawWhite} forState:UIControlStateNormal];
    [_titleNavigationItem setLeftBarButtonItem :_backButtonItem animated :true];
    [_titleNavigationItem setTitle:@""];
    
    [_titleLabel setTextColor:_zhawColor._zhawWhite];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarTitleSize]];
    [_titleLabel setText:NSLocalizedString(@"MapsVCTitle", nil)];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NavigationBarBackground] forBarMetrics:UIBarMetricsDefault];
    
    [_descriptionLabel setTextColor:_zhawColor._zhawWhite];
    [_descriptionLabel setTextAlignment:NSTextAlignmentCenter];
    [_descriptionLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
    [_descriptionLabel setText: _description];
    
    
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
    
    [_descriptionLabel setText: _description];
    
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
    _titleLabel = nil;
    _descriptionLabel = nil;
    [super viewDidUnload];
}
@end
