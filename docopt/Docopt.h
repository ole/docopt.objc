//
//  Docopt.h
//  docopt
//
//  Created by Ole Begemann on 22.03.13.
//
//

#import <Foundation/Foundation.h>

@interface Docopt : NSObject

- (instancetype)initWithUsageDocumentation:(NSString *)usageDocumentation arguments:(NSString *)arguments;

@property (copy, nonatomic, readonly) NSString *usageDocumentation;
@property (strong, nonatomic, readonly) id result;

@end
