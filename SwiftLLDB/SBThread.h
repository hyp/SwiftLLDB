//
//  SBThread.h
//  SwiftLLDB
//

#import "Enumerations.h"
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBThread : NSObject

@property (readonly, nonatomic) BOOL isValid;
@property (readonly, nonatomic) BOOL isSuspended;
@property (readonly, nonatomic) BOOL isStopped;
@property (readonly, nonatomic) NSString *name;
@property (readonly, nonatomic) StopReason stopReason;
@property (readonly, nonatomic) NSInteger stopReasonDataCount;

- (uint64_t) getStopReasonDataAtIndex: (NSInteger)idx;

@end

NS_ASSUME_NONNULL_END
