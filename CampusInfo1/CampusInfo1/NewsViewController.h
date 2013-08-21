//
//  NewsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import <UIKit/UIKit.h>
#import <NewsChannelDto.h>
#import <NewsDetailViewController.h>
#import <DateFormation.h>

@class NewsDetailViewController;


@interface NewsViewController : UIViewController<UITableViewDelegate>
{
    NewsChannelDto                      *_newsChannel;
    
    IBOutlet UITableView                *_newsTable;
    IBOutlet UITableViewCell            *_newsTableCell;
    
    DateFormation                       *_dateFormatter;
    
    UIColor                             *_blueColor;
    IBOutlet NewsDetailViewController   *_newsDetailVC;
    
    int                                 _actualTrials;
    IBOutlet UIButton                   *_noConnectionButton;
    IBOutlet UILabel                    *_noConnectionLabel;
    
    IBOutlet UINavigationBar            *_titleNavigationBar;
    IBOutlet UINavigationItem           *_titleNavigationItem;
    IBOutlet UILabel                    *_titleNavigationLabel;
    
}

@property (strong, nonatomic) NewsChannelDto                        *_newsChannel;

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleNavigationLabel;

@property (nonatomic, retain) IBOutlet UITableView                  *_newsTable;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_newsTableCell;

@property (nonatomic, retain) DateFormation                         *_dateFormatter;

@property (nonatomic, retain) UIColor                               *_blueColor;

@property (nonatomic, retain) IBOutlet NewsDetailViewController     *_newsDetailVC;

@property (nonatomic, assign) int                                   _actualTrials;
@property (nonatomic, retain) IBOutlet UIButton                     *_noConnectionButton;
@property (nonatomic, retain) IBOutlet UILabel                      *_noConnectionLabel;

- (IBAction)tryConnectionAgain:(id)sender;

@end
