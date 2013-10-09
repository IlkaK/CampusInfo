/*
 Autocomplete.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header Autocomplete.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Handling autocomplete functionality, which means the candidate array is set via function AddCandidate and suggestions for autocompletion are got via GetSuggestions. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> The class receives an initial array for the candidates (initWithArray). Other candidates can be added via AddCandidate. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> With method GetSuggestions an array is given back to caller which includes all possible matches (suggestions) for given string. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "Autocomplete.h"

@implementation Autocomplete

@synthesize _candidates;

/*!
 @function initWithArray
 Initialization of the class and especially the candidates array.
 @param initialArray
 */
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

/*!
 @function GetSuggestions
 Get suggestions for given input string out of stored array.
 @param root
 */
- (NSMutableArray *)GetSuggestions:(NSString *)root
{
	if ([root length] == 0)
	{
		return _candidates;
	}
	
	NSPredicate *startPredicate = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[c] %@", root];
	return [NSMutableArray arrayWithArray:[_candidates filteredArrayUsingPredicate:startPredicate]];
}

/*!
 @function AddCandidate
 Add new candidate to stored array.
 @param candidate
 */
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