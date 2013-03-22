//
//  DocoptTestCasesTests.m
//  docopt
//
//  Created by Ole Begemann on 21.03.13.
//
//

#import "DocoptTestCasesTests.h"
#import "DocoptTestCaseParser.h"
#import "Docopt.h"

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
    NSString *rawTestCases = [NSString stringWithContentsOfFile:@"/Users/elo/code/docopt/testcases.docopt" encoding:NSUTF8StringEncoding error:NULL];
    self.parser = [[DocoptTestCaseParser alloc] initWithString:rawTestCases];
    
    for (DocoptTestCase *testCase in self.parser.testCases) {
        Docopt *docopt = [[Docopt alloc] initWithUsageDocumentation:testCase.usageDocumentation arguments:testCase.arguments];
        STAssertEqualObjects(docopt.result, testCase.expectedOutput, @"Test %@ failed", testCase.name);
    }
}

@end
