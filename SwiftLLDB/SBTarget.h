//
//  SBTarget.h
//  SwiftLLDB
//

#import <Foundation/Foundation.h>

@class SBProcess;
@class SBBreakpoint;

NS_ASSUME_NONNULL_BEGIN

@interface SBTarget : NSObject

@property (readonly, nonatomic) BOOL isValid;
@property (readonly, nonatomic) SBProcess *process;
@property (readonly, nonatomic) NSInteger numBreakpoints;

- (SBBreakpoint *) findBreakpointById: (NSInteger)breakId;

@end

NS_ASSUME_NONNULL_END
