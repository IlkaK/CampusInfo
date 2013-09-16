//
//  URLConstantStrings.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 16.09.13.
//
//

#import "URLConstantStrings.h"

@implementation URLConstantStrings


// used in scheduleDto
//NSString * const URLTimeTable = @"https://srv-lab-t-874.zhaw.ch/v1/schedules/%@/%@?startingAt=%@&days=7";
NSString * const URLTimeTable = @"https://api.apps.engineering.zhaw.ch/v1/schedules/%@/%@?startingAt=%@&days=7";

// used in gastronomicFacilityArrayDto
//NSString * const URLGastroArray = @"https://srv-lab-t-874.zhaw.ch/v1/catering/facilities";
NSString * const URLGastroArray = @"https://api.apps.engineering.zhaw.ch/v1/catering/facilities";

// used in menuPlanArrayDto
//NSString * const URLMenuPlanArray = @"https://srv-lab-t-874.zhaw.ch/v1/catering/menuplans/years/%i/weeks/%i/";
NSString * const URLMenuPlanArray = @"https://api.apps.engineering.zhaw.ch/v1/catering/menuplans/years/%i/weeks/%i/";

// used in studentsDto
//NSString * const URLStudents = @"https://srv-lab-t-874.zhaw.ch/v1/schedules/students/";
NSString * const URLStudents = @"https://api.apps.engineering.zhaw.ch/v1/schedules/students/";

// used in lecturersDto
//NSString * const URLLecturers = @"https://srv-lab-t-874.zhaw.ch/v1/schedules/lecturers/";
NSString * const URLLecturers = @"https://api.apps.engineering.zhaw.ch/v1/schedules/lecturers/";

// used in coursesDto
//NSString * const URLCourses = @"https://srv-lab-t-874.zhaw.ch/v1/schedules/courses/";
NSString * const URLCourses = @"https://api.apps.engineering.zhaw.ch/v1/schedules/courses/";

// used in roomsDto
//NSString * const URLRooms = @"https://srv-lab-t-874.zhaw.ch/v1/schedules/rooms/";
NSString * const URLRooms = @"https://srv-lab-t-874.zhaw.ch/v1/schedules/rooms/";

// used in classesDto
//NSString * const URLClasses = @"https://srv-lab-t-874.zhaw.ch/v1/schedules/classes/";
NSString * const URLClasses = @"https://api.apps.engineering.zhaw.ch/v1/schedules/classes/";

// used in newsChannelDto
//NSString * const URLNewsFeed = @"https://srv-lab-t-874.zhaw.ch/v1/feeds/soe-news/feed";
NSString * const URLNewsFeed = @"https://api.apps.engineering.zhaw.ch/v1/feeds/soe-news/feed";

//NSString * const URLEventsFeed = @"https://srv-lab-t-874.zhaw.ch/v1/feeds/soe-events/feed";
NSString * const URLEventsFeed = @"https://api.apps.engineering.zhaw.ch/v1/feeds/soe-events/feed";

// used in connectionArrayDto
//NSString * const URLTransportConnections = @"https://srv-lab-t-874.zhaw.ch/transport/web/api.php/v1/connections?from=%@&to=%@";
NSString * const URLTransportConnections = @"https://api.apps.engineering.zhaw.ch/transport/web/api.php/v1/connections?from=%@&to=%@";

// used in stationArrayDto
//NSString * const URLStations = @"https://srv-lab-t-874.zhaw.ch/transport/web/api.php/v1/locations?query=%@";
NSString * const URLStations = @"https://api.apps.engineering.zhaw.ch/transport/web/api.php/v1/locations?query=%@";

@end
