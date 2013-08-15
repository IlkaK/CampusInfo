//
//  NewsViewController.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import <UIKit/UIKit.h>
#import <NewsChannelDto.h>


@interface NewsViewController : UIViewController
{
    NewsChannelDto      *_newsChannel;

    IBOutlet UILabel    *_titleLabel;
}

@property (strong, nonatomic) NewsChannelDto                        *_newsChannel;
@property (nonatomic, retain) IBOutlet UILabel                      *_titleLabel;

- (IBAction)_startNews:(id)sender;

- (IBAction)moveBackToMenuOverview:(id)sender;

@end
