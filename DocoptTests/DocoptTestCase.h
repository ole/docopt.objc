//
//  DocoptTestCase.h
//  docopt
//
//  Created by Ole Begemann on 22.03.13.
//
//

#import <Foundation/Foundation.h>

@interface DocoptTestCase : NSObject

- (instancetype)initWithProgramName:(NSString *)programName arguments:(NSString *)arguments expectedOutput:(NSDictionary *)expectedOutput;

@property (copy, nonatomic) NSString *name;
@property (copy, nonatomic) NSString *usageDocumentation;
@property (copy, nonatomic, readonly) NSString *programName;
@property (copy, nonatomic, readonly) NSString *arguments;
@property (copy, nonatomic, readonly) id expectedOutput;

@end
