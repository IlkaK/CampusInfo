//
//  NewsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import <UIKit/UIKit.h>
#import <NewsChannelDto.h>


@interface NewsViewController : UIViewController<UITableViewDelegate>
{
    NewsChannelDto                  *_newsChannel;

    IBOutlet UILabel                *_titleLabel;
    IBOutlet UITableView            *_newsTable;
    IBOutlet UITableViewCell        *_newsTableCell;
    
    DateFormation                   *_dateFormatter;
}

@property (strong, nonatomic) NewsChannelDto                        *_newsChannel;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleLabel;

@property (nonatomic, retain) IBOutlet UITableView                  *_newsTable;
@property (nonatomic, retain) IBOutlet UITableViewCell              *_newsTableCell;

@property (nonatomic, retain) DateFormation                         *_dateFormatter;

- (IBAction)_startNews:(id)sender;

- (IBAction)moveBackToMenuOverview:(id)sender;

@end
