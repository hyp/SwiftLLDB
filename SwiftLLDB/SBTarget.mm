//
//  SBTarget.mm
//  SwiftLLDB
//

#import "SBTarget.h"
#import "SBTarget+Private.h"
#import "SBProcess.h"
#import "SBProcess+Private.h"
#import "SBBreakpoint.h"
#import "SBBreakpoint+Private.h"
#include "LLDB/LLDB.h"
#include "LLDB/SBTarget.h"

@implementation SBTarget {
    lldb::SBTarget target;
}

- (void) setTarget: (void *)p {
    assert(p);
    target = *(lldb::SBTarget *)p;
}

- (BOOL) isValid {
    return target.IsValid();
}

- (SBProcess *) process {
    SBProcess *process = [SBProcess new];
    lldb::SBProcess llProcess = target.GetProcess();
    process.process = &llProcess;
    return process;
}

- (NSInteger) numBreakpoints {
    return target.GetNumBreakpoints();
}

- (SBBreakpoint *) breakpointCreateByLocation: (NSString *)file line:(NSInteger)line {
    lldb::SBBreakpoint llBr = target.BreakpointCreateByLocation([file fileSystemRepresentation], (uint32_t)line);
    SBBreakpoint *br = [SBBreakpoint new];
    br.breakpoint = &llBr;
    return br;
}

- (SBBreakpoint *) findBreakpointById: (NSInteger)breakId {
    lldb::SBBreakpoint llBr = target.FindBreakpointByID((lldb::break_id_t)breakId);
    SBBreakpoint *br = [SBBreakpoint new];
    br.breakpoint = &llBr;
    return br;
}

@end

