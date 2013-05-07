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

- (void)parse
{
    self.result = @"user-error";
}

@end
