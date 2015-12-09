//
//  SBBreakpoint.h
//  SwiftLLDB
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface SBBreakpointLocation : NSObject

@property (readonly, nonatomic) NSInteger breakpointLocationId;
@property (readonly, nonatomic) BOOL isValid;
@property (readonly, nonatomic) BOOL isResolved;

@end

@interface SBBreakpoint : NSObject

@property (readonly, nonatomic) NSInteger breakpointId;
@property (readonly, nonatomic) BOOL isValid;
@property (nonatomic) BOOL enabled;
@property (readonly, nonatomic) BOOL isOneShot;
@property (readonly, nonatomic) BOOL isInternal;
@property (readonly, nonatomic) NSInteger hitCount;
@property (readonly, nonatomic) NSInteger numLocations;

- (SBBreakpointLocation *) findLocationById: (NSInteger)locId;

@end

NS_ASSUME_NONNULL_END
