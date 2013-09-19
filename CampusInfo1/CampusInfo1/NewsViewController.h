//
//  NewsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import <UIKit/UIKit.h>
#import "NewsChannelDto.h"
#import "NewsDetailViewController.h"
#import "DateFormation.h"
#import "ColorSelection.h"
#import "GradientButton.h"

@class NewsDetailViewController;


@interface NewsViewController : UIViewController<UITableViewDelegate>
{
    NewsChannelDto                      *_newsChannel;
    
    IBOutlet UITableView                *_newsTable;
    IBOutlet UITableViewCell            *_newsTableCell;
    
    DateFormation                       *_dateFormatter;
    
    ColorSelection                      *_zhawColor;
    IBOutlet NewsDetailViewController   *_newsDetailVC;
    
    int                                 _actualTrials;
    IBOutlet GradientButton             *_noConnectionButton;
    IBOutlet UILabel                    *_noConnectionLabel;
    
    IBOutlet UINavigationBar            *_titleNavigationBar;
    IBOutlet UINavigationItem           *_titleNavigationItem;
    IBOutlet UILabel                    *_titleNavigationLabel;
    
    IBOutlet UIActivityIndicatorView    *_waitForLoadingActivityIndicator;
    
}

@property (strong, nonatomic) NewsChannelDto                        *_newsChannel;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet UITableView                  *_newsTable;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_newsTableCell;

@property (nonatomic, retain) DateFormation                         *_dateFormatter;
@property (nonatomic, retain) ColorSelection                        *_zhawColor;

@property (nonatomic, retain) IBOutlet NewsDetailViewController     *_newsDetailVC;

@property (nonatomic, assign) int                                   _actualTrials;
@property (nonatomic, retain) IBOutlet GradientButton               *_noConnectionButton;
@property (nonatomic, retain) IBOutlet UILabel                      *_noConnectionLabel;

@property (nonatomic, retain) IBOutlet UIActivityIndicatorView      *_waitForLoadingActivityIndicator;

- (IBAction)tryConnectionAgain:(id)sender;

@end
