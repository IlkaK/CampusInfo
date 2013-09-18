//
//  NewsDetailViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 16.08.13.
//
//

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

@synthesize _titleNavigationLabel;
@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // general initialization
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    _dateFormatter = [[DateFormation alloc] init];
    

    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToMenuOverview:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = NewsDetailVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    [_titleNavigationLabel setTextAlignment:NSTextAlignmentCenter];

    
    // setting description and date labels
    [_descriptionTitleLabel setTextColor:_zhawColor._zhawWhite];
    [_descriptionTitleLabel setTextAlignment:NSTextAlignmentCenter];
    [_descriptionNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];    
    _descriptionNavigationItem.title = @"";
    
    [_dateLabel setTextColor:_zhawColor._zhawLightGrey];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    _descriptionTitleLabel = nil;
    _dateLabel = nil;
    _linkButton = nil;
    _contentWebView = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _descriptionNavigationBar = nil;
    _descriptionNavigationItem = nil;
    [super viewDidUnload];
}

-(void) openingURL:(id)sender event:(id)event
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_newsItem._link]];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self._newsItem != nil)
    {
        _descriptionTitleLabel.text = [NSString stringWithFormat:@"%@"
                                       ,_newsItem._title];
        _dateLabel.text             =  [NSString stringWithFormat:@"%@"
                                         ,[[_dateFormatter _dayFormatter] stringFromDate:_newsItem._pubDate]];
        
        NSString *_descr = [NSString stringWithFormat:@"<html> \n"
                            "<head> \n"
                            "<style type=\"text/css\"> \n"
                            "body {font-family: \"%@\";font-size: 13;}\n"
                            "</style> \n"
                            "</head> \n"
                            "<body>%@</body> \n"
                            "</html>", @"helvetica", _newsItem._content];
        
        
        [_contentWebView loadHTMLString:_descr baseURL:nil];
        
        NSMutableAttributedString *_linkButtonString = [[NSMutableAttributedString alloc] initWithString:_newsItem._link];
        [_linkButtonString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_linkButtonString length])];
        [_linkButton setAttributedTitle:_linkButtonString forState:UIControlStateNormal];
        
        _linkButton.enabled = true;
        [_linkButton addTarget:self action:@selector(openingURL :event:) forControlEvents:UIControlEventTouchUpInside];
        
    }
}


- (void)moveBackToMenuOverview:(id)sender
{
        [self dismissModalViewControllerAnimated:YES];
}


@end
