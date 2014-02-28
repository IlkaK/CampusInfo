/*
 NewsDetailViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header NewsDetailViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of NewsDetailViewController.xib, where all elements of a chosen news item displays. </li>
 *      <li> Displaying one of the news items.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from NewsViewController and passes it back, if back button is clicked. </li>
 *      <li> It receives data from NewsViewController as well. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It passes the delegate back to NewsViewController. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "NewsDetailViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController
@synthesize _dateLabel;
@synthesize _linkButton;
@synthesize _contentWebView;

@synthesize _newsItem;

@synthesize _dateFormatter;

@synthesize _descriptionNavigationBar;
@synthesize _descriptionNavigationItem;
@synthesize _descriptionTitleLabel;

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;

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
    // general initialization
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    _dateFormatter = [[DateFormation alloc] init];
    
    // title
    UIBarButtonItem *_backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStyleBordered target:self action:@selector(moveBackToMenuOverview:)];
    [_backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:_zhawColor._zhawWhite} forState:UIControlStateNormal];
    [_titleNavigationItem setLeftBarButtonItem :_backButtonItem animated :true];
    [_titleNavigationItem setTitle:NewsDetailVCTitle];
    
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: _zhawColor._zhawWhite,
                                                           UITextAttributeFont: [UIFont fontWithName:NavigationBarFont size:NavigationBarTitleSize],
                                                           }];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NavigationBarBackground] forBarMetrics:UIBarMetricsDefault];

    // setting description and date labels
    [_descriptionTitleLabel setTextColor:_zhawColor._zhawWhite];
    [_descriptionTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_descriptionTitleLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
    [_descriptionNavigationItem setTitle:@""];
    
    [_dateLabel setTextColor:_zhawColor._zhawLightGrey];
}

/*!
 * @function didReceiveMemoryWarning
 * The function is included per default.
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*!
 @function viewDidUnload
 * The function is included, since class inherits from UIViewController.
 * It is called while the view is unloaded.
 */
- (void)viewDidUnload {
    _descriptionTitleLabel = nil;
    _dateLabel = nil;
    _linkButton = nil;
    _contentWebView = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _descriptionNavigationBar = nil;
    _descriptionNavigationItem = nil;
    [super viewDidUnload];
}

/*!
 @function openingURL
 * Opens URL of link in news item in browser.
 */
-(void) openingURL:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_newsItem._link]];
}

/*!
 * @function viewWillAppear
 * The function is included, since class inherits from UIViewController.
 * It is called every time the view is called again.
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self._newsItem != nil)
    {
        _descriptionTitleLabel.text = [NSString stringWithFormat:@"%@"
                                       ,_newsItem._title];
        _dateLabel.text             =  [NSString stringWithFormat:@"%@"
                                         ,[[_dateFormatter _dayFormatter] stringFromDate:_newsItem._pubDate]];
        
        NSString *_descr = [NSString stringWithFormat:NewsWebViewHtml, NewsWebViewFont, _newsItem._content];
        
        
        [_contentWebView loadHTMLString:_descr baseURL:nil];
        
        NSMutableAttributedString *_linkButtonString = [[NSMutableAttributedString alloc] initWithString:_newsItem._link];
        [_linkButtonString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_linkButtonString length])];
        [_linkButton setAttributedTitle:_linkButtonString forState:UIControlStateNormal];
        
        _linkButton.enabled = true;
        [_linkButton addTarget:self action:@selector(openingURL :event:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}

/*!
 @function moveBackToMenuOverview
 When back button is triggered, delegate is returned to NewsViewController.
 @param sender
 */
- (void)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


@end
