//
//  SocialMediaViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 26.08.13.
//
//

#import "SocialMediaViewController.h"
#import "UIConstantStrings.h"

@interface SocialMediaViewController ()

@end

@implementation SocialMediaViewController
@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationLabel;

@synthesize _socialMediaTableCell;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
   
    // general intialization
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];

    
    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToMenuOverview:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:[UIColor whiteColor]];
    _titleNavigationLabel.text = SocialMediaVCTitle;
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

- (void)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _socialMediaTableCell = nil;
    [super viewDidUnload];
}


// table and table cell handling
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 43;
}


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
        _socialMediaButtonTitle   = @"   Facebook";
        [_socialMediaButton addTarget:self action:@selector(openURLFacebook  :event:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_socialMediaButtonTitle];
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        [_socialMediaButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        _socialMediaButtonImage = [UIImage imageNamed:@"facebook.png"];
        [_socialMediaButton setImage:_socialMediaButtonImage forState:UIControlStateNormal];
    }
    
    // youtube
    if (_cellSelection == 1)
    {
        _socialMediaButtonTitle   = @"   Youtube";
        [_socialMediaButton addTarget:self action:@selector(openURLYoutube  :event:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_socialMediaButtonTitle];
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        [_socialMediaButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        _socialMediaButtonImage = [UIImage imageNamed:@"youtube.png"];
        [_socialMediaButton setImage:_socialMediaButtonImage forState:UIControlStateNormal];
    }

    if (_cellSelection == 2)
    {
        _socialMediaButtonTitle   = @"   Twitter";
        [_socialMediaButton addTarget:self action:@selector(openURLTwitter  :event:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_socialMediaButtonTitle];
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        [_socialMediaButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        _socialMediaButtonImage = [UIImage imageNamed:@"twitter.png"];
        [_socialMediaButton setImage:_socialMediaButtonImage forState:UIControlStateNormal];
    }

    if (_cellSelection == 3)
    {
        _socialMediaButtonTitle   = @"   Issuu";
        [_socialMediaButton addTarget:self action:@selector(openURLIssuu  :event:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_socialMediaButtonTitle];
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        [_socialMediaButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        _socialMediaButtonImage = [UIImage imageNamed:@"issuu.png"];
        [_socialMediaButton setImage:_socialMediaButtonImage forState:UIControlStateNormal];
    }

    if (_cellSelection == 4)
    {
        _socialMediaButtonTitle   = @"   Xing";
        [_socialMediaButton addTarget:self action:@selector(openURLXing  :event:) forControlEvents:UIControlEventTouchUpInside];
        
        NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:_socialMediaButtonTitle];
        [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
        [_socialMediaButton setAttributedTitle:_titleString forState:UIControlStateNormal];
        
        _socialMediaButtonImage = [UIImage imageNamed:@"xing.png"];
        [_socialMediaButton setImage:_socialMediaButtonImage forState:UIControlStateNormal];
    }
    
    return _cell;
}

-(void) openURLFacebook:(id)sender event:(id)event
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"fb://profile/108051929285833"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"fb://profile/108051929285833"]];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.facebook.com/engineering.zhaw"]];
    }
}

-(void) openURLYoutube:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.youtube.com/engineeringzhaw"]];
}

-(void) openURLTwitter:(id)sender event:(id)event
{
    if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"twitter://user?screen_name=engineeringzhaw"]])
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"twitter://user?screen_name=engineeringzhaw"]];
    }
    else
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/engineeringzhaw"]];
    }
    
}

-(void) openURLIssuu:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://issuu.com/engineeringzhaw"]];
}

-(void) openURLXing:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.xing.com/companies/zhawschoolofengineering"]];
}


@end
