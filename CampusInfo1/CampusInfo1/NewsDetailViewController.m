//
//  NewsDetailViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 16.08.13.
//
//

#import "NewsDetailViewController.h"

@interface NewsDetailViewController ()

@end

@implementation NewsDetailViewController
@synthesize _contentTextView;
@synthesize _dateLabel;
@synthesize _descriptionTextView;
@synthesize _descriptionTitleLabel;
@synthesize _linkButton;
@synthesize _titleLabel;

@synthesize _newsItem;

@synthesize _dateFormatter;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIColor *_blueColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];
    
    [_titleLabel setBackgroundColor:_blueColor];
    [_titleLabel setTextColor:[UIColor whiteColor]];
    
    [_descriptionTitleLabel setBackgroundColor:_blueColor];
    [_descriptionTitleLabel setTextColor:[UIColor whiteColor]];
    
    [_dateLabel     setTextColor:[UIColor lightGrayColor]];
    
    _dateFormatter = [[DateFormation alloc] init];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    _titleLabel = nil;
    _descriptionTitleLabel = nil;
    _dateLabel = nil;
    _descriptionTextView = nil;
    _contentTextView = nil;
    _linkButton = nil;
    _contentTextView = nil;
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self._newsItem != nil)
    {
        _descriptionTitleLabel.text = [NSString stringWithFormat:@"   %@"
                                       ,_newsItem._title];
        _dateLabel.text             =  [NSString stringWithFormat:@"%@"
                                         ,[[_dateFormatter _dayFormatter] stringFromDate:_newsItem._pubDate]];
        _descriptionTextView.text   = _newsItem._description;
        _contentTextView.text       = _newsItem._content;
        
        NSMutableAttributedString *_linkButtonString = [[NSMutableAttributedString alloc] initWithString:_newsItem._link];
        [_linkButtonString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_linkButtonString length])];
        [_linkButton setAttributedTitle:_linkButtonString forState:UIControlStateNormal];
        
    }
    
}


- (IBAction)moveBackToMenuOverview:(id)sender
{
        [self dismissModalViewControllerAnimated:YES];
}


@end
