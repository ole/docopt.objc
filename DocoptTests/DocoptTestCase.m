//
//  DocoptTestCase.m
//  docopt
//
//  Created by Ole Begemann on 22.03.13.
//
//

#import "DocoptTestCase.h"

@implementation DocoptTestCase

- (instancetype)initWithProgramName:(NSString *)programName arguments:(NSString *)arguments expectedOutput:(NSDictionary *)expectedOutput
{
    self = [super init];
    if (self) {
        _programName = [programName copy];
        _arguments = [arguments copy];
        _expectedOutput = [expectedOutput copy];
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"%@ <%p> %@\n\n  %@\n  %@ %@ => %@", [self class], self, self.name, self.usageDocumentation, self.programName, self.arguments, self.expectedOutput];
}

@end
