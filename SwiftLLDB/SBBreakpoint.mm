//
//  SBBreakpoint.mm
//  SwiftLLDB
//

#import "SBBreakpoint.h"
#import "SBBreakpoint+Private.h"
#import "SBAddress.h"
#import "SBAddress+Private.h"
#include "LLDB/LLDB.h"
#include "LLDB/SBBreakpoint.h"

// Mark - Location

@implementation SBBreakpointLocation {
    lldb::SBBreakpointLocation location;
}

- (void) setBreakpointLocation:(void *)p {
    assert(p);
    location = *(lldb::SBBreakpointLocation *)p;
}

- (NSInteger) breakpointLocationId {
    return location.GetID();
}

- (BOOL) isValid {
    return location.IsValid();
}

- (BOOL) isResolved {
    return location.IsResolved();
}

- (SBAddress *) address {
    lldb::SBAddress llAddress = location.GetAddress();
    SBAddress *address = [SBAddress new];
    address.address = &llAddress;
    return address;
}

@end

// Mark - Breakpoint

@implementation SBBreakpoint {
    lldb::SBBreakpoint breakpoint;
}

- (void) setBreakpoint:(void *)p {
    assert(p);
    breakpoint = *(lldb::SBBreakpoint *)p;
}

- (NSInteger) breakpointId {
    return (NSInteger)breakpoint.GetID();
}

- (BOOL) isValid {
    return breakpoint.IsValid();
}

- (BOOL) enabled {
    return breakpoint.IsEnabled();
}

- (void) setEnabled:(BOOL)enabled {
    breakpoint.SetEnabled(enabled);
}

- (BOOL) isOneShot {
    return breakpoint.IsOneShot();
}

- (BOOL) isInternal {
    return breakpoint.IsInternal();
}

- (NSInteger) hitCount {
    return (NSInteger)breakpoint.GetHitCount();
}

- (NSInteger) numLocations {
    return (NSInteger)breakpoint.GetNumLocations();
}

- (SBBreakpointLocation *) findLocationById:(NSInteger)locId {
    lldb::SBBreakpointLocation llLoc = breakpoint.FindLocationByID((lldb::break_id_t)locId);
    SBBreakpointLocation *loc = [SBBreakpointLocation new];
    loc.breakpointLocation = &llLoc;
    return loc;
}

@end

