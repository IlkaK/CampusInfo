//
//  Autocomplete.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 05.06.13.
//
//

#import <Foundation/Foundation.h>

@interface Autocomplete : NSObject
{
	NSMutableArray *_candidates;
}

@property (nonatomic, retain) NSMutableArray *_candidates;

- (Autocomplete *)initWithArray:(NSArray *)initialArray;
- (NSMutableArray *)GetSuggestions:(NSString *)root;
- (void)AddCandidate:(NSString *)candidate;


@end
