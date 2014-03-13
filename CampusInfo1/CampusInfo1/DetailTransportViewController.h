//
//  DetailTransportViewController.h
//  Engineering
//
//  Created by Ilka Kokemor on 10.03.14.
//
//

#import <UIKit/UIKit.h>
#import "ColorSelection.h"
#import "ConnectionDto.h"

@interface DetailTransportViewController : UIViewController
{

    /*! @var _titleNavigationBar Used as background for title and acronym */
    IBOutlet UINavigationBar            *_titleNavigationBar;
    /*! @var _titleNavigationItem Used as navigation item for title */
    IBOutlet UINavigationItem           *_titleNavigationItem;
    /*! @var _titleLabel Shows the title */
    IBOutlet UILabel                    *_titleLabel;
    /*! @var _descriptionLabel Shows the description */
    IBOutlet UILabel                    *_descriptionLabel;
    
    /*! @var _zhawColor Holds all color schemes needed */
    ColorSelection                      *_zhawColor;
    /*! @var _dateFormatter Class which provides methods to format date from NSString to NSDate or the other way around */
    DateFormation                       *_dateFormatter;
    
    IBOutlet UITableView                *_detailTableView;
    IBOutlet UITableViewCell            *_detailTransportConnectionTableCell;
    IBOutlet UITableViewCell            *_detailTransportSectionTableCell;
    
    ConnectionDto                       *_actualConnection;
    
}

@property (nonatomic, retain) IBOutlet UINavigationBar              *_titleNavigationBar;
@property (nonatomic, retain) IBOutlet UINavigationItem             *_titleNavigationItem;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleLabel;
@property (nonatomic, retain) IBOutlet UILabel                      *_descriptionLabel;

@property (nonatomic, retain) IBOutlet UITableView                  *_detailTableView;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_detailTransportConnectionTableCell;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_detailTransportSectionTableCell;

@property (strong, nonatomic) ColorSelection                        *_zhawColor;
@property (nonatomic, retain) DateFormation                         *_dateFormatter;
@property (strong, nonatomic) ConnectionDto                         *_actualConnection;

@end
