//
//  NewsDetailViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 16.08.13.
//
//

#import "NewsDetailViewController.h"
#import "ColorSelection.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController
@synthesize _dateLabel;
@synthesize _linkButton;
@synthesize _contentWebView;

@synthesize _newsItem;

@synthesize _dateFormatter;

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

    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    
    [_descriptionTitleLabel setBackgroundColor:_zhawColor._zhawOriginalBlue];
    [_descriptionTitleLabel setTextColor:_zhawColor._zhawWhite];
    [_dateLabel             setTextColor:_zhawColor._zhawLightGrey];
    
    _dateFormatter = [[DateFormation alloc] init];
    
    UIButton *backButton = [UIButton buttonWithType:101];
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backButton.frame.size.width, backButton.frame.size.height)];
    
    [backButton addTarget:self action:@selector(moveBackToMenuOverview:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"zurück" forState:UIControlStateNormal];
    [backButtonView addSubview:backButton];
    
    // set buttonview as custom view for bar button item
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = @"News";
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _descriptionTitleLabel = nil;
    _dateLabel = nil;
    _linkButton = nil;
    _contentWebView = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
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
        
        [_contentWebView loadHTMLString:_newsItem._content baseURL:nil];
        
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
