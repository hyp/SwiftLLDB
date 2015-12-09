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
    target = *(lldb::SBTarget *)p;
}

- (BOOL) isValid {
    return target.IsValid();
}

- (SBProcess *) process {
    SBProcess *process = [[SBProcess alloc] init];
    lldb::SBProcess llProcess = target.GetProcess();
    [process setProcess: &llProcess];
    return process;
}

- (NSInteger) numBreakpoints {
    return target.GetNumBreakpoints();
}

- (SBBreakpoint *) findBreakpointById: (NSInteger)breakId {
    lldb::SBBreakpoint llBr = target.FindBreakpointByID((lldb::break_id_t)breakId);
    SBBreakpoint *br = [[SBBreakpoint alloc] init];
    [br setBreakpoint:&llBr];
    return br;
}

@end

