//
//  DocoptTestCasesTests.h
//  docopt
//
//  Created by Ole Begemann on 21.03.13.
//
//

#import <SenTestingKit/SenTestingKit.h>

/*
 *  This class parses the official docopt test cases file (testcases.docopt)
 *  and runs the Docopt parser against the test cases defined in that file.
 *  It issues one STAssert... failure for each failing test case.
 */
@interface DocoptTestCasesTests : SenTestCase

@end
