//
//  NewsImageDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 15.08.13.
//
//

#import <Foundation/Foundation.h>

@interface NewsImageDto : NSObject
{
    NSString                    *_title;
    NSString                    *_link;
    NSString                    *_description;
    NSString                    *_imgURL;
    int                         _width;
    int                         _height;
}

@property (nonatomic, retain) NSString                       *_title;
@property (nonatomic, retain) NSString                       *_link;
@property (nonatomic, retain) NSString                       *_description;
@property (nonatomic, retain) NSString                       *_imgURL;
@property (nonatomic, assign) int                            _width;
@property (nonatomic, assign) int                            _height;

-(id) init : (NSString *) newTitle
           : (NSString *) newLink
           : (NSString *) newDescription
           : (NSString *) newImgURL
           :(int)newWidth
           :(int)newHeight;


@end
