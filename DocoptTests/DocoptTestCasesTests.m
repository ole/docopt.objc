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

- (void)testFixturesFileExists
{
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    BOOL fileExists = [fileManager fileExistsAtPath:[self fixturesFilePath]];
    STAssertTrue(fileExists, @"Fixtures file testcases.docopt does not exist in testing bundle");
}

- (void)testFixturesFileCanBeOpened
{
    STAssertNotNil([self fixturesFileContents], @"Could not read fixtures file");
}

- (void)testTestCases
{
    NSString *rawTestCases = [self fixturesFileContents];
    self.parser = [[DocoptTestCaseParser alloc] initWithString:rawTestCases];
    
    for (DocoptTestCase *testCase in self.parser.testCases) {
        Docopt *docopt = [[Docopt alloc] initWithUsageDocumentation:testCase.usageDocumentation arguments:testCase.arguments];
        STAssertEqualObjects(docopt.result, testCase.expectedOutput, @"Test %@ failed", testCase.name);
    }
}

#pragma mark - Helper methods

- (NSString *)fixturesFilePath
{
    NSBundle *testingBundle = [NSBundle bundleForClass:[self class]];
    return [testingBundle pathForResource:@"testcases" ofType:@"docopt"];
}

- (NSString *)fixturesFileContents
{
    NSError *error = nil;
    NSString *fileContents = [NSString stringWithContentsOfFile:[self fixturesFilePath] encoding:NSUTF8StringEncoding error:&error];
    return fileContents;
}

@end
