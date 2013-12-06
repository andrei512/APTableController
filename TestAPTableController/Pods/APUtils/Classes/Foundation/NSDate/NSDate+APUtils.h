//
//  NSDate+APUtils.h
//
//  Created by Andrei Puni on 5/21/13.
//

#import <Foundation/Foundation.h>

@interface NSDate (APUtils)

#pragma mark - Time Intervals

+ (NSDictionary *)timeIntervalNamed:(NSString *)intervalName;

+ (NSDictionary *)timeIntervalWithBeginDate:(NSDate *)beginDate
                                 andEndDate:(NSDate *)endDate;

+ (NSDictionary *)todayTimeInterval;
+ (NSDictionary *)thisWeekTimeInterval;
+ (NSDictionary *)thisWeekendTimeInterval;
+ (NSDictionary *)sinceNowTimeInterval;

// returns the N-th day from a week
- (NSDate *)getWeekday:(int)weekdayNumber;

// keeps only the year, month and day of the month
- (NSDate *)simpleDate;

#pragma mark - Date Formating

- (NSString *)formatedDate;

- (NSString *)formatedDateWithFormat:(NSString *)dateFormat;

#pragma mark - Time ago

- (NSUInteger) daysAgo;
- (NSUInteger) hoursAgo;
- (NSUInteger) daysAgoAgainstMidnight;
- (NSString *) stringDaysAgo;
- (NSString *) stringDaysAgoAgainstMidnight:(BOOL)flag;

#pragma mark - General

- (NSUInteger)weekday;
- (NSTimeInterval)unixTime;


@end
