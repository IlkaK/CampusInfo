//
//  EventsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import <UIKit/UIKit.h>
#import <NewsChannelDto.h>
#import <DateFormation.h>


@interface EventsViewController : UIViewController
{
    NewsChannelDto                      *_newsChannel;

    IBOutlet UILabel                    *_titleLabel;
    IBOutlet UILabel                    *_descriptionTitleLabel;
    IBOutlet UITableView                *_eventsTable;
    IBOutlet UITableViewCell            *_eventsTableCell;
    
    DateFormation                       *_dateFormatter;
    UIColor                             *_blueColor;
    
    int                                 _actualTrials;
    IBOutlet UILabel                    *_noConnectionLabel;
    IBOutlet UIButton                   *_noConnectionButton;

}

@property (nonatomic, retain) NewsChannelDto                        *_newsChannel;

@property (nonatomic, retain) DateFormation                         *_dateFormatter;
@property (nonatomic, retain) UIColor                               *_blueColor;

@property (nonatomic, retain) IBOutlet UILabel                      *_titleLabel;
@property (nonatomic, retain) IBOutlet UILabel                      *_descriptionTitleLabel;
@property (nonatomic, retain) IBOutlet UITableView                  *_eventsTable;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_eventsTableCell;

@property (nonatomic, assign) int                                   _actualTrials;
@property (nonatomic, retain) IBOutlet UIButton                     *_noConnectionButton;
@property (nonatomic, retain) IBOutlet UILabel                      *_noConnectionLabel;

- (IBAction)moveBackToMenuOverview:(id)sender;
- (IBAction)tryConnectionAgain:(id)sender;

@end
