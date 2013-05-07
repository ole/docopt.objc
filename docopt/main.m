//
//  main.m
//  docopt
//
//  Created by Ole Begemann on 03/20/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Docopt.h"

int main(int argc, const char * argv[])
{
    @autoreleasepool {
        // Assign proper usage string to usageDocumentation here
        NSString *usageDocumentation = @"Usage: ...";
        
        // Use arguments passed from command line
        NSString *arguments = [[[NSProcessInfo processInfo] arguments] componentsJoinedByString:@" "];
        
        // Parse with Docopt
        Docopt *docopt = [[Docopt alloc] initWithUsageDocumentation:usageDocumentation arguments:arguments];
        NSLog(@"Docopt result:\n%@", docopt.result);
    }
    return 0;
}
