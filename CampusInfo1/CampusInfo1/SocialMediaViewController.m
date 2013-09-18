//
//  SocialMediaViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 26.08.13.
//
//

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


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

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

-(void) openURLYoutube:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLYoutubeWeb]];
}

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

-(void) openURLIssuu:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLIssuuWeb]];
}

-(void) openURLXing:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:URLXingWeb]];
}


@end
