//
//  Autocomplete.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 05.06.13.
//
//

#import "Autocomplete.h"

@implementation Autocomplete

@synthesize _candidates;

- (Autocomplete *)initWithArray:(NSMutableArray *)initialArray
{
	self = [super init];
	if (self)
	{
		_candidates = [[NSMutableArray alloc] initWithArray:initialArray];
		[_candidates sortUsingSelector:@selector(compare:)];
	}
	
	return self;
}

- (NSMutableArray *)GetSuggestions:(NSString *)root
{
	if ([root length] == 0)
	{
		return _candidates;
	}
	
	NSPredicate *startPredicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[c] %@", root];
	return [NSMutableArray arrayWithArray:[_candidates filteredArrayUsingPredicate:startPredicate]];
}

- (void)AddCandidate:(NSString *)candidate
{
	//Is the candidate already in the list?
	for (int i = 0; i < [_candidates count]; i++)
	{
		if ([[_candidates objectAtIndex:i] isEqualToString:candidate])
		{
			return;
		}
	}
	
	//Add the new candidate
	[_candidates addObject:candidate];
	[_candidates sortUsingSelector:@selector(compare:)];
}


@end