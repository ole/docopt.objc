//
//  DocoptTestCaseParser.m
//  docopt
//
//  Created by Ole Begemann on 21.03.13.
//
//

#import "DocoptTestCaseParser.h"
#import "DocoptTestCase.h"

@interface DocoptTestCaseParser ()

@property (strong, nonatomic, readwrite) NSArray *testCases;

@end


@implementation DocoptTestCaseParser

- (instancetype)initWithString:(NSString *)stringOfTestCases
{
    self = [super init];
    if (self) {
        _testCases = [self parseStringOfTestCases:stringOfTestCases];
    }
    return self;
}

- (NSArray *)parseStringOfTestCases:(NSString *)stringOfTestCases
{
    NSParameterAssert(stringOfTestCases);
    
    NSString *fixturesWithCommentsStripped = [self stringByRemovingCommentsFromString:stringOfTestCases];
    NSArray *fixtures = [self fixturesFromStringOfFixtures:fixturesWithCommentsStripped];
    NSArray *testCases = [self testCasesFromArrayOfFixtureStrings:fixtures];
    
    NSLog(@"%@", testCases);
    
    return testCases;
}

- (NSString *)stringByRemovingCommentsFromString:(NSString *)sourceString
{
    NSError *error = nil;
    NSRegularExpression *removeComments = [NSRegularExpression regularExpressionWithPattern:@"(?m)#.*$" options:0 error:&error];
    if (removeComments == nil) {
        NSLog(@"Error creating regular expression for removing comments: %@", error);
        return sourceString;
    }
    
    NSRange fullRange = NSMakeRange(0, [sourceString length]);
    return [removeComments stringByReplacingMatchesInString:sourceString options:0 range:fullRange withTemplate:@""];
}

- (NSArray *)fixturesFromStringOfFixtures:(NSString *)fixturesWithCommentsStripped
{
    NSArray *fixtures = [fixturesWithCommentsStripped componentsSeparatedByString:@"r\"\"\""];
    return [self arrayByRemovingStringsContainingOnlyWhitespaceFromArray:fixtures];
}

- (NSArray *)testCasesFromArrayOfFixtureStrings:(NSArray *)fixtures
{
    NSMutableArray *allTestCases = [NSMutableArray new];
    NSString *testBasename = @"Test";
    NSUInteger testIndex = 1;
    for (NSString *fixtureString in fixtures) {
        NSArray *newTestCases = [self testCasesFromFixtureString:fixtureString];
        for (DocoptTestCase *testCase in newTestCases) {
            testCase.name = [NSString stringWithFormat:@"%@%lu", testBasename, (unsigned long)testIndex];
            testIndex++;
        }
        [allTestCases addObjectsFromArray:newTestCases];
    }
    return [NSArray arrayWithArray:allTestCases];
}

- (NSArray *)testCasesFromFixtureString:(NSString *)fixtureString
{
    NSMutableArray *testCases = [NSMutableArray new];
    
    NSArray *fixtureComponents = [fixtureString componentsSeparatedByString:@"\"\"\""];
    NSAssert1([fixtureComponents count] == 2, @"Could not split fixture: %@ into components", fixtureString);
    NSString *usageDocumentation = fixtureComponents[0];
    
    NSString *testInvocationsString = fixtureComponents[1];
    NSArray *testInvocations = [self testInvocationsFromStringOfTestInvocations:testInvocationsString];
    for (NSString *testInvocation in testInvocations) {
        DocoptTestCase *testCase = [self testCaseFromInvocationString:testInvocation];
        if (testCase) {
            testCase.usageDocumentation = usageDocumentation;
            [testCases addObject:testCase];
        }
    }
    
    return testCases;
}

- (NSArray *)testInvocationsFromStringOfTestInvocations:(NSString *)testInvocationsString
{
    NSArray *testInvocations = [testInvocationsString componentsSeparatedByString:@"$ "];
    return [self arrayByRemovingStringsContainingOnlyWhitespaceFromArray:testInvocations];
}

- (DocoptTestCase *)testCaseFromInvocationString:(NSString *)testInvocation
{
    NSString *trimmedTestInvocation = [testInvocation stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSMutableArray *testInvocationComponents = [[trimmedTestInvocation componentsSeparatedByString:@"\n"] mutableCopy];
    NSAssert1([testInvocationComponents count] >= 2, @"Could not split test case: %@ into components", trimmedTestInvocation);
    
    NSString *input = testInvocationComponents[0]; // first line
    [testInvocationComponents removeObjectAtIndex:0];
    NSString *expectedOutput = [testInvocationComponents componentsJoinedByString:@"\n"]; // all remaining lines
    
    NSMutableArray *inputComponents = [[input componentsSeparatedByString:@" "] mutableCopy];
    NSString *programName = inputComponents[0]; // first part
    [inputComponents removeObjectAtIndex:0];
    NSString *arguments = [inputComponents componentsJoinedByString:@" "];
    
    NSError *error = nil;
    id expectedOutputJSON = [NSJSONSerialization JSONObjectWithData:[expectedOutput dataUsingEncoding:NSUTF8StringEncoding] options:NSJSONReadingAllowFragments error:&error];
    if (expectedOutputJSON == nil) {
        NSLog(@"Error parsing %@ to JSON: %@", expectedOutput, error);
        return nil;
    }
    
    DocoptTestCase *testCase = [[DocoptTestCase alloc] initWithProgramName:programName arguments:arguments expectedOutput:expectedOutputJSON];
    return testCase;
}

- (NSArray *)arrayByRemovingStringsContainingOnlyWhitespaceFromArray:(NSArray *)sourceArray
{
    NSPredicate *whitespaceFilter = [NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        NSString *trimmedString = [evaluatedObject stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        return ![trimmedString isEqualToString:@""];
    }];
    return [sourceArray filteredArrayUsingPredicate:whitespaceFilter];
}

@end
