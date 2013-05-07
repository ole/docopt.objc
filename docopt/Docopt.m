//
//  Docopt.m
//  docopt
//
//  Created by Ole Begemann on 22.03.13.
//
//

#import "Docopt.h"

@interface Docopt ()

@property (copy, nonatomic) NSString *arguments;
@property (strong, nonatomic, readwrite) id result;

@end


@implementation Docopt

- (instancetype)initWithUsageDocumentation:(NSString *)usageDocumentation arguments:(NSString *)arguments
{
    self = [super init];
    if (self) {
        _usageDocumentation = [usageDocumentation copy];
        _arguments = [arguments copy];
        [self parse];
    }
    return self;
}


/*
 *  This method should parse the usage string in self.usageDocumentation and the
 *  command line arguments passed in self.arguments and write an NSDictionary into
 *  self.result that lists the arguments and their values according to the docopt
 *  implementation at http://docopt.org.
 */
- (void)parse
{
    self.result = @"user-error";
}

@end
