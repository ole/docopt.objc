//
//  DocoptTestCasesTests.m
//  docopt
//
//  Created by Ole Begemann on 21.03.13.
//
//

#import "DocoptTestCasesTests.h"
#import "DocoptTestCaseParser.h"

@interface DocoptTestCasesTests()

@property (strong, nonatomic) DocoptTestCaseParser *parser;

@end


@implementation DocoptTestCasesTests

- (void)setUp
{
}

- (void)tearDown
{
}

- (void)testTestCases
{
    NSString *testCases = [NSString stringWithContentsOfFile:@"/Users/elo/code/docopt/testcases.docopt" encoding:NSUTF8StringEncoding error:NULL];
    self.parser = [[DocoptTestCaseParser alloc] initWithString:testCases];
}

@end
