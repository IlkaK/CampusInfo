/*
 SocialMediaViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header SocialMediaViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of SocialMediaViewController.xib, which shows social media links </li>
 *      <li> Listing social media links and browsing there when activated.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> This class only receives the delegate from MenuOverviewController and does not get any other data. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> This class only sends back the delegate to MenuOverviewController.</li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "SocialMediaViewController.h"
#import "UIConstantStrings.h"
#import "URLConstantStrings.h"

@interface SocialMediaViewController ()

@end

@implementation SocialMediaViewController
@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationLabel;

@synthesize _socialMediaTableCell;

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
   
    // general intialization
    _zhawColor = [[ColorSelection alloc]init];

    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToMenuOverview:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:[UIColor whiteColor]];
    _titleNavigationLabel.text = SocialMediaVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    [_titleNavigationLabel setTextAlignment:NSTextAlignmentCenter];
}

/*!
 @function moveBackToMenuOverview
 Function is called, when back button on navigation bar is hit, to move back to menu overview.
 @param sender
 */
- (void)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
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
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _socialMediaTableCell = nil;
    [super viewDidUnload];
}


// ----- HANDLING TABLE -----
/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in table.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*!
 * @function numberOfRowsInSection
 * The function defines the number of rows in table.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

/*!
 * @function heightForRowAtIndexPath
 * The function is for customizing the table view cells.
 * It sets the height for each cell individually.
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}

/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells.
 * According to the number of time slots and rooms (scheduleEvents) the cell methods are called.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.row; //indexPath.section;
    NSString         *_cellIdentifier;
    UITableViewCell  *_cell = nil;
    
    _cellIdentifier  = @"SocialMediaTableCell";
    _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"SocialMediaTableCell" owner:self options:nil];
        _cell = _socialMediaTableCell;
        self._socialMediaTableCell = nil;
    }
    
    UIButton *_socialMediaButton  = (UIButton *) [_cell viewWithTag:1];
    NSString *_socialMediaButtonTitle;
    UIImage  *_socialMediaButtonImage;
    _socialMediaButton.enabled = true;
    
    // facebook
    if (_cellSelection == 0)
    {
        _socialMediaButtonTitle   = [NSString stringWithFormat:@"   %@",SocialMediaFacebook];
        [_socialMediaButton addTarget:self action:@selector(openURLFacebook  :event:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_socialMediaButtonTitle];
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        [_titleString addAttribute:NSForegroundColorAttributeName value:_zhawColor._zhawFontGrey range:NSMakeRange(0, [_titleString length])];
        
        [_socialMediaButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        _socialMediaButtonImage = [UIImage imageNamed:SocialMediaFacebookPNG];
        [_socialMediaButton setImage:_socialMediaButtonImage forState:UIControlStateNormal];
    }
    
    // youtube
    if (_cellSelection == 1)
    {
        _socialMediaButtonTitle   = [NSString stringWithFormat:@"   %@",SocialMediaYoutube];
        [_socialMediaButton addTarget:self action:@selector(openURLYoutube  :event:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_socialMediaButtonTitle];
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        [_titleString addAttribute:NSForegroundColorAttributeName value:_zhawColor._zhawFontGrey range:NSMakeRange(0, [_titleString length])];

        [_socialMediaButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        _socialMediaButtonImage = [UIImage imageNamed:SocialMediaYoutubePNG];
        [_socialMediaButton setImage:_socialMediaButtonImage forState:UIControlStateNormal];
    }

    if (_cellSelection == 2)
    {
        _socialMediaButtonTitle   = [NSString stringWithFormat:@"   %@",SocialMediaTwitter];
        [_socialMediaButton addTarget:self action:@selector(openURLTwitter  :event:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_socialMediaButtonTitle];
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        [_titleString addAttribute:NSForegroundColorAttributeName value:_zhawColor._zhawFontGrey range:NSMakeRange(0, [_titleString length])];
        
        [_socialMediaButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        _socialMediaButtonImage = [UIImage imageNamed:SocialMediaTwitterPNG];
        [_socialMediaButton setImage:_socialMediaButtonImage forState:UIControlStateNormal];
    }

    if (_cellSelection == 3)
    {
        _socialMediaButtonTitle   = [NSString stringWithFormat:@"   %@",SocialMediaIssuu];
        [_socialMediaButton addTarget:self action:@selector(openURLIssuu  :event:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_socialMediaButtonTitle];
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        [_titleString addAttribute:NSForegroundColorAttributeName value:_zhawColor._zhawFontGrey range:NSMakeRange(0, [_titleString length])];
        
        [_socialMediaButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        _socialMediaButtonImage = [UIImage imageNamed:SocialMediaIssuuPNG];
        [_socialMediaButton setImage:_socialMediaButtonImage forState:UIControlStateNormal];
    }

    if (_cellSelection == 4)
    {
        _socialMediaButtonTitle   = [NSString stringWithFormat:@"   %@",SocialMediaXing];
        [_socialMediaButton addTarget:self action:@selector(openURLXing  :event:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_socialMediaButtonTitle];
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        [_titleString addAttribute:NSForegroundColorAttributeName value:_zhawColor._zhawFontGrey range:NSMakeRange(0, [_titleString length])];
        
        [_socialMediaButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        _socialMediaButtonImage = [UIImage imageNamed:SocialMediaXingPNG];
        [_socialMediaButton setImage:_socialMediaButtonImage forState:UIControlStateNormal];
    }
    
    return _cell;
}

/*!
 * @function openURLFacebook
 * Switches to facebook app (if installed) or browser to open ZHAW School of Engineering page.
 */
-(void) openURLFacebook:(id)sender event:(id)event
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:URLFacebookApp]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLFacebookApp]];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLFacebookWeb]];
    }
}

/*!
 * @function openURLYoutube
 * Switches to browser to open ZHAW School of Engineering page within youtube.
 */
-(void) openURLYoutube:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLYoutubeWeb]];
}

/*!
 * @function openURLTwitter
 * Switches to twitter app (if installed) or browser to open ZHAW School of Engineering page.
 */
-(void) openURLTwitter:(id)sender event:(id)event
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:URLTwitterApp]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLTwitterApp]];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLTwitterWeb]];
    }
}

/*!
 * @function openURLIssuu
 * Switches to browser to open ZHAW School of Engineering page within Issuu.
 */
-(void) openURLIssuu:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLIssuuWeb]];
}

/*!
 * @function openURLXing
 * Switches to browser to open ZHAW School of Engineering page within Xing.
 */
-(void) openURLXing:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLXingWeb]];
}


@end
