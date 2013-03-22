//
//  DocoptTestCaseParser.h
//  docopt
//
//  Created by Ole Begemann on 21.03.13.
//
//

#import <Foundation/Foundation.h>
#import "DocoptTestCase.h"

@interface DocoptTestCaseParser : NSObject

- (instancetype)initWithString:(NSString *)stringOfTestCases;

@property (strong, nonatomic, readonly) NSArray *testCases;

@end
