//
//  SBProcess.h
//  SwiftLLDB
//

#import "Enumerations.h"
#import <Foundation/Foundation.h>

@class SBThread;

NS_ASSUME_NONNULL_BEGIN

@interface SBProcess : NSObject

@property (readonly, nonatomic) BOOL isValid;
@property (readonly, nonatomic) StateType state;

@property (readonly, nonatomic) NSInteger numThreads;
@property (readonly, nonatomic) SBThread *selectedThread;
- (SBThread *) threadAtIndex: (NSInteger)idx;

- (BOOL) destroy: (NSError **)error;

@end

NS_ASSUME_NONNULL_END
